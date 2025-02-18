import 'package:flutter/material.dart';

enum SnackBarType {
  success,
  error,
  info,
}

class NotificationSnackBar {
  static void show(BuildContext context, String message, SnackBarType type) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color backgroundColor;
    IconData icon;
    Color textColor;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = colorScheme.primary;
        icon = Icons.check_circle;
        textColor = colorScheme.onPrimary;
        break;
      case SnackBarType.error:
        backgroundColor = colorScheme.error;
        icon = Icons.error;
        textColor = colorScheme.onError;
        break;
      case SnackBarType.info:
        backgroundColor = colorScheme.tertiary;
        icon = Icons.info;
        textColor = colorScheme.onTertiary;
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: textColor),
              softWrap: true,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: textColor),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
