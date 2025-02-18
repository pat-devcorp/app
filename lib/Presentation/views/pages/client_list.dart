import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:flutter/material.dart';
import 'package:app/Domain/Model/client_model.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';
import 'package:app/Presentation/views/widget/static_table_widget.dart';

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  final ClientService _clientService = ClientService();
  List<ClientModel> _clients = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {
    try {
      List<ClientModel> clients = await _clientService.fetchClients();
      setState(() {
        _clients = clients;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      body: () => Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Muestra un spinner mientras carga
            : _errorMessage != null
                ? Text(
                    'Error: $_errorMessage',
                    style: const TextStyle(color: Colors.red),
                  )
                : StaticTable(
                    title: "Clientes",
                    columnHeaders: ["ID", "Nombre", "Email", "Transacciones"],
                    data: _clients
                        .map((client) => [
                              client.clientId?.toString() ?? "N/A",
                              client.name ?? "Sin nombre",
                              client.email ?? "Sin email",
                              client.transactionList != null
                                  ? client.transactionList!.length.toString()
                                  : "0"
                            ])
                        .toList(),
                    borderColor: Colors.deepPurple,
                    borderWidth: 2,
                    headerBackgroundColor: Colors.green,
                    containerBackgroundColor: Colors.yellow.shade100,
                    showEditColumn: true,
                    showDeleteColumn: true,
                    isStatic: true,
                    onEdit: (index) =>
                        print("Editar cliente: ${_clients[index].name}"),
                    onDelete: (index) =>
                        print("Eliminar cliente: ${_clients[index].name}"),
                    onTapRow: (index) =>
                        print("Fila ${index + 1} clickeada - Cliente: ${_clients[index].name}"),
                  ),
      ),
    );
  }
}
