import 'base.dart';
import 'dropdown_option.dart';

class WickModelFormInputDropdown extends WickModelFormInputBase {
  final List<WickModelFormInputDropdownOption> options;
  final String? helpText;

  WickModelFormInputDropdown({
    required super.name,
    super.autoFill,
    super.defaultValue,
    required this.options,
    this.helpText,
  });
}
