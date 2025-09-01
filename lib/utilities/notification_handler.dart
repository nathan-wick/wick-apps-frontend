import 'package:flutter/material.dart';

import '../enumerations/notification_type.dart';
import '../utilities/style_constants.dart';
import 'color_engine.dart';

class NotificationHandler {
  static void displayNotification(
    BuildContext context,
    NotificationType type,
    String message,
  ) {
    final textColor = Theme.of(context).scaffoldBackgroundColor;
    Color backgroundColor;
    IconData icon;
    Duration duration;
    switch (type) {
      case NotificationType.neutral:
        backgroundColor = ColorEngine.calculateAccessibleColor(
          Colors.grey,
          textColor,
        );
        icon = Icons.info_outline;
        duration = const Duration(seconds: 4);
        break;
      case NotificationType.success:
        backgroundColor = ColorEngine.calculateAccessibleColor(
          Colors.green,
          textColor,
        );
        icon = Icons.check_circle_outline;
        duration = const Duration(seconds: 2);
        break;
      case NotificationType.error:
        backgroundColor = ColorEngine.calculateAccessibleColor(
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
            SizedBox(width: StyleConstants.paddingSize),
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
