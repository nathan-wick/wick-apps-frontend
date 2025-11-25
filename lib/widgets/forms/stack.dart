import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wick_apps/controllers/base.dart';

import '../../enums/keyboard_type.dart';
import '../../enums/log_type.dart';
import '../../models/form_inputs/attribute.dart';
import '../../models/form_inputs/base.dart';
import '../../models/form_inputs/checkbox.dart';
import '../../models/form_inputs/dropdown.dart';
import '../../models/form_inputs/text.dart';
import '../../utilities/enum_helper.dart';
import '../../utilities/logger.dart';
import '../../utilities/model_helper.dart';
import '../../utilities/type_converter.dart';
import '../loading_indicator.dart';
import 'base.dart';

// TODO Only get and save used attributes

class WickWidgetFormStack<T> extends StatefulWidget {
  final String name;
  final List<WickModelFormInputAttribute> inputs;
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: _loadSavedState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return WickWidgetFormBase(
            name: widget.name,
            inputs: _getInputs(snapshot.data),
            submitButtonText: widget.submitButtonText,
            autoSubmit: widget.autoSubmit,
            autoFocus: widget.autoFocus,
            debounce: widget.debounce,
            onSubmit: _onSubmit,
            onCancel: widget.onCancel,
          );
        } else {
          return const WickWidgetLoadingIndicator();
        }
      },
    );
  }

  Future<T?> _loadSavedState() async {
    return await widget.controller.getByPrimaryKey(context, widget.primaryKey);
  }

  List<WickModelFormInputBase> _getInputs(T? savedState) {
    List<WickModelFormInputBase> inputs = [];
    for (WickModelFormInputAttribute input in widget.inputs) {
      final dynamic attributeValue = WickUtilityModelHelper.getAttributeValue(
        savedState,
        input.attribute.attributeName,
      );
      final dynamic defaultValue = attributeValue ?? input.defaultValue;
      if (input.attribute.attributeType == String) {
        inputs.add(
          WickModelFormInputText(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: defaultValue,
            helpText: input.helpText,
          ),
        );
      } else if (input.attribute.attributeType == int ||
          input.attribute.attributeType == double) {
        inputs.add(
          WickModelFormInputText(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: WickUtilityTypeConverter.convert(input.defaultValue),
            helpText: input.helpText,
            keyboardType: WickEnumKeyboardType.number,
          ),
        );
      } else if (input.attribute.attributeType == DateTime) {
        inputs.add(
          WickModelFormInputText(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: WickUtilityTypeConverter.convert(defaultValue),
            helpText: input.helpText,
            keyboardType: WickEnumKeyboardType.date,
          ),
        );
      } else if (input.attribute.attributeType == bool) {
        inputs.add(
          WickModelFormInputCheckbox(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: defaultValue,
            helpText: input.helpText,
          ),
        );
      } else if (input.attribute.attributeType == Enum) {
        inputs.add(
          WickModelFormInputDropdown(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: WickUtilityTypeConverter.convert(defaultValue),
            helpText: input.helpText,
            options: WickUtilityEnumHelper.getValuesAsDropdownOptions(
              input.attribute.attributeType,
            ),
          ),
        );
      } else if (input.attribute.attributeType == Uint8List) {
        // TODO Add an image input
      }
    }
    WickUtilityLogger.log(context, WickEnumLogType.form, {
      'method': 'getInputs',
      'savedState': savedState,
      'attributesToCreateInputsFor': widget.inputs,
      'createdInputs': inputs,
    });
    return inputs;
  }

  void _onSubmit(Map<String, dynamic> values) async {
    debugPrint("MEOW");
    debugPrint(values.toString());
    final T newModel = WickUtilityTypeConverter.convert(values);
    // TODO Accurately do the primary key. Erroring now. Maybe update values before model creation
    if (widget.primaryKey == null) {
      final createdModel = await widget.controller.create(context, newModel);
      if (createdModel != null && widget.afterSubmit != null) {
        await widget.afterSubmit!(createdModel);
      }
    } else {
      final updatedModel = await widget.controller.edit(context, newModel);
      if (updatedModel != null && widget.afterSubmit != null) {
        await widget.afterSubmit!(updatedModel);
      }
    }
  }
}
