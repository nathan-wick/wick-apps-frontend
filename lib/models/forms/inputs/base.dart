abstract class WickFormInputBase {
  final String name;
  final bool autoFill;
  final String? defaultValue;

  WickFormInputBase({
    required this.name,
    this.autoFill = true,
    this.defaultValue,
  });
}
