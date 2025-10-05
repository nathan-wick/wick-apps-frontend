import '../../utilities/string_formatter.dart';
import 'base.dart';

class WickModelFormInputField extends WickModelFormInputBase {
  final String fieldName;
  final dynamic defaultValue;

  WickModelFormInputField({
    required this.fieldName,
    this.defaultValue,
    super.autoFill,
    super.helpText,
  }) : super(
         name: WickUtilityStringFormatter.titleCase(
           WickUtilityStringFormatter.replaceSpaces(fieldName, ' '),
         ),
       );
}
