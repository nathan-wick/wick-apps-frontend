// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wick_apps/enums/model_attributes/base.dart';
import 'package:wick_apps/enums/image_shapes.dart';
import 'package:wick_apps/enums/file_sizes.dart';

/// Attributes and their types for WickModelFormInputImage.
enum WickEnumModelAttributeFormInputImage implements WickEnumModelAttributeBase {
  shape(WickEnumImageShape),
  maxSize(WickEnumFileSize),
  defaultValue(Uint8List),
  name(String),
  autoFill(bool),
  helpText(String);

  const WickEnumModelAttributeFormInputImage(this.attributeType);

  @override
  final Type attributeType;

  @override
  String get attributeName => this.name;
}
