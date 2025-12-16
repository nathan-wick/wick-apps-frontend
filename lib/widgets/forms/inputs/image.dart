import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../enums/button_type.dart';
import '../../../enums/image_shapes.dart';
import '../../../models/form_inputs/image.dart';
import '../../../utilities/image_engine.dart';
import '../../../utilities/style_constants.dart';
import '../../button.dart';
import '../../dialog.dart';

class WickWidgetFormInputImage extends StatefulWidget {
  final WickModelFormInputImage input;
  final Function(Uint8List?) onChanged;

  const WickWidgetFormInputImage({
    super.key,
    required this.input,
    required this.onChanged,
  });

  @override
  State<WickWidgetFormInputImage> createState() =>
      _WickWidgetFormInputImageState();
}

class _WickWidgetFormInputImageState extends State<WickWidgetFormInputImage> {
  @override
  Widget build(BuildContext context) {
    Uint8List? image = widget.input.defaultValue;
    String? processingText;
    Future<void> pickImage() async {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          processingText = 'Reading file...';
        });
        Uint8List pickedImage = await pickedFile.readAsBytes();
        if (pickedImage.length > widget.input.maxSize.value) {
          bool shouldCompressImage = await _showTooLargeDialog();
          if (shouldCompressImage) {
            _showCompressingDialog();
            // TODO Fix screen freeze so that this isn't needed
            await Future.delayed(const Duration(milliseconds: 200));
            try {
              // TODO Compute this on another thread to stop screen freeze
              pickedImage = await WickUtilityImageEngine.compress(
                pickedImage,
                widget.input.maxSize,
              );
            } finally {
              // TODO Fix warning: Don't use 'BuildContext's across async gaps.
              Navigator.of(context).pop();
            }
          } else {
            setState(() {
              processingText = null;
            });
            return;
          }
        }
        setState(() {
          processingText = null;
          image = pickedImage;
        });
        widget.onChanged(pickedImage);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (processingText == null &&
                widget.input.shape == WickEnumImageShape.circle)
              CircleAvatar(
                radius: 35,
                backgroundImage: image != null ? MemoryImage(image!) : null,
                child:
                    image == null
                        ? const Icon(Icons.account_circle, size: 70)
                        : null,
              ),
            if (processingText != null)
              const SizedBox(
                width: 70,
                height: 70,
                child: Center(child: CircularProgressIndicator()),
              ),
            const SizedBox(width: WickUtilityStyleConstants.contentGapSize),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.input.name),
                const SizedBox(
                  height: WickUtilityStyleConstants.contentGapSize,
                ),
                Row(
                  children: [
                    WickWidgetButton(
                      onPressed: () {
                        pickImage();
                      },
                      message: "Upload",
                    ),
                    if (image != null)
                      const SizedBox(
                        width: WickUtilityStyleConstants.contentGapSize,
                      ),
                    if (image != null)
                      WickWidgetButton(
                        onPressed: () {
                          setState(() {
                            image = null;
                            widget.onChanged(null);
                          });
                        },
                        type: WickEnumButtonType.text,
                        message: "Remove",
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
        if (processingText != null)
          Text(processingText!, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Future<bool> _showTooLargeDialog() async {
    bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const WickWidgetDialog(
          icon: Icons.error,
          title: "File Too Large",
          content: [
            Text(
              "The selected file is too large. Would you like us to compress it?",
            ),
          ],
          okayMessage: "Compress",
        );
      },
    );
    return result ?? false;
  }

  void _showCompressingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const WickWidgetDialog(
          icon: Icons.compress,
          title: "Compressing File",
          content: [
            Text("The file is being compressed. This will take a minute."),
          ],
          displayActions: false,
        );
      },
    );
  }
}
