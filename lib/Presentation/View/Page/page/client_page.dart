import 'package:app/Presentation/View/Page/widget/button_widgets.dart';
import 'package:app/Presentation/View/Page/widget/colors_widgets.dart';
import 'package:app/Presentation/View/Page/widget/input_widgets.dart';
import 'package:app/Presentation/View/Page/widget/texts_widgets.dart';
import 'package:flutter/material.dart';


class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController    = TextEditingController();
  final TextEditingController _apellidoController  = TextEditingController();
  final TextEditingController _dniController       = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(
            text: 'Registro exitoso',
            type: TextType.normal,
            color: AppColors.whiteBackground,
          ),
          backgroundColor: AppColors.mainGreen,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Registro de cliente:',
                type: TextType.title2,
                color: AppColors.textBlack,
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputWidgets(
                          maxLength: 14,
                          controller: _nombreController,
                          label: 'Nombre',
                          icon: Icons.person,
                        ),
                        SizedBox(height: 10),
                        InputWidgets(
                          maxLength: 14,
                          controller: _apellidoController,
                          label: 'Apellido',
                          icon: Icons.person_outline,
                        ),
                        SizedBox(height: 10),
                        InputWidgets(
                          maxLength: 14,
                          controller: _dniController,
                          label: 'DNI',
                          icon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el DNI';
                            }
                            if (value.length < 7 || value.length > 8) {
                              return 'DNI debe tener 7 u 8 dígitos';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        InputWidgets(
                          maxLength: 24,
                          controller: _direccionController,
                          label: 'Dirección',
                          icon: Icons.location_on,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: GreenButton(
                            text: 'Registrar',
                            onPressed: _submitForm,
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
    );
  }
}
