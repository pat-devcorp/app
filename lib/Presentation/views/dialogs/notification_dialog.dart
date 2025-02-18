import 'package:app/Presentation/views/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final String message;
  final String title;

  NotificationDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      message: message,
      icon: Icons.notifications_active,
      iconColor: Colors.orange,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 8,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Abrir", style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}