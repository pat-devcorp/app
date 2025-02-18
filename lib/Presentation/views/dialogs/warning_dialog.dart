import 'package:app/Presentation/views/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final String message;
  final String title;

  WarningDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      message: message,
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.red,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey, // Botón Cancelar en Gris
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 8,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancelar", style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Botón Aceptar en Rojo
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