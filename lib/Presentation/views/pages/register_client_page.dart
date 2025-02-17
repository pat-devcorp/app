import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app/Domain/Model/client_model.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:app/Presentation/language/ui_labels.dart';
import 'package:app/Presentation/views/style/dimension.dart';
import 'package:app/Presentation/views/style/font_size.dart';
import 'package:app/Presentation/views/widget/body_widget.dart';

class RegisterClientPage extends StatefulWidget {
  const RegisterClientPage({super.key});

  @override
  State<RegisterClientPage> createState() => _RegisterClientPageState();
}

class _RegisterClientPageState extends State<RegisterClientPage> {
  final UiLabels labels = GetIt.instance<UiLabels>();
  final _formKey = GlobalKey<FormState>();
  final ClientService _clientService = ClientService();

  String name = '';
  String email = '';
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      try {
        ClientModel newClient = ClientModel(name: name, email: email);

        bool success = await _clientService.registerClient(newClient);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? "Cliente registrado con éxito!" : "Error al registrar cliente"),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error de conexión: $error"), backgroundColor: Colors.red),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent.withOpacity(0.2),
                    child: Icon(
                      Icons.person_add,
                      color: Colors.blueAccent,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: context.dimensions[Dimension.large]),

                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.blueAccent.withOpacity(0.2),
                    child: Padding(
                      padding: EdgeInsets.all(context.dimensions[Dimension.large]!),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              labels.registerClient,
                              style: TextStyle(
                                fontSize: context.fontSizes[FontSize.headline4],
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: context.dimensions[Dimension.large]),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: labels.name,
                                prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Por favor, ingresa el nombre";
                                }
                                return null;
                              },
                              onSaved: (value) => name = value!,
                            ),
                            SizedBox(height: context.dimensions[Dimension.medium]),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: labels.email,
                                prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Por favor, ingresa el correo";
                                }
                                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                                  return "Correo inválido";
                                }
                                return null;
                              },
                              onSaved: (value) => email = value!,
                            ),
                            SizedBox(height: context.dimensions[Dimension.large]),

                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: _submitForm,
                                    child: Text(
                                      labels.register,
                                      style: TextStyle(
                                        fontSize: context.fontSizes[FontSize.button],
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
