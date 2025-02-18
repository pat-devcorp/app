import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final List<Widget> actions;

  CustomDialog({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 320,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: Offset(4, 6),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: Offset(-4, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(message, textAlign: TextAlign.center),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: actions,
                ),
              ],
            ),
          ),

          // Icono flotante con efecto 3D
          Positioned(
            top: -20,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(4, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(-4, -4),
                  ),
                ],
              ),
              child: Icon(icon, size: 40, color: iconColor),
            ),
          ),
        ],
      ),
    );
  }
}
// -------------------------------------------------------------normal
// showDialog(
//   context: context,
//   builder: (BuildContext context) => NotificationDialog(
//     title: "Notificación",
//     message: "Tienes 1 nueva notificación.",
//   ),
// );
//---------------------------------------------------------------advertencia
// showDialog(
//   context: context,
//   builder: (BuildContext context) => WarningDialog(
//     title: "¡Advertencia!",
//     message: "Esto puede tener consecuencias no deseadas.",
//   ),
// );
