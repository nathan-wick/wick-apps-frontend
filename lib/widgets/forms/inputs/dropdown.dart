import 'package:flutter/material.dart';

import '../../../models/forms/inputs/dropdown.dart';
import '../../../utilities/style_constants.dart';

class WickWidgetFormInputDropdown extends StatefulWidget {
  final WickModelFormInputDropdown input;
  final Function(String?) onChanged;

  const WickWidgetFormInputDropdown({
    super.key,
    required this.input,
    required this.onChanged,
  });

  @override
  State<WickWidgetFormInputDropdown> createState() =>
      _WickWidgetFormInputDropdownState();
}

class _WickWidgetFormInputDropdownState
    extends State<WickWidgetFormInputDropdown> {
  @override
  Widget build(BuildContext context) {
    String? selectedValue = widget.input.defaultValue;
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items:
          widget.input.options
              .map(
                (option) => DropdownMenuItem<String>(
                  value: option.value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        WickUtilityStyleConstants.boarderRadius,
                      ),
                    ),
                    child: Row(
                      children: [
                        if (option.icon != null) Icon(option.icon, size: 14),
                        if (option.icon != null)
                          const SizedBox(
                            width: WickUtilityStyleConstants.contentGapSize,
                          ),
                        Text(option.label),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
      decoration: InputDecoration(
        labelText: widget.input.name,
        helperText: widget.input.helpText,
        isDense: true,
        helperMaxLines: 3,
      ),
      focusColor: Colors.transparent,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged(value);
      },
    );
  }
}
