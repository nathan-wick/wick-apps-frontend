// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wick_apps/enums/model_attributes/base.dart';

/// Attributes and their types for WickWidgetDialog.
enum WickEnumModelAttributeWidgetDialog implements WickEnumModelAttributeBase {
  icon(IconData),
  title(String),
  content(List),
  displayActions(bool),
  okayMessage(String),
  displayCancel(bool);

  const WickEnumModelAttributeWidgetDialog(this.attributeType);

  @override
  final Type attributeType;

  @override
  String get attributeName => this.name;
}
