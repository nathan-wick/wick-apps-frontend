import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/date_format.dart';
import '../../../enums/keyboard_type.dart';
import '../../../enums/text_validation.dart';
import '../../../models/form_inputs/text.dart';
import '../../../models/preferences.dart';
import '../../../providers/preferences.dart';
import '../../../utilities/input_validator.dart';
import '../../../utilities/regular_expression.dart';
import '../../../utilities/type_converter.dart';

class WickWidgetFormInputText extends StatefulWidget {
  final WickModelFormInputText input;
  final Function(String?) onChanged;
  final Function() onEnterPressed;
  final FocusNode? focusNode;

  const WickWidgetFormInputText({
    super.key,
    required this.input,
    required this.onChanged,
    required this.onEnterPressed,
    required this.focusNode,
  });

  @override
  State<WickWidgetFormInputText> createState() =>
      _WickWidgetFormInputTextState();
}

class _WickWidgetFormInputTextState extends State<WickWidgetFormInputText> {
  final TextEditingController _controller = TextEditingController();
  String _previousValue = '';
  WickEnumDateFormat _dateFormat = WickEnumDateFormat.yearMonthDay;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.input.defaultValue ?? '';
    _previousValue = _controller.text;
    _getWickEnumDateFormat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? helpText = widget.input.helpText;
    if (helpText == null &&
        widget.input.keyboardType == WickEnumKeyboardType.date) {
      helpText = "Date format is ${_dateFormat.value}.";
    }
    return TextFormField(
      controller: _controller,
      obscureText: widget.input.isSecret,
      keyboardType:
          widget.input.keyboardType == WickEnumKeyboardType.text &&
                  widget.input.multipleLines
              ? WickEnumKeyboardType.multipleLines.value
              : widget.input.keyboardType.value,
      decoration: InputDecoration(
        labelText: widget.input.name,
        helperText: helpText,
        isDense: true,
        helperMaxLines: 3,
        suffixIcon:
            widget.input.keyboardType == WickEnumKeyboardType.date
                ? IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                )
                : null,
      ),
      maxLines: widget.input.multipleLines ? null : 1,
      minLines: widget.input.multipleLines ? 3 : 1,
      validator: (String? value) {
        if (widget.input.validations.isEmpty) return null;
        if (value == null || value.isEmpty) {
          return widget.input.validations.contains(
                WickEnumTextValidation.required,
              )
              ? "${widget.input.name} is required."
              : null;
        }
        if (widget.input.validations.contains(WickEnumTextValidation.email)) {
          if (!WickUtilityRegularExpression.email.hasMatch(value)) {
            return "Please enter a valid email address.";
          }
        }
        if (widget.input.validations.contains(WickEnumTextValidation.name)) {
          if (value.length > 50) return "Name must not exceed 50 characters.";
          if (!WickUtilityRegularExpression.letters.hasMatch(value)) {
            return "Name must be letters only.";
          }
        }
        if (widget.input.validations.contains(WickEnumTextValidation.date)) {
          final String? dateValidationMessage = WickUtilityInputValidator.date(
            value,
            _dateFormat,
          );
          if (dateValidationMessage != null) return dateValidationMessage;
        }
        return null;
      },
      onChanged: (value) {
        if (widget.input.keyboardType == WickEnumKeyboardType.date) {
          final completedFirstInput =
              _dateFormat == WickEnumDateFormat.yearMonthDay
                  ? value.length == 4 && _previousValue.length == 3
                  : value.length == 2 && _previousValue.length == 1;
          final completedSecondInput =
              _dateFormat == WickEnumDateFormat.yearMonthDay
                  ? value.length == 7 && _previousValue.length == 6
                  : value.length == 5 && _previousValue.length == 4;
          if (completedFirstInput || completedSecondInput) {
            _controller.text = '$value/';
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          }
        }
        if (value.isEmpty) {
          widget.onChanged(null);
        } else {
          widget.onChanged(value);
        }
        _previousValue = _controller.text;
      },
      onFieldSubmitted: (value) {
        widget.onEnterPressed();
      },
      focusNode: widget.focusNode,
    );
  }

  Future<void> _getWickEnumDateFormat() async {
    final WickModelPreferences? preferences =
        await Provider.of<WickProviderPreferences>(
          context,
          listen: false,
        ).getValue(context);
    if (preferences?.dateFormat != null) {
      final WickEnumDateFormat? preferredWickEnumDateFormat =
          preferences?.dateFormat;
      setState(() {
        _dateFormat =
            preferredWickEnumDateFormat ?? WickEnumDateFormat.yearMonthDay;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate =
        WickUtilityTypeConverter.toDate(_controller.text, _dateFormat) ??
        DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year - 100),
      lastDate: DateTime(initialDate.year + 100),
      cancelText: "Cancel",
      confirmText: "Confirm",
    );
    if (picked != null) {
      final String? formattedDate = WickUtilityTypeConverter.describe(
        picked,
        _dateFormat,
      );
      setState(() {
        _controller.text = formattedDate ?? '';
      });
      widget.onChanged(formattedDate);
    }
  }
}
