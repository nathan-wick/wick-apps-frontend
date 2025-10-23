import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wick_apps/controllers/base.dart';

import '../../enums/keyboard_type.dart';
import '../../models/form_inputs/base.dart';
import '../../models/form_inputs/checkbox.dart';
import '../../models/form_inputs/dropdown.dart';
import '../../models/form_inputs/field.dart';
import '../../models/form_inputs/text.dart';
import '../../utilities/enum_helper.dart';
import '../../utilities/model_helper.dart';
import '../../utilities/type_converter.dart';
import 'base.dart';

// TODO Only get and save used attributes

class WickWidgetFormStack<T> extends StatefulWidget {
  final String name;
  final List<WickModelFormInputField> inputs;
  final WickControllerBase<T> controller;
  final int? primaryKey;
  final String submitButtonText;
  final bool autoSubmit;
  final bool autoFocus;
  final Duration debounce;
  final Future<void> Function(T)? afterSubmit;
  final VoidCallback? Function()? onCancel;

  const WickWidgetFormStack({
    super.key,
    required this.name,
    required this.inputs,
    required this.controller,
    this.primaryKey,
    this.afterSubmit,
    this.submitButtonText = "Submit",
    this.autoSubmit = false,
    this.autoFocus = true,
    this.debounce = const Duration(seconds: 1),
    this.onCancel,
  });

  @override
  State<WickWidgetFormStack<T>> createState() => _WickWidgetFormStackState<T>();
}

class _WickWidgetFormStackState<T> extends State<WickWidgetFormStack<T>> {
  T? _savedState;

  @override
  void initState() {
    super.initState();
    _loadSavedState();
  }

  @override
  Widget build(BuildContext context) {
    return WickWidgetFormBase(
      name: widget.name,
      inputs: _getInputs(),
      submitButtonText: widget.submitButtonText,
      autoSubmit: widget.autoSubmit,
      autoFocus: widget.autoFocus,
      debounce: widget.debounce,
      onSubmit: _onSubmit,
      onCancel: widget.onCancel,
    );
  }

  Future<void> _loadSavedState() async {
    final savedState = await widget.controller.getByPrimaryKey(
      context,
      widget.primaryKey,
    );
    if (savedState == null) return;
    setState(() {
      _savedState = savedState;
    });
  }

  List<WickModelFormInputBase> _getInputs() {
    List<WickModelFormInputBase> inputs = [];
    if (_savedState == null) return inputs;
    for (WickModelFormInputField input in widget.inputs) {
      final dynamic fieldValue = WickUtilityModelHelper.getAttributeValue(
        _savedState,
        input.fieldName,
      );
      if (fieldValue is Uint8List) {
        // TODO Add an image input
        continue;
      }
      final String fieldValueString = WickUtilityTypeConverter.convert(
        fieldValue,
      );
      if (fieldValue is String) {
        inputs.add(
          WickModelFormInputText(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: input.defaultValue ?? fieldValueString,
            helpText: input.helpText,
          ),
        );
      } else if (fieldValue is int || fieldValue is double) {
        inputs.add(
          WickModelFormInputText(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: input.defaultValue ?? fieldValueString,
            helpText: input.helpText,
            keyboardType: WickEnumKeyboardType.number,
          ),
        );
      } else if (fieldValue is DateTime) {
        inputs.add(
          WickModelFormInputText(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: input.defaultValue ?? fieldValueString,
            helpText: input.helpText,
            keyboardType: WickEnumKeyboardType.date,
          ),
        );
      } else if (fieldValue is bool) {
        inputs.add(
          WickModelFormInputCheckbox(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: input.defaultValue ?? fieldValueString,
            helpText: input.helpText,
          ),
        );
      } else if (fieldValue is Enum) {
        inputs.add(
          WickModelFormInputDropdown(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: input.defaultValue ?? fieldValueString,
            helpText: input.helpText,
            options: WickUtilityEnumHelper.getValuesAsDropdownOptions(
              fieldValue.runtimeType,
            ),
          ),
        );
      }
    }
    return inputs;
  }

  void _onSubmit(Map<String, dynamic> values) async {
    final T newModel = WickUtilityTypeConverter.convert(values);
    if (widget.primaryKey == null) {
      final createdModel = await widget.controller.create(context, newModel);
      if (createdModel != null) {
        setState(() {
          _savedState = createdModel;
        });
        if (widget.afterSubmit != null) {
          await widget.afterSubmit!(createdModel);
        }
      }
    } else {
      final updatedModel = await widget.controller.edit(context, newModel);
      if (updatedModel != null) {
        setState(() {
          _savedState = updatedModel;
        });
        if (widget.afterSubmit != null) {
          await widget.afterSubmit!(updatedModel);
        }
      }
    }
  }
}
