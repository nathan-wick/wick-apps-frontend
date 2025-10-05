import 'dart:typed_data';

import '../../../enums/file_sizes.dart';
import '../../../enums/image_shapes.dart';
import 'base.dart';

class WickModelFormInputImage extends WickModelFormInputBase {
  final WickEnumImageShape shape;
  final WickEnumFileSize maxSize;
  final Uint8List? defaultValue;

  WickModelFormInputImage({
    required super.name,
    super.autoFill,
    this.defaultValue,
    super.helpText,
    this.shape = WickEnumImageShape.square,
    this.maxSize = WickEnumFileSize.medium,
  });
}
