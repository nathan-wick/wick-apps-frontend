import '../../../enums/keyboard_type.dart';
import '../../../enums/text_validation.dart';
import 'base.dart';

class WickModelFormInputText extends WickModelFormInputBase {
  final List<WickEnumTextValidation> validations;
  final WickEnumKeyboardType keyboardType;
  final bool isSecret;
  final bool multipleLines;
  final String? helpText;

  WickModelFormInputText({
    required super.name,
    super.autoFill,
    super.defaultValue,
    this.validations = const [],
    this.keyboardType = WickEnumKeyboardType.text,
    this.isSecret = false,
    this.multipleLines = false,
    this.helpText,
  });
}
