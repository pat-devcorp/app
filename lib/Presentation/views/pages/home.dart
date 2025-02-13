import 'package:app/Presentation/router/router.dart';
import 'package:app/Presentation/views/widget/button_widgets.dart';
import 'package:app/Presentation/views/widget/colors_widgets.dart';
import 'package:app/Presentation/views/widget/texts_widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final String userName = "Kevin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.logout_outlined, color: AppColors.mainGreen, size: 30),
              onPressed: () => PageRouter.goToPage(context, page: Pages.home),
            ),
          ),
        ],
      ),
      body : Center(
        child : SizedBox(
          height : MediaQuery.of(context).size.width,
          width  : MediaQuery.of(context).size.width ,
          child  : Card(
            elevation : 5,
            shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child     : 
            Padding(
              padding : const EdgeInsets.all(20.0),
              child   : 
              Column(
                mainAxisAlignment  : MainAxisAlignment.center,
                crossAxisAlignment : CrossAxisAlignment.center,
                children : [
                  CustomText(text: 'Datos del Usuario', type: TextType.title2),
                  Table(
                    border: TableBorder.all(
                      color: Colors.black26,
                      width: 1,
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.2),
                      1: FixedColumnWidth(MediaQuery.of(context).size.width * 0.2),
                    },
                    children: const [
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomText(text: 'Nombre', type: TextType.normal),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomText(text: 'Luis', type: TextType.small)
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomText(text: 'Email', type: TextType.normal),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomText(text: 'juanperez@example.com', type: TextType.small)
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomText(text: 'Teléfono', type: TextType.normal)
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomText(text: '+123456789', type: TextType.small)
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50), // Espacio entre la tabla y el botón
                  GreenButton(
                    text: 'Ir a Registrar',
                    onPressed: () {
                      PageRouter.goToPage(context, page: Pages.client);
                    },
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
