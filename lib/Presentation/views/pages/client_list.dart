import 'package:app/Domain/Model/client_model.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          // Si el contenido excede la altura de la pantalla, se podrá desplazar
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
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
    // Cabeceras con Align para alinear texto a la izquierda
    final columns = [
      DataColumn(
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'ID',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      DataColumn(
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nombre',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      DataColumn(
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Email',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ];

    // Filas, cada DataCell con Align a la izquierda
    final rows = clients.map((c) {
      return DataRow(cells: [
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
      ]);
    }).toList();

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ConstrainedBox(
        // 50% del alto de la pantalla para la tabla
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: Column(
          children: [
            // Cuerpo
            Expanded(
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    headingRowHeight: 50, // Para no repetir cabecera
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
          // headingRowColor: MaterialStateProperty.all(Colors.black),