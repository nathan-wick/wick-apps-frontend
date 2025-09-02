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
  final WickModelForm form;

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
                  double.infinity < WickUtilityStyleConstants.wideWidthSize
                      ? double.infinity
                      : WickUtilityStyleConstants.wideWidthSize,
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
    for (WickModelFormInputBase input in widget.form.inputs) {
      final String inputKey = WickUtilityStringFormatter.toSnakeCase(
        input.name,
      );
      final String WickUtilityLocalStorageKey =
          "form_${WickUtilityStringFormatter.toSnakeCase(widget.form.name)}_input_$inputKey";
      final String? locallySavedValue =
          input.defaultValue == null && input.autoFill == true
              ? await WickUtilityLocalStorage().getStringValue(
                WickUtilityLocalStorageKey,
              )
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
          WickUtilityLocalStorage().setStringValue(
            WickUtilityLocalStorageKey,
            value,
          );
        }
        if (widget.form.autoSubmit) {
          _submitForm();
        }
      }

      if (input is WickModelFormInputText) {
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
      } else if (input is WickModelFormInputDropdown) {
        content.add(
          WickWidgetFormInputDropdown(input: input, onChanged: onChanged),
        );
      } else if (input is WickModelFormInputImage) {
        content.add(
          WickWidgetFormInputImage(input: input, onChanged: onChanged),
        );
      } else if (input is WickModelFormInputCheckbox) {
        content.add(
          WickWidgetFormInputCheckbox(input: input, onChanged: onChanged),
        );
      }
      firstInputAssigned = true;
      content.add(
        const SizedBox(height: WickUtilityStyleConstants.contentGapSize),
      );
    }
    content.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.onCancel != null)
            WickWidgetButton(
              onPressed: widget.onCancel!,
              message: "Cancel",
              type: WickEnumButtonType.text,
            ),
          if (widget.onCancel != null)
            const SizedBox(width: WickUtilityStyleConstants.contentGapSize),
          if (!widget.form.autoSubmit)
            WickWidgetButton(
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
