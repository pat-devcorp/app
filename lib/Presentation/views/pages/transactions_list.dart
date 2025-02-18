import 'package:app/Domain/Model/client_model.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';
import 'package:app/Presentation/views/widget/static_table_widget.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  late Future<List<ClientModel>> _futureClients;
  final _clientService = ClientService();


  @override
  void initState() {
    super.initState();
    _futureClients = _clientService.fetchClients();
  }

  void _refreshData() {
    setState(() {
      _futureClients = _clientService.fetchClients();
    });
  }
  // Align(
  //   alignment: Alignment.center,
  //   child: IconButton(
  //     icon: const Icon(Icons.edit, color: Colors.blue),
  //     onPressed: () => _showEditDialog(c),
  //   ),
  // ),
  // // Muestra un diálogo para editar un cliente
  // Future<void> _showEditDialog(ClientModel client) async {
  //   // Controladores para los campos del formulario
  //   final TextEditingController idController =
  //       TextEditingController(text: client.id.toString());
  //   final TextEditingController nameController =
  //       TextEditingController(text: client.name);
  //   final TextEditingController emailController =
  //       TextEditingController(text: client.email);

  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Editar Cliente'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // Si quieres que el ID también se pueda editar, lo dejas como TextField habilitado
  //               // Si no, solo lo muestras como "readOnly"
  //               TextField(
  //                 controller: idController,
  //                 decoration: const InputDecoration(labelText: 'ID'),
  //                 readOnly: true, // ID inmutable, puedes habilitarlo si lo deseas
  //               ),
  //               TextField(
  //                 controller: nameController,
  //                 decoration: const InputDecoration(labelText: 'Nombre'),
  //               ),
  //               TextField(
  //                 controller: emailController,
  //                 decoration: const InputDecoration(labelText: 'Email'),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(), // Cerrar diálogo
  //             child: const Text('Cancelar'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               // Construimos el modelo con la información actualizada
  //               final updatedClient = ClientModel(
  //                 id: client.id, // O también int.parse(idController.text) si lo permites
  //                 name: nameController.text,
  //                 email: emailController.text,
  //               );

  //               try {
  //                 await _clientService.updateClient(updatedClient);
  //                 // Cerrar el diálogo después de actualizar
  //                 Navigator.of(context).pop();
  //                 // Refresca la lista
  //                 _refreshData();
  //               } catch (e) {
  //                 // Manejo de errores, puedes mostrar un SnackBar o similar
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text('Error al actualizar: $e')),
  //                 );
  //               }
  //             },
  //             child: const Text('Guardar'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      body: () => Center(
        child: 
        StaticTable(
          title: "Transacciones",
          columnHeaders: ["ID", "Producto", "Precio", "Stock"],
          data: [
            ["001", "Laptop", "\$1000", "5"],
            ["002", "Mouse", "\$25", "20"],
            ["003", "Teclado", "\$45", "15"],
            ["004", "Monitor", "\$200", "8"],
            ["005", "Impresora", "\$120", "10"],
          ],
          //Estos son opcionales
          borderColor: Colors.deepPurple,
          borderWidth: 2,
          headerBackgroundColor: Colors.green,
          containerBackgroundColor: Colors.yellow.shade100, // ✅ Color del contenedor
          showEditColumn: true, // ✅ Activar edición
          showDeleteColumn: true, // ✅ Activar eliminación
          isStatic: true,
          onEdit: (index) => print("Editar ítem $index"),
          onDelete: (index) => print("Eliminar ítem $index"),
          onTapRow: (index) => print("Fila $index clickeada"),
        )
      ));
    }
}