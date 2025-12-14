import 'package:flutter/material.dart';

import '../../../enums/keyboard_type.dart';
import '../../../enums/text_validation.dart';
import 'base.dart';

class WickModelFormInputText extends WickModelFormInputBase {
  final List<WickEnumTextValidation> validations;
  final WickEnumKeyboardType keyboardType;
  final bool isSecret;
  final bool multipleLines;
  final String? defaultValue;
  final Widget? suffix;

  WickModelFormInputText({
    required super.name,
    super.autoFill,
    this.defaultValue,
    super.helpText,
    this.validations = const [],
    this.keyboardType = WickEnumKeyboardType.text,
    this.isSecret = false,
    this.multipleLines = false,
    this.suffix,
  });
}
