// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wick_apps/enums/model_attributes/base.dart';

/// Attributes and their types for WickModelSession.
enum WickEnumModelAttributeSession implements WickEnumModelAttributeBase {
  id(int),
  userId(int),
  code(String),
  successfulAttempts(int),
  failedAttempts(int),
  started(DateTime),
  expires(DateTime),
  device(String),
  location(String);

  const WickEnumModelAttributeSession(this.attributeType);

  @override
  final Type attributeType;
}
