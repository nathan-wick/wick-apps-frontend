import '../models/form_inputs/dropdown_option.dart';
import '../utilities/string_formatter.dart';
import '../utilities/type_converter.dart';

class WickUtilityEnumHelper {
  /// Returns the values of an enum as a list of dropdown options.
  static List<WickModelFormInputDropdownOption>
  getEnumValuesAsDropdownOptions<T extends Enum>(List<T> values) {
    return values
        .map(
          (value) => WickModelFormInputDropdownOption(
            value: WickUtilityTypeConverter.describe(value),
            label: WickUtilityStringFormatter.titleCase(value.name),
          ),
        )
        .toList();
  }
}
