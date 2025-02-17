import 'package:app/Domain/Model/client_model.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:flutter/material.dart';

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  late Future<List<ClientModel>> _futureClients;
  final _clientService = ClientService();

  @override
  void initState() {
    super.initState();
    _futureClients = _clientService.fetchClients();
  }

  // Método para refrescar la información
  void _refreshData() {
    setState(() {
      _futureClients = _clientService.fetchClients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mantén el AppBar si deseas un título fijo en la parte superior
      appBar: AppBar(
        title: const Text('Clientes'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          // Ajusta el padding para reducir la separación con la tabla
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Contenedor del FutureBuilder
              FutureBuilder<List<ClientModel>>(
                future: _futureClients,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final clients = snapshot.data!;
                    if (clients.isEmpty) {
                      return const Text('No hay datos que mostrar');
                    }

                    return Card(
                      // Reduce el margen para que no quede tan separado
                      margin: const EdgeInsets.all(8.0),
                      elevation: 4.0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 24,
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (states) => const Color.fromARGB(255, 0, 0, 0),
                          ),
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Nombre')),
                            DataColumn(label: Text('Email')),
                          ],
                          rows: clients.map((c) {
                            return DataRow(
                              cells: [
                                DataCell(Text(c.id.toString())),
                                DataCell(Text(c.name)),
                                DataCell(Text(c.email)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else {
                    // Caso en el que no haya data ni error
                    return const Text('Sin datos');
                  }
                },
              ),
              const SizedBox(height: 16),
              // Botón centrado debajo de la tabla
              ElevatedButton(
                onPressed: _refreshData,
                child: const Text('Refrescar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
