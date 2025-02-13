import '../../router/pages.dart';
import '../../router/router.dart';
import '../../views/widget/button_widgets.dart';
import '../../views/widget/colors_widgets.dart';
import '../widget/texts_widgets.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              CustomText(text: 'Datos del Usuario', type: TextType.title2),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(
                          color: Colors.black26,
                          width: 1,
                        ),
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
                      const SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
