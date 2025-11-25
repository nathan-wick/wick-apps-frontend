import '../../enums/model_attributes/base.dart';
import '../../utilities/string_formatter.dart';
import 'base.dart';

class WickModelFormInputAttribute extends WickModelFormInputBase {
  final WickEnumModelAttributeBase attribute;
  final dynamic defaultValue;

  WickModelFormInputAttribute({
    required this.attribute,
    this.defaultValue,
    super.autoFill,
    super.helpText,
  }) : super(
         name: WickUtilityStringFormatter.titleCase(
           WickUtilityStringFormatter.replaceSpaces(
             attribute.attributeName,
             ' ',
           ),
         ),
       );
}
