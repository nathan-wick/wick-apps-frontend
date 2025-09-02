import 'package:flutter/material.dart';

import '../enums/button_theme.dart';
import '../enums/button_type.dart';
import '../utilities/style_constants.dart';

class WickWidgetButton extends StatelessWidget {
  final Function() onPressed;
  final String message;
  final IconData? icon;
  final WickEnumButtonType type;
  final WickEnumButtonTheme theme;
  final bool isWide;

  const WickWidgetButton({
    super.key,
    required this.onPressed,
    required this.message,
    this.icon,
    this.type = WickEnumButtonType.solid,
    this.theme = WickEnumButtonTheme.primary,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    final Widget label = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) Icon(icon, size: 14),
        if (icon != null)
          const SizedBox(width: WickUtilityStyleConstants.contentGapSize),
        Text(message),
      ],
    );

    Color backgroundColor;
    switch (theme) {
      case WickEnumButtonTheme.primary:
        backgroundColor = Theme.of(context).primaryColor;
        break;
      case WickEnumButtonTheme.danger:
        backgroundColor = Colors.red;
        break;
    }

    return SizedBox(
      width:
          isWide
              ? double.infinity < WickUtilityStyleConstants.wideWidthSize
                  ? double.infinity
                  : WickUtilityStyleConstants.wideWidthSize
              : null,
      child:
          type == WickEnumButtonType.solid
              ? FilledButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    backgroundColor,
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        WickUtilityStyleConstants.boarderRadius,
                      ),
                    ),
                  ),
                ),
                child: label,
              )
              : TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        WickUtilityStyleConstants.boarderRadius,
                      ),
                    ),
                  ),
                ),
                child: label,
              ),
    );
  }
}
