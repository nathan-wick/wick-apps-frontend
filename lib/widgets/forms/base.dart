import 'dart:async';

import 'package:flutter/material.dart';

import '../../enums/button_type.dart';
import '../../enums/log_type.dart';
import '../../models/form_inputs/base.dart';
import '../../models/form_inputs/checkbox.dart';
import '../../models/form_inputs/dropdown.dart';
import '../../models/form_inputs/image.dart';
import '../../models/form_inputs/text.dart';
import '../../utilities/local_storage.dart';
import '../../utilities/logger.dart';
import '../../utilities/string_formatter.dart';
import '../../utilities/style_constants.dart';
import '../../utilities/type_converter.dart';
import '../button.dart';
import '../loading_indicator.dart';
import 'inputs/checkbox.dart';
import 'inputs/dropdown.dart';
import 'inputs/image.dart';
import 'inputs/text.dart';

class WickWidgetFormBase extends StatefulWidget {
  final String name;
  final List<WickModelFormInputBase> inputs;
  final String submitButtonText;
  final bool autoSubmit;
  final bool autoFocus;
  final Duration debounce;
  final Function(Map<String, dynamic>) onSubmit;
  final Function()? onCancel;

  const WickWidgetFormBase({
    super.key,
    required this.name,
    required this.inputs,
    required this.onSubmit,
    this.submitButtonText = "Submit",
    this.autoSubmit = false,
    this.autoFocus = true,
    this.debounce = const Duration(seconds: 1),
    this.onCancel,
  });

  @override
  State<WickWidgetFormBase> createState() => _WickWidgetFormBaseState();
}

class _WickWidgetFormBaseState extends State<WickWidgetFormBase> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formValues = {};
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
    WickUtilityLogger.log(context, WickEnumLogType.form, {
      'method': 'buildFormContent',
      'inputs': widget.inputs,
    });
    for (WickModelFormInputBase input in widget.inputs) {
      final String inputKey = WickUtilityStringFormatter.toSnakeCase(
        input.name,
      );
      final String modelKey = WickUtilityStringFormatter.toCamelCase(
        input.name,
      );
      final String localStorageKey =
          "form_${WickUtilityStringFormatter.toSnakeCase(widget.name)}_input_$inputKey";
      onChanged(String? value) {
        if (value == null || value.isEmpty) {
          formValues.remove(modelKey);
        } else {
          formValues[modelKey] = value;
        }
        if (input.autoFill) {
          WickUtilityLocalStorage().setStringValue(localStorageKey, value);
        }
        if (widget.autoSubmit) {
          _submitForm();
        }
      }

      if (input is WickModelFormInputText) {
        _setDefaultValue(localStorageKey, input, input.defaultValue);
        content.add(
          WickWidgetFormInputText(
            input: input,
            onChanged: onChanged,
            onEnterPressed: () {
              if (input == widget.inputs.last) {
                _submitForm();
              }
            },
            focusNode:
                widget.autoFocus && !firstInputAssigned
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
        _setDefaultValue(localStorageKey, input, input.defaultValue);
        content.add(
          WickWidgetFormInputDropdown(input: input, onChanged: onChanged),
        );
      } else if (input is WickModelFormInputImage) {
        _setDefaultValue(localStorageKey, input, input.defaultValue);
        content.add(
          WickWidgetFormInputImage(input: input, onChanged: onChanged),
        );
      } else if (input is WickModelFormInputCheckbox) {
        _setDefaultValue(localStorageKey, input, input.defaultValue);
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
          if (!widget.autoSubmit)
            WickWidgetButton(
              onPressed: _submitForm,
              message: widget.submitButtonText,
            ),
        ],
      ),
    );
    return content;
  }

  Future<void> _setDefaultValue<T>(
    String localStorageKey,
    WickModelFormInputBase input,
    T? defaultValue,
  ) async {
    final T? locallySavedValue = WickUtilityTypeConverter.convert(
      defaultValue == null && input.autoFill == true
          ? await WickUtilityLocalStorage().getStringValue(localStorageKey)
          : null,
    );
    final T? value = defaultValue ?? locallySavedValue;
    if (defaultValue != null) {
      final String modelKey = WickUtilityStringFormatter.toCamelCase(
        widget.name,
      );
      formValues[modelKey] = value;
    }
  }

  void _submitForm() {
    WickUtilityLogger.log(context, WickEnumLogType.form, {
      'method': 'submitForm',
      'values': formValues,
    });
    if (widget.autoSubmit) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(widget.debounce, () {
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
