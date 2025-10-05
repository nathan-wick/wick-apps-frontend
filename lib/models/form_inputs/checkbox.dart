import 'base.dart';

class WickModelFormInputCheckbox extends WickModelFormInputBase {
  final bool displayName;
  final bool? defaultValue;

  WickModelFormInputCheckbox({
    required super.name,
    super.autoFill,
    this.defaultValue,
    super.helpText,
    this.displayName = true,
  });
}
