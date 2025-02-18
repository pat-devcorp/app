import 'package:app/Presentation/views/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final String title;

  ConfirmationDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      message: message,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 8,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Aceptar", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}