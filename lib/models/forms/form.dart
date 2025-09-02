import 'inputs/base.dart';

class WickModelForm {
  final String name;
  final List<WickModelFormInputBase> inputs;
  final String submitButtonText;
  final bool autoSubmit;
  final bool autoFocus;
  final Duration debounce;

  WickModelForm({
    required this.name,
    required this.inputs,
    this.submitButtonText = "Submit",
    this.autoSubmit = false,
    this.autoFocus = true,
    this.debounce = const Duration(seconds: 1),
  });
}
