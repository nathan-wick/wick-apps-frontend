import 'base.dart';

class WickModelFormInputDate extends WickModelFormInputBase {
  final DateTime? defaultValue;

  WickModelFormInputDate({
    required super.name,
    super.autoFill,
    this.defaultValue,
    super.helpText,
  });
}
