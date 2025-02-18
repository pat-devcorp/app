import 'package:app/Domain/Model/client_model.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';
import 'package:flutter/material.dart';

class ClientList extends StatefulWidget {
  const ClientList({Key? key}) : super(key: key);

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  late Future<List<ClientModel>> _futureClients;
  final _clientService = ClientService();

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

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

  // Muestra un diálogo para editar un cliente
  Future<void> _showEditDialog(ClientModel client) async {
    // Controladores para los campos del formulario
    final TextEditingController idController =
        TextEditingController(text: client.id.toString());
    final TextEditingController nameController =
        TextEditingController(text: client.name);
    final TextEditingController emailController =
        TextEditingController(text: client.email);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Cliente'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Si quieres que el ID también se pueda editar, lo dejas como TextField habilitado
                // Si no, solo lo muestras como "readOnly"
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                  readOnly: true, // ID inmutable, puedes habilitarlo si lo deseas
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cerrar diálogo
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Construimos el modelo con la información actualizada
                final updatedClient = ClientModel(
                  id: client.id, // O también int.parse(idController.text) si lo permites
                  name: nameController.text,
                  email: emailController.text,
                  lastname: emailController.text,
                );

                try {
                  await _clientService.updateClient(updatedClient);
                  // Cerrar el diálogo después de actualizar
                  Navigator.of(context).pop();
                  // Refresca la lista
                  _refreshData();
                } catch (e) {
                  // Manejo de errores, puedes mostrar un SnackBar o similar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al actualizar: $e')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      body: () => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<List<ClientModel>>(
                  future: _futureClients,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final clients = snapshot.data!;
                      if (clients.isEmpty) {
                        return const Center(child: Text('No hay datos que mostrar'));
                      }
                      return _buildFixedHeaderTable(context, clients);
                    } else {
                      return const Center(child: Text('Sin datos'));
                    }
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _refreshData,
                  child: const Text('Refrescar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFixedHeaderTable(BuildContext context, List<ClientModel> clients) {
    // Cabeceras
    final columns = [
      DataColumn(
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text('ID', style: const TextStyle(color: Colors.white)),
        ),
      ),
      DataColumn(
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text('Nombre', style: const TextStyle(color: Colors.white)),
        ),
      ),
      DataColumn(
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text('Email', style: const TextStyle(color: Colors.white)),
        ),
      ),
      // Nueva columna para "Editar"
      DataColumn(
        label: Align(
          alignment: Alignment.center,
          child: Text('Editar', style: const TextStyle(color: Colors.white)),
        ),
      ),
      // Columna "Eliminar"
      DataColumn(
        label: Align(
          alignment: Alignment.center,
          child: Text('Eliminar', style: const TextStyle(color: Colors.white)),
        ),
      ),
    ];

    final rows = clients.map((c) {
      return DataRow(
        cells: [
          DataCell(
            Align(
              alignment: Alignment.centerLeft,
              child: Text(c.id.toString()),
            ),
          ),
          DataCell(
            Align(
              alignment: Alignment.centerLeft,
              child: Text(c.name),
            ),
          ),
          DataCell(
            Align(
              alignment: Alignment.centerLeft,
              child: Text(c.email),
            ),
          ),
          // Celda para el botón de Editar
          DataCell(
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => _showEditDialog(c),
              ),
            ),
          ),
          // Celda para el botón de Eliminar
          DataCell(
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  // Puedes agregar aquí un diálogo de confirmación si lo deseas
                  await _clientService.deleteClient(c.id!);
                  // Tras la eliminación, refresca la lista
                  _refreshData();
                },
              ),
            ),
          ),
        ],
      );
    }).toList();

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.47,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    headingRowHeight: 50,
                    headingRowColor: MaterialStateProperty.all(Colors.black),
                    columns: columns,
                    rows: rows,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
