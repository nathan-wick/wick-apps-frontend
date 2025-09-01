import '../../../enums/keyboard_type.dart';
import '../../../enums/text_validation.dart';
import 'base.dart';

class TextModel extends WickFormInputBase {
  final List<WickTextValidation> validations;
  final WickKeyboardType keyboardType;
  final bool isSecret;
  final bool multipleLines;
  final String? helpText;

  TextModel({
    required super.name,
    super.autoFill,
    super.defaultValue,
    this.validations = const [],
    this.keyboardType = WickKeyboardType.text,
    this.isSecret = false,
    this.multipleLines = false,
    this.helpText,
  });
}
