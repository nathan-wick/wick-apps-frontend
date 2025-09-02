import 'base.dart';

class WickModelFormInputCheckbox extends WickModelFormInputBase {
  final bool displayName;

  WickModelFormInputCheckbox({
    required super.name,
    super.autoFill,
    super.defaultValue,
    this.displayName = true,
  });
}
