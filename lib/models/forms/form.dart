import 'inputs/base.dart';

class FormModel {
  final String name;
  final List<WickFormInputBase> inputs;
  final String submitButtonText;
  final bool autoSubmit;
  final bool autoFocus;
  final Duration debounce;

  FormModel({
    required this.name,
    required this.inputs,
    this.submitButtonText = "Submit",
    this.autoSubmit = false,
    this.autoFocus = true,
    this.debounce = const Duration(seconds: 1),
  });
}
