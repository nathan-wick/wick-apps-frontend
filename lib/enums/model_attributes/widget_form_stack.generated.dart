// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wick_apps/enums/model_attributes/base.dart';
import 'package:wick_apps/controllers/base.dart';

/// Attributes and their types for WickWidgetFormStack.
enum WickEnumModelAttributeWidgetFormStack implements WickEnumModelAttributeBase {
  name(String),
  inputs(List),
  controller(WickControllerBase),
  primaryKey(int),
  submitButtonText(String),
  autoSubmit(bool),
  autoFocus(bool),
  debounce(Duration);

  const WickEnumModelAttributeWidgetFormStack(this.attributeType);

  @override
  final Type attributeType;

  @override
  String get attributeName => this.name;
}
