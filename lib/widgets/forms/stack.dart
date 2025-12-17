import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/controllers/base.dart';

import '../../enums/date_format.dart';
import '../../enums/keyboard_type.dart';
import '../../enums/log_type.dart';
import '../../enums/text_validation.dart';
import '../../models/form_inputs/attribute.dart';
import '../../models/form_inputs/base.dart';
import '../../models/form_inputs/checkbox.dart';
import '../../models/form_inputs/date.dart';
import '../../models/form_inputs/dropdown.dart';
import '../../models/form_inputs/text.dart';
import '../../models/preferences.dart';
import '../../providers/preferences.dart';
import '../../utilities/enum_helper.dart';
import '../../utilities/logger.dart';
import '../../utilities/model_helper.dart';
import '../../utilities/string_formatter.dart';
import '../../utilities/type_converter.dart';
import '../loading_indicator.dart';
import 'base.dart';

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
  WickEnumDateFormat? _dateFormat = WickEnumDateFormat.yearMonthDay;

  @override
  void initState() {
    super.initState();
    _getWickEnumDateFormat();
  }

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

  Future<void> _getWickEnumDateFormat() async {
    final WickModelPreferences? preferences =
        await Provider.of<WickProviderPreferences>(
          context,
          listen: false,
        ).getValue(context);
    if (preferences?.dateFormat != null) {
      setState(() {
        _dateFormat = preferences?.dateFormat;
      });
    }
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
        final List<WickEnumTextValidation> validations = [];
        if (input.name.toLowerCase().contains('email')) {
          validations.add(WickEnumTextValidation.email);
        }
        if (input.name.toLowerCase().contains('name')) {
          validations.add(WickEnumTextValidation.name);
        }
        inputs.add(
          WickModelFormInputText(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: WickUtilityTypeConverter.convert(
              defaultValue,
              dateFormat: _dateFormat,
            ),
            helpText: input.helpText,
            validations: validations,
          ),
        );
      } else if (input.attribute.attributeType == int ||
          input.attribute.attributeType == double) {
        inputs.add(
          // TODO Create a number input wrapper and use that instead
          WickModelFormInputText(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: WickUtilityTypeConverter.convert(
              defaultValue,
              dateFormat: _dateFormat,
            ),
            helpText: input.helpText,
            keyboardType: WickEnumKeyboardType.number,
          ),
        );
      } else if (input.attribute.attributeType == DateTime) {
        inputs.add(
          WickModelFormInputDate(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: WickUtilityTypeConverter.convert(
              defaultValue,
              dateFormat: _dateFormat,
            ),
            helpText: input.helpText,
          ),
        );
      } else if (input.attribute.attributeType == bool) {
        inputs.add(
          WickModelFormInputCheckbox(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: WickUtilityTypeConverter.convert(
              defaultValue,
              dateFormat: _dateFormat,
            ),
            helpText: input.helpText,
          ),
        );
      } else if (WickUtilityEnumHelper.isRegistered(
        input.attribute.attributeType,
      )) {
        inputs.add(
          WickModelFormInputDropdown(
            name: input.name,
            autoFill: input.autoFill,
            defaultValue: WickUtilityTypeConverter.convert(
              defaultValue,
              dateFormat: _dateFormat,
            ),
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
    values = values.map(
      (key, value) =>
          MapEntry(WickUtilityStringFormatter.toCamelCase(key), value),
    );
    T? newInstance;
    if (widget.primaryKey == null) {
      newInstance = await _createInstance(values);
    } else {
      final T? savedInstance = await _loadSavedState();
      newInstance =
          savedInstance == null
              ? await _createInstance(values)
              : await _updateInstance(savedInstance, values);
    }
    WickUtilityLogger.log(context, WickEnumLogType.form, {
      'method': '_onSubmit',
      'newInstance': newInstance,
    });
    if (newInstance != null && widget.afterSubmit != null) {
      await widget.afterSubmit!(newInstance);
    }
  }

  Future<T?> _createInstance(Map<String, dynamic> values) async {
    final T createdInstance = WickUtilityTypeConverter.convert(
      values,
      dateFormat: _dateFormat,
    );
    WickUtilityLogger.log(context, WickEnumLogType.form, {
      'method': '_createInstance',
      'createdInstance': createdInstance,
    });
    return await widget.controller.create(context, createdInstance);
  }

  Future<T?> _updateInstance(
    T savedInstance,
    Map<String, dynamic> values,
  ) async {
    final Map<String, dynamic> savedInstanceMap =
        WickUtilityModelHelper.getAttributeValues(savedInstance);
    savedInstanceMap.addAll(values);
    final T updatedInstance = WickUtilityTypeConverter.convert(
      savedInstanceMap,
      dateFormat: _dateFormat,
    );
    WickUtilityLogger.log(context, WickEnumLogType.form, {
      'method': '_updateInstance',
      'updatedInstance': updatedInstance,
    });
    return await widget.controller.edit(context, updatedInstance);
  }
}
