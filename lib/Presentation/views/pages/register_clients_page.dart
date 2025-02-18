import 'package:app/Presentation/views/widget/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:app/Domain/Model/client_model.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';
import 'package:app/Presentation/views/widget/button_widget.dart';
import 'package:app/Presentation/views/widget/texts_widget.dart';
import 'package:app/Presentation/language/ui_labels.dart';

class RegisterClientsPage extends StatefulWidget {
  const RegisterClientsPage({super.key});

  @override
  State<RegisterClientsPage> createState() => _RegisterClientsPageState();
}

class _RegisterClientsPageState extends State<RegisterClientsPage> {
  final TextEditingController _emailController     = TextEditingController();
  final TextEditingController _nameController      = TextEditingController();
  final TextEditingController _lastnameController  = TextEditingController();
  final ClientService _clientService               = ClientService();
  final UiLabels labels                            = GetIt.instance<UiLabels>();
  final _formKey                                   = GlobalKey<FormState>();
  final List<ClientModel> _clients                 = [];

  void _addClient() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _clients.add(ClientModel(
          name     : _nameController.text,
          lastname : _lastnameController.text,
          email    : _emailController.text,
        ));

        _nameController.clear();
        _emailController.clear();
        _lastnameController.clear();
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
        content         : CustomText(text: message, type: TextType.normal),
        backgroundColor : color,
        behavior        : SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        body: () => Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color        : Colors.black.withValues(alpha: 0.1),
                      blurRadius   : 10,
                      spreadRadius : 5,
                      offset       : const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize       : MainAxisSize.min,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text  : labels.register,
                        type  : TextType.title1,
                        color : Colors.green,
                      ),
                      const SizedBox(height: 20),
                      InputWidget(
                        title      : "${labels.clients}:",
                        controller : _nameController,
                        label      : labels.name,
                        icon       : Icons.person,
                        validator  : (value) {
                          if (value == null || value.isEmpty) return "Ingrese el nombre";
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      InputWidget(
                        title      : "${labels.lastname}:",
                        controller : _lastnameController,
                        label      : labels.lastname,
                        icon       : Icons.person_outline,
                        validator  : (value) {
                          if (value == null || value.isEmpty) return "Ingrese el apellido";
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      InputWidget(
                        title        : "${labels.email}:",
                        controller   : _emailController,
                        label        : labels.email,
                        icon         : Icons.email,
                        keyboardType : TextInputType.emailAddress,
                        validator    : (value) {
                          if (value == null || value.isEmpty) return "Ingrese el correo";
                          if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                            return "Correo inválido";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 20),
                      CustomButton.green(
                        text: "Agregar Cliente",
                        onPressed: _addClient,
                      ),
                      if (_clients.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        _buildClientsTable(),
                        const SizedBox(height: 20),
                        CustomButton.green(
                          text: "Registrar Clientes",
                          onPressed: _submitClients,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildClientsTable() {
    return Container(
      decoration: BoxDecoration(
        color        : Colors.white,
        borderRadius : BorderRadius.circular(10),
        border       : Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomText(
              text : "Clientes a registrar",
              type : TextType.title2,
            ),
          ),
          const Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              columns: const [
                DataColumn(label: CustomText(text: "Nombre",   type: TextType.normal)),
                DataColumn(label: CustomText(text: "Apellido", type: TextType.normal)),
                DataColumn(label: CustomText(text: "Email",    type: TextType.normal)),
                DataColumn(label: CustomText(text: "Eliminar", type: TextType.normal)),
              ],
              rows: List.generate(
                _clients.length,
                (index) => DataRow(cells: [
                  DataCell(CustomText(text: _clients[index].name,     type: TextType.normal)),
                  DataCell(CustomText(text: _clients[index].lastname, type: TextType.normal)),
                  DataCell(CustomText(text: _clients[index].email,    type: TextType.normal)),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeClient(index),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
