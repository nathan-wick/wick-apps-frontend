abstract class WickModelFormInputBase {
  final String name;
  final bool autoFill;
  final String? helpText;

  WickModelFormInputBase({
    required this.name,
    this.autoFill = true,
    this.helpText,
  });
}
