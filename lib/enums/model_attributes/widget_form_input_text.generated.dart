// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wick_apps/enums/model_attributes/base.dart';
import 'package:wick_apps/models/form_inputs/text.dart';

/// Attributes and their types for WickWidgetFormInputText.
enum WickEnumModelAttributeWidgetFormInputText implements WickEnumModelAttributeBase {
  input(WickModelFormInputText),
  onChanged(Function),
  onEnterPressed(Function),
  focusNode(FocusNode),
  controller(TextEditingController),
  _controller(TextEditingController);

  const WickEnumModelAttributeWidgetFormInputText(this.attributeType);

  @override
  final Type attributeType;

  @override
  String get attributeName => this.name;
}
