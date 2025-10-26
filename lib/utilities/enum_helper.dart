import '../models/form_inputs/dropdown_option.dart';
import '../utilities/string_formatter.dart';
import '../utilities/type_converter.dart';
import 'enum_registry.generated.dart';

class WickUtilityEnumHelper {
  /// Returns true if an enum type is registered.
  static bool isRegistered(Type type) {
    return WickUtilityEnumRegistry.registry.containsKey(type);
  }

  /// Returns the values of an enum type as a list of dropdown options.
  static List<WickModelFormInputDropdownOption> getValuesAsDropdownOptions(
    Type type,
  ) {
    return getValues(type)
        .map(
          (value) => WickModelFormInputDropdownOption(
            value: WickUtilityTypeConverter.convert(value),
            label: WickUtilityStringFormatter.titleCase(value.name),
          ),
        )
        .toList();
  }

  /// Returns the enum values of an enum type.
  static List<Enum> getValues(Type type) {
    return WickUtilityEnumRegistry.registry[type] ?? [];
  }

  /// Returns the names of the enum values of an enum type.
  static List<String> getValuesNames(Type type) {
    return getValues(type).map((value) => value.name).toList();
  }
}
