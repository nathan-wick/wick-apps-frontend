// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wick_apps/enums/model_attributes/base.dart';
import 'package:wick_apps/enums/brightness.dart';
import 'package:wick_apps/enums/date_format.dart';
import 'package:wick_apps/enums/color.dart';

/// Attributes and their types for WickModelPreferences.
enum WickEnumModelAttributePreferences implements WickEnumModelAttributeBase {
  userId(int),
  brightness(WickEnumBrightness),
  dateFormat(WickEnumDateFormat),
  primaryColor(WickEnumColor);

  const WickEnumModelAttributePreferences(this.attributeType);

  @override
  final Type attributeType;
}
