import 'package:flutter/material.dart';

import '../enums/button_theme.dart';
import '../enums/button_type.dart';
import '../utilities/style_constants.dart';

class WickButton extends StatelessWidget {
  final Function() onPressed;
  final String message;
  final IconData? icon;
  final WickButtonType type;
  final WickButtonTheme theme;
  final bool isWide;

  const WickButton({
    super.key,
    required this.onPressed,
    required this.message,
    this.icon,
    this.type = WickButtonType.solid,
    this.theme = WickButtonTheme.primary,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    final Widget label = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) Icon(icon, size: 14),
        if (icon != null) const SizedBox(width: StyleConstants.contentGapSize),
        Text(message),
      ],
    );

    Color backgroundColor;
    switch (theme) {
      case WickButtonTheme.primary:
        backgroundColor = Theme.of(context).primaryColor;
        break;
      case WickButtonTheme.danger:
        backgroundColor = Colors.red;
        break;
    }

    return SizedBox(
      width:
          isWide
              ? double.infinity < StyleConstants.wideWidthSize
                  ? double.infinity
                  : StyleConstants.wideWidthSize
              : null,
      child:
          type == WickButtonType.solid
              ? FilledButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    backgroundColor,
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        StyleConstants.boarderRadius,
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
                        StyleConstants.boarderRadius,
                      ),
                    ),
                  ),
                ),
                child: label,
              ),
    );
  }
}
