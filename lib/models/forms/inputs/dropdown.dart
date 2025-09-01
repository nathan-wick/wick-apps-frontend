import 'base.dart';
import 'dropdown_option.dart';

class DropdownModel extends WickFormInputBase {
  final List<DropdownOptionModel> options;
  final String? helpText;

  DropdownModel({
    required super.name,
    super.autoFill,
    super.defaultValue,
    required this.options,
    this.helpText,
  });
}
