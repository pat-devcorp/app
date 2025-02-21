import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../router/page_router.dart';
import '../../router/pages.dart';
import '../organisms/context_menu_floating_action_button.dart';
import '../organisms/modal_bottom_sheet_select_with_search.dart';
import '../templates/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  UserCardItem? _user;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Simulate fetching user data (replace with your actual API call)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        //_user = UserWalletCardItem(
        //  tittle: 'Ahorro Soles',
        //  detail: '4567',
        //  amount: 'S/ 2,574.93',
        //);
        _user = UserCardItem(name: "Patrick Alonso F. Carpio");
      });
    });
  }

  void onSeeDetail() {
      PageRouter.goToPage(context, page: Pages.settings, transition: PageTransitionType.rightToLeft);
  }

  @override
  void dispose() {
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
            child:
                _user != null ? UserCard(user: _user!, onPressed: onSeeDetail) : UserCard(user: null),
          ),
          Center(
              child: ElevatedButton(
                onPressed: () {
                  PageRouter.goToPage(context, page: Pages.settings, transition: PageTransitionType.rightToLeft);
                },
                child: const Text('Go to Settings'),
              ),
          ),
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
