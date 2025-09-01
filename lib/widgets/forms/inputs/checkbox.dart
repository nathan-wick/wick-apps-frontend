import 'package:flutter/material.dart';

import '../../../models/forms/inputs/checkbox.dart';
import '../../../utilities/style_constants.dart';
import '../../../utilities/type_converter.dart';

class WickWidgetFormInputCheckbox extends StatefulWidget {
  final CheckboxModel input;
  final Function(String?) onChanged;

  const WickWidgetFormInputCheckbox({
    super.key,
    required this.input,
    required this.onChanged,
  });

  @override
  State<WickWidgetFormInputCheckbox> createState() =>
      _WickWidgetFormInputCheckboxState();
}

class _WickWidgetFormInputCheckboxState
    extends State<WickWidgetFormInputCheckbox> {
  @override
  Widget build(BuildContext context) {
    bool value = TypeConverter.toBool(widget.input.defaultValue) ?? false;
    final Widget checkbox = Checkbox(
      checkColor: Theme.of(context).scaffoldBackgroundColor,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Theme.of(context).primaryColor;
        }
        return Theme.of(context).unselectedWidgetColor.withValues(alpha: 0.1);
      }),
      value: value,
      onChanged: (newValue) {
        if (newValue != null) {
          setState(() {
            value = newValue;
          });
          widget.onChanged(TypeConverter.describe(newValue));
        }
      },
    );

    return widget.input.displayName
        ? Row(
          children: [
            checkbox,
            const SizedBox(width: StyleConstants.paddingSize),
            Text(widget.input.name),
          ],
        )
        : checkbox;
  }
}
