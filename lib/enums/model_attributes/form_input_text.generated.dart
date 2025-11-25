// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wick_apps/enums/model_attributes/base.dart';
import 'package:wick_apps/enums/keyboard_type.dart';

/// Attributes and their types for WickModelFormInputText.
enum WickEnumModelAttributeFormInputText implements WickEnumModelAttributeBase {
  validations(List),
  keyboardType(WickEnumKeyboardType),
  isSecret(bool),
  multipleLines(bool),
  defaultValue(String),
  name(String),
  autoFill(bool),
  helpText(String);

  const WickEnumModelAttributeFormInputText(this.attributeType);

  @override
  final Type attributeType;

  @override
  String get attributeName => this.name;
}
