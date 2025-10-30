import '../../utilities/string_formatter.dart';
import 'base.dart';

class WickModelFormInputAttribute extends WickModelFormInputBase {
  final String attributeName;
  final dynamic defaultValue;

  WickModelFormInputAttribute({
    required this.attributeName,
    this.defaultValue,
    super.autoFill,
    super.helpText,
  }) : super(
         name: WickUtilityStringFormatter.titleCase(
           WickUtilityStringFormatter.replaceSpaces(attributeName, ' '),
         ),
       );
}
