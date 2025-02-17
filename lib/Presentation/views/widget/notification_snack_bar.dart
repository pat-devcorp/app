import 'package:flutter/material.dart';

enum SnackBarType {
  success,
  error,
  info,
}

class NotificationSnackBar {
  static void show(BuildContext context, String message, SnackBarType type) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Theme.of(context).colorScheme.primary;
        icon = Icons.check_circle;
        break;
      case SnackBarType.error:
        backgroundColor = Theme.of(context).colorScheme.error;
        icon = Icons.error;
        break;
      case SnackBarType.info:
        backgroundColor = Colors.blue;
        icon = Icons.info;
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              softWrap: true,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
