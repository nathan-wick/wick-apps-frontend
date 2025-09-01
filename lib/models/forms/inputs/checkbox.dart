import 'base.dart';

class CheckboxModel extends WickFormInputBase {
  final bool displayName;

  CheckboxModel({
    required super.name,
    super.autoFill,
    super.defaultValue,
    this.displayName = true,
  });
}
