import 'dart:async';

import 'package:flutter/material.dart';

import '../../enums/button_type.dart';
import '../../models/forms/form.dart';
import '../../models/forms/inputs/base.dart';
import '../../models/forms/inputs/checkbox.dart';
import '../../models/forms/inputs/dropdown.dart';
import '../../models/forms/inputs/image.dart';
import '../../models/forms/inputs/text.dart';
import '../../utilities/local_storage.dart';
import '../../utilities/string_formatter.dart';
import '../../utilities/style_constants.dart';
import '../button.dart';
import '../loading_indicator.dart';
import 'inputs/checkbox.dart';
import 'inputs/dropdown.dart';
import 'inputs/image.dart';
import 'inputs/text.dart';

class WickWidgetForm extends StatefulWidget {
  final FormModel form;

  // TODO Use types instead
  final Function(Map<String, String>) onSubmit;
  final Function()? onCancel;

  const WickWidgetForm({
    super.key,
    required this.form,
    required this.onSubmit,
    this.onCancel,
  });

  @override
  State<WickWidgetForm> createState() => _WickWidgetFormState();
}

class _WickWidgetFormState extends State<WickWidgetForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, String> formValues = {};
  Timer? _debounceTimer;
  late FocusNode firstInputFocusNode;

  @override
  void initState() {
    super.initState();
    firstInputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    firstInputFocusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: _buildFormContent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Form(
            key: formKey,
            child: SizedBox(
              width:
                  double.infinity < StyleConstants.wideWidthSize
                      ? double.infinity
                      : StyleConstants.wideWidthSize,
              child: Column(children: snapshot.data ?? []),
            ),
          );
        } else {
          return const WickWidgetLoadingIndicator();
        }
      },
    );
  }

  Future<List<Widget>> _buildFormContent() async {
    List<Widget> content = [];
    bool firstInputAssigned = false;
    for (WickFormInputBase input in widget.form.inputs) {
      final String inputKey = StringFormatter.toSnakeCase(input.name);
      final String localStorageKey =
          "form_${StringFormatter.toSnakeCase(widget.form.name)}_input_$inputKey";
      final String? locallySavedValue =
          input.defaultValue == null && input.autoFill == true
              ? await LocalStorage().getStringValue(localStorageKey)
              : null;
      final String? defaultValue = input.defaultValue ?? locallySavedValue;
      if (defaultValue != null) {
        formValues[inputKey] = defaultValue;
      }
      onChanged(String? value) {
        if (value == null) {
          formValues.remove(inputKey);
        } else {
          formValues[inputKey] = value;
        }
        if (input.autoFill) {
          LocalStorage().setStringValue(localStorageKey, value);
        }
        if (widget.form.autoSubmit) {
          _submitForm();
        }
      }

      if (input is TextModel) {
        content.add(
          WickWidgetFormInputText(
            input: input,
            onChanged: onChanged,
            onEnterPressed: () {
              if (input == widget.form.inputs.last) {
                _submitForm();
              }
            },
            focusNode:
                widget.form.autoFocus && !firstInputAssigned
                    ? firstInputFocusNode
                    : null,
          ),
        );
        if (!firstInputAssigned) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            firstInputFocusNode.requestFocus();
          });
        }
      } else if (input is DropdownModel) {
        content.add(
          WickWidgetFormInputDropdown(input: input, onChanged: onChanged),
        );
      } else if (input is ImageModel) {
        content.add(
          WickWidgetFormInputImage(input: input, onChanged: onChanged),
        );
      } else if (input is CheckboxModel) {
        content.add(
          WickWidgetFormInputCheckbox(input: input, onChanged: onChanged),
        );
      }
      firstInputAssigned = true;
      content.add(const SizedBox(height: StyleConstants.contentGapSize));
    }
    content.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.onCancel != null)
            WickButton(
              onPressed: widget.onCancel!,
              message: "Cancel",
              type: WickButtonType.text,
            ),
          if (widget.onCancel != null)
            const SizedBox(width: StyleConstants.contentGapSize),
          if (!widget.form.autoSubmit)
            WickButton(
              onPressed: _submitForm,
              message: widget.form.submitButtonText,
            ),
        ],
      ),
    );
    return content;
  }

  void _submitForm() {
    if (widget.form.autoSubmit) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(widget.form.debounce, () {
        if (formKey.currentState!.validate()) {
          widget.onSubmit(formValues);
        }
      });
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      if (formKey.currentState!.validate()) {
        widget.onSubmit(formValues);
      }
    }
  }
}
