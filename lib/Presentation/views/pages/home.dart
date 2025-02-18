import 'dart:developer';

import 'package:flutter/material.dart';

import '../widget/context_menu_floating_action_button.dart';
import '../widget/modal_bottom_sheet_select_with_search.dart';
import '../widget/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  UserCardItem? _user; // User data (initially null)

  @override
  void initState() {
    super.initState();
    // Initialize TabController with 3 tabs
    _tabController = TabController(length: 3, vsync: this);
    // Simulate fetching user data (replace with your actual API call)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _user = UserCardItem(
          tittle: 'Ahorro Soles', // Use title
          detail: '4567', // Use detail
          amount: 'S/ 2,574.93',
          icon: Image.asset('assets/icons/soles_icon.png', height: 20), // Icon provided
        );
      });
    });
  }

  @override
  void dispose() {
    // Dispose the TabController
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    String? selectedCity;

    final List<String> cities = [
      'New York',
      'Los Angeles',
      'Chicago',
      'Houston',
      'Phoenix',
      'Philadelphia',
      'San Antonio',
      'San Diego',
      'Dallas',
      'San Jose',
      'Austin',
      'Jacksonville',
      'Fort Worth',
      'Columbus',
      'Indianapolis',
      'Charlotte',
      'Detroit',
      'El Paso',
      'Memphis',
      'Boston',
      'Seattle',
      'Denver',
      'Washington',
      'Nashville',
      'Baltimore',
      'Oklahoma City',
      'Portland',
    ];

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Home Page', style: TextStyle(color: colorScheme.onPrimary)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.cloud_outlined)),
            Tab(icon: Icon(Icons.beach_access_sharp)),
            Tab(icon: Icon(Icons.brightness_5_sharp)),
          ],
          indicatorColor: colorScheme.primary,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: ModalBottomSheetSelectWithSearch<String>(
              label: 'Select City',
              options: cities,
              initialValue: selectedCity,
              displayValue: (city) => city,
              onChanged: (newValue) {
                setState(() {
                  selectedCity = newValue;
                  log('Selected city: $selectedCity');
                });
              },
              showSearch: true,
            ),
          ),
          Center(
            child: _user != null // Check if _user is not null before passing it to UserCard
                ? UserCard(user: _user!) // Use the null assertion operator (!) since you've checked for null
                : const CircularProgressIndicator(), // Or any other placeholder widget while loading
          ),
          Center(
              child: Text("It's sunny here",
                  style: TextStyle(color: colorScheme.onSurface))),
        ],
      ),
      floatingActionButton: ContextMenuFloatingActionButton(
        actions: [
          ContextMenuAction(
            icon: Icons.add,
            label: 'Add Item',
            onPressed: () {
              log("Add Item pressed");
            },
          ),
          ContextMenuAction(
            icon: Icons.edit,
            label: 'Edit Item',
            onPressed: () {
              log("Edit Item pressed");
            },
          ),
          ContextMenuAction(
            icon: Icons.delete,
            label: 'Delete Item',
            onPressed: () {
              log("Delete Item pressed");
            },
          ),
        ],
      ),
      backgroundColor: colorScheme.surface,
    );
  }
}
