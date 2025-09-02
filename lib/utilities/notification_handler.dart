import 'package:flutter/material.dart';

import '../enums/notification_type.dart';
import '../utilities/style_constants.dart';
import 'color_engine.dart';

class WickUtilityNotificationHandler {
  static void displayNotification(
    BuildContext context,
    WickEnumNotificationType type,
    String message,
  ) {
    final textColor = Theme.of(context).scaffoldBackgroundColor;
    Color backgroundColor;
    IconData icon;
    Duration duration;
    switch (type) {
      case WickEnumNotificationType.neutral:
        backgroundColor = WickUtilityColorEngine.calculateAccessibleColor(
          Colors.grey,
          textColor,
        );
        icon = Icons.info_outline;
        duration = const Duration(seconds: 4);
        break;
      case WickEnumNotificationType.success:
        backgroundColor = WickUtilityColorEngine.calculateAccessibleColor(
          Colors.green,
          textColor,
        );
        icon = Icons.check_circle_outline;
        duration = const Duration(seconds: 2);
        break;
      case WickEnumNotificationType.error:
        backgroundColor = WickUtilityColorEngine.calculateAccessibleColor(
          Colors.red,
          textColor,
        );
        icon = Icons.error_outline;
        duration = const Duration(seconds: 6);
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor),
            SizedBox(width: WickUtilityStyleConstants.paddingSize),
            Expanded(child: Text(message, style: TextStyle(color: textColor))),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
