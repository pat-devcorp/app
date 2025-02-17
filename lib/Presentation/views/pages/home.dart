import 'package:app/Presentation/router/pages.dart';
import 'package:app/Presentation/router/router.dart';

import '../widget/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Page ${_selectedIndex + 1}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                PageRouter.goToPage(context, page: Pages.clientList);
              },
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
