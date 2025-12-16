import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/widgets/forms/inputs/text.dart';

import '../../../enums/date_format.dart';
import '../../../enums/keyboard_type.dart';
import '../../../enums/text_validation.dart';
import '../../../models/form_inputs/date.dart';
import '../../../models/form_inputs/text.dart';
import '../../../models/preferences.dart';
import '../../../providers/preferences.dart';
import '../../../utilities/input_validator.dart';
import '../../../utilities/type_converter.dart';
import '../../loading_indicator.dart';

class WickWidgetFormInputDate extends StatefulWidget {
  final WickModelFormInputDate input;
  final Function(DateTime?) onChanged;
  final Function() onEnterPressed;
  final FocusNode? focusNode;

  const WickWidgetFormInputDate({
    super.key,
    required this.input,
    required this.onChanged,
    required this.onEnterPressed,
    required this.focusNode,
  });

  @override
  State<WickWidgetFormInputDate> createState() =>
      _WickWidgetFormInputDateState();
}

class _WickWidgetFormInputDateState extends State<WickWidgetFormInputDate> {
  static const WickEnumDateFormat _defaultDateFormat =
      WickEnumDateFormat.yearMonthDay;
  final TextEditingController _controller = TextEditingController();
  WickEnumDateFormat _dateFormat = _defaultDateFormat;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const WickWidgetLoadingIndicator();
    }
    String helpText =
        widget.input.helpText ?? "Date format is ${_dateFormat.value}.";
    WickModelFormInputText textInput = WickModelFormInputText(
      name: widget.input.name,
      autoFill: widget.input.autoFill,
      defaultValue: WickUtilityTypeConverter.convert(
        widget.input.defaultValue,
        dateFormat: _dateFormat,
      ),
      helpText: helpText,
      keyboardType: WickEnumKeyboardType.date,
      validations: [WickEnumTextValidation.date],
      suffix: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: () => _selectDate(context),
      ),
    );
    return WickWidgetFormInputText(
      input: textInput,
      onChanged: (String? stringValue) {
        if (stringValue == null || stringValue.isEmpty) {
          widget.onChanged(null);
          return;
        }
        final bool stringValueIsValidDate =
            WickUtilityInputValidator.date(stringValue, _dateFormat) == null;
        if (!stringValueIsValidDate) {
          widget.onChanged(null);
          return;
        }
        final DateTime dateValue = WickUtilityTypeConverter.convert(
          stringValue,
          dateFormat: _dateFormat,
        );
        widget.onChanged(dateValue);
      },
      onEnterPressed: widget.onEnterPressed,
      focusNode: widget.focusNode,
      controller: _controller,
    );
  }

  Future<void> _initialize() async {
    final WickModelPreferences? preferences =
        await Provider.of<WickProviderPreferences>(
          context,
          listen: false,
        ).getValue(context);

    if (!mounted) return;

    setState(() {
      _dateFormat = preferences?.dateFormat ?? _defaultDateFormat;
      _controller.text =
          WickUtilityTypeConverter.convert(
            widget.input.defaultValue,
            dateFormat: _dateFormat,
          ) ??
          '';
      _isInitialized = true;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate =
        WickUtilityTypeConverter.convert(
          _controller.text,
          dateFormat: _dateFormat,
        ) ??
        DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year - 100),
      lastDate: DateTime(initialDate.year + 100),
      cancelText: "Cancel",
      confirmText: "Confirm",
    );
    if (pickedDate != null) {
      final String? formattedDate = WickUtilityTypeConverter.convert(
        pickedDate,
        dateFormat: _dateFormat,
      );
      setState(() {
        _controller.text = formattedDate ?? '';
      });
      widget.onChanged(pickedDate);
    }
  }
}
