import 'package:flutter/material.dart';

class CustomDialogWithHeader extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Widget child;

  const CustomDialogWithHeader({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 600; // 📌 Detecta si es un móvil

    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width.clamp(250, screenWidth * 0.8), // 📌 Restringe el ancho
          height: height.clamp(150, screenHeight * 0.7), // 📌 Restringe la altura
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 📌 CABECERA MÁS PEQUEÑA CON COLOR Y BOTÓN DE CERRAR
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 📌 Se redujo el padding
                decoration: BoxDecoration(
                  color: Color(0xff007334), // 📌 Color de la cabecera
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16, // 📌 Tamaño de fuente más pequeño
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 20), // 📌 Ícono más pequeño
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero, // 📌 Elimina padding extra del botón
                      constraints: BoxConstraints(), // 📌 Evita que el botón ocupe espacio innecesario
                    ),
                  ],
                ),
              ),
              // 📌 LÍNEA DIVISORA
              Divider(height: 1, color: Colors.grey.shade300),
              // 📌 CONTENEDOR FIJO CON CHILD
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12), // 📌 Padding interno más compacto
                  child: child, // 📌 Widget hijo dinámico
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//----------------------------------------------------------Ejemplo de uso con Texto
// showDialog(
//   context: context,
//   builder: (context) => CustomDialogWithHeader(
//     title: "Aviso",
//     width: 300,
//     height: 180,
//     child: Center(
//       child: Text("Este es un mensaje de aviso."),
//     ),
//   ),
// );
//----------------------------------------------------------Ejemplo de uso  Diálogo con Botón y Texto
// showDialog(
//   context: context,
//   builder: (context) => CustomDialogWithHeader(
//     title: "Opciones",
//     width: 350,
//     height: 220,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("¿Quieres continuar?"),
//         SizedBox(height: 15),
//         ElevatedButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text("Aceptar"),
//         ),
//       ],
//     ),
//   ),
// );
//----------------------------------------------------------Ejemplo de uso de Diálogo con una Lista de Opciones
// showDialog(
//   context: context,
//   builder: (context) => CustomDialogWithHeader(
//     title: "Lista de Opciones",
//     width: 400,
//     height: 300,
//     child: ListView(
//       padding: EdgeInsets.all(10),
//       children: [
//         ListTile(title: Text("Opción 1")),
//         ListTile(title: Text("Opción 2")),
//         ListTile(title: Text("Opción 3")),
//         ListTile(title: Text("Opción 4")),
//       ],
//     ),
//   ),
// );

