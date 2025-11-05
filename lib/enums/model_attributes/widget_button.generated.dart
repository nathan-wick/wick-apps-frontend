// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wick_apps/enums/model_attributes/base.dart';
import 'package:wick_apps/enums/button_type.dart';
import 'package:wick_apps/enums/button_theme.dart';

/// Attributes and their types for WickWidgetButton.
enum WickEnumModelAttributeWidgetButton implements WickEnumModelAttributeBase {
  onPressed(Function),
  message(String),
  icon(IconData),
  type(WickEnumButtonType),
  theme(WickEnumButtonTheme),
  isWide(bool);

  const WickEnumModelAttributeWidgetButton(this.attributeType);

  @override
  final Type attributeType;
}
