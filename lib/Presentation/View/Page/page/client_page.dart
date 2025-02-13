

// import 'package:app/Application/State/client_state.dart';
// import 'package:app/Presentation/View/Page/widget/button_widgets.dart';
// import 'package:app/Presentation/View/Page/widget/colors_widgets.dart';
// import 'package:app/Presentation/View/Page/widget/input_widgets.dart';
// import 'package:app/Presentation/View/Page/widget/texts_widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';

// class ClientPage extends StatefulWidget {
//   const ClientPage({super.key});

//   @override
//   State<ClientPage> createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController    = TextEditingController();
//   final TextEditingController _lastNameController  = TextEditingController();
//   final TextEditingController _dniController       = TextEditingController();
//   final TextEditingController _direccionController = TextEditingController();

//   void _submitForm(BuildContext context, WidgetRef ref) {
//     if (_formKey.currentState!.validate()) {
//       ref.read(clientProvider.notifier).registerClient(
//             context,
//             name      : _nameController.text,
//             lastName  : _apellidoController.text,
//             dni       : _dniController.text,
//             address   : _direccionController.text,
//           );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final clientState = ref.watch(clientProvider);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomText(
//                 text: 'Registro de cliente:',
//                 type: TextType.title2,
//                 color: AppColors.textBlack,
//               ),
//               SizedBox(height: 10),
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         InputWidgets(controller: _nombreController, label: 'Nombre', icon: Icons.person),
//                         SizedBox(height: 10),
//                         InputWidgets(controller: _apellidoController, label: 'Apellido', icon: Icons.person_outline),
//                         SizedBox(height: 10),
//                         InputWidgets(controller: _dniController, label: 'DNI', icon: Icons.credit_card),
//                         SizedBox(height: 10),
//                         InputWidgets(controller: _direccionController, label: 'Dirección', icon: Icons.location_on),
//                         SizedBox(height: 20),
//                         Center(
//                           child: clientState == ClientState.loading
//                               ? CircularProgressIndicator()
//                               : GreenButton(text: 'Registrar', onPressed: _submitForm),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
