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
          Icon(icon, color: Colors.white), // White icon for visibility
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              softWrap: true, // Ensures multi-line support
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
      duration: const Duration(seconds: 4), // Slightly longer duration
      behavior: SnackBarBehavior.floating, // Floating for better visibility
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
