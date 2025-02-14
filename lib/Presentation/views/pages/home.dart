import '../../language/localization_service.dart';
import '../../router/router.dart';
import '../../router/model/pages.dart';
import '../model/dimension.dart';
import '../widget/notification_snack_bar.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalizationService _localizationService = GetIt.instance<LocalizationService>();
  //final authState = ref.watch(authenticationProvider);

  int _selectedIndex = 0;
  String _selectedLanguage = 'en'; // Default language

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _localizationService.welcomeMessage, // Dynamic translation
          style: TextStyle(fontSize: context.dimensions[Dimension.large]),
        ),
        actions: [
          // Language Dropdown
          DropdownButton<String>(
            value: _selectedLanguage,
            onChanged: (String? newLanguage) async {
              if (newLanguage != null) {
                await _localizationService.newLanguage;
                setState(() {
                  _selectedLanguage = newLanguage;
                });
              }
            },
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'es', child: Text('Español')),
              DropdownMenuItem(value: 'fr', child: Text('Français')),
            ],
          ),
          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              //ref.read(authenticationProvider.notifier).logout();
              NotificationSnackBar.show(context, _localizationService.logoutButtonLabel, SnackBarType.success);
              PageRouter.goToPage(context, page: Pages.login);
            },
          ),
        ],
      ),
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: _localizationService.welcomeMessage),
          const NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          const NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text("Home Screen"));
      case 1:
        return const Center(child: Text("Profile Screen"));
      case 2:
        return const Center(child: Text("Settings Screen"));
      default:
        return const Center(child: Text("Home Screen"));
    }
  }
}
