abstract class WickModelFormInputBase {
  final String name;
  final bool autoFill;
  final String? defaultValue;

  WickModelFormInputBase({
    required this.name,
    this.autoFill = true,
    this.defaultValue,
  });
}
