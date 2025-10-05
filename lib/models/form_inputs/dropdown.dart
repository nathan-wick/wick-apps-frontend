import 'base.dart';
import 'dropdown_option.dart';

class WickModelFormInputDropdown extends WickModelFormInputBase {
  final List<WickModelFormInputDropdownOption> options;
  final String? defaultValue;

  WickModelFormInputDropdown({
    required super.name,
    super.autoFill,
    this.defaultValue,
    super.helpText,
    required this.options,
  });
}
