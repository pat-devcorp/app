import 'package:app/Domain/Model/response.dart';
import 'package:app/Infrastructure/Service/client_service.dart';
import 'package:app/Presentation/router/pages.dart';
import 'package:app/Presentation/router/router.dart';
import 'package:app/Presentation/views/style/dimension.dart';
import 'package:app/Presentation/views/style/font_size.dart';
import 'package:app/Presentation/views/widget/custom_bottom_navigation_bar.dart';
import 'package:app/Presentation/views/widget/notification_snack_bar.dart';
import 'package:flutter/material.dart';



class RegisterClientPage extends StatefulWidget {
  const RegisterClientPage({super.key});

  @override
  State<RegisterClientPage> createState() => _RegisterClientPageState();
}

class _RegisterClientPageState extends State<RegisterClientPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';

  // Instancia por mientras
  final ClientService _clientService = ClientService("http://192.168.4.177:8080");

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Response result = await _clientService.registerClient(name: name, email: email);

      if (result.success) {
        NotificationSnackBar.show(context, "Registro exitoso", SnackBarType.success);
        PageRouter.goToPage(context, page: Pages.home);
      } else {
        NotificationSnackBar.show(context, "Error: ${result.data['message']}", SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Cliente", style: TextStyle(fontSize: context.fontSizes[FontSize.headline4])),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.dimensions[Dimension.medium]!),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nombre",
                  labelStyle: TextStyle(fontSize: context.fontSizes[FontSize.bodyText1]),
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
                  labelText: "Correo",
                  labelStyle: TextStyle(fontSize: context.fontSizes[FontSize.bodyText1]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, ingresa el correo";
                  }
                  return null;
                },
                onSaved: (value) => email = value!,
              ),
              SizedBox(height: context.dimensions[Dimension.large]),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Registrar", style: TextStyle(fontSize: context.fontSizes[FontSize.button])),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0,
        onItemTapped: (index) {

        },
      ),
    );
  }
}
