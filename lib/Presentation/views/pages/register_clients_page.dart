import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:app/Presentation/views/style/dimension.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';
import 'package:app/Presentation/views/widget/button_widget.dart';
import 'package:app/Presentation/views/widget/texts_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app/Domain/Model/client_model.dart';
import 'package:app/Presentation/language/ui_labels.dart';

class RegisterClientsPage extends StatefulWidget {
  const RegisterClientsPage({super.key});

  @override
  State<RegisterClientsPage> createState() => _RegisterClientsPageState();
}

class _RegisterClientsPageState extends State<RegisterClientsPage> {
  final UiLabels labels = GetIt.instance<UiLabels>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ClientService _clientService = ClientService();
  final List<ClientModel> _clients = [];

  void _addClient() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _clients.add(ClientModel(
          name: _nameController.text,
          email: _emailController.text,
        ));
        _nameController.clear();
        _emailController.clear();
      });
    }
  }

  void _removeClient(int index) {
    setState(() {
      _clients.removeAt(index);
    });
  }

  Future<void> _submitClients() async {
    if (_clients.isEmpty) {
      _showSnackBar("No hay clientes para registrar", Colors.red);
      return;
    }

    try {
      bool success = await _clientService.registerClients(_clients);
      if (success) {
        _showSnackBar("Clientes registrados exitosamente", Colors.green);
        setState(() {
          _clients.clear();
        });
      } else {
        _showSnackBar("Error al registrar clientes", Colors.red);
      }
    } catch (error) {
      _showSnackBar("Error de conexión: $error", Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(text: message, type: TextType.normal),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        body: () => Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(context.dimensions[Dimension.large]!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFormCard(),
                  SizedBox(height: context.dimensions[Dimension.large]),
                  if (_clients.isNotEmpty) _buildClientsTable(),
                  SizedBox(height: context.dimensions[Dimension.large]),
                  CustomButton.green(
                    text: "Registrar Clientes",
                    onPressed: _submitClients,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: Colors.green.withValues(alpha: 0.2),
      child: Padding(
        padding: EdgeInsets.all(context.dimensions[Dimension.large]!),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: labels.registerClient,
                type: TextType.title1,
                color: Colors.green,
              ),
              SizedBox(height: context.dimensions[Dimension.large]),
              _buildTextInput(
                controller: _nameController,
                label: "Nombre",
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Ingrese el nombre";
                  return null;
                },
              ),
              SizedBox(height: context.dimensions[Dimension.medium]),
              _buildTextInput(
                controller: _emailController,
                label: "Correo electrónico",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Ingrese el correo";
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return "Correo inválido";
                  }
                  return null;
                },
              ),
              SizedBox(height: context.dimensions[Dimension.large]),
              CustomButton.green(
                text: "Agregar Cliente",
                onPressed: _addClient,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildClientsTable() {
    return Column(
      children: [
        CustomText(
          text: "Clientes a registrar",
          type: TextType.title2,
        ),
        SizedBox(height: context.dimensions[Dimension.medium]),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: CustomText(text: "Nombre", type: TextType.normal)),
                  DataColumn(label: CustomText(text: "Email", type: TextType.normal)),
                  DataColumn(label: CustomText(text: "Eliminar", type: TextType.normal)),
                ],
                rows: List.generate(
                  _clients.length,
                  (index) => DataRow(cells: [
                    DataCell(CustomText(text: _clients[index].name, type: TextType.normal)),
                    DataCell(CustomText(text: _clients[index].email, type: TextType.normal)),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeClient(index),
                    )),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
