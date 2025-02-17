import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../language/ui_labels.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final UiLabels labels = GetIt.instance<UiLabels>();
    
    return NavigationBar(
      height: 80,
      backgroundColor: Colors.white,
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
      destinations: [
        _buildNavItem(0, Icons.calendar_today, labels.menuItemHome),
        _buildNavItem(1, Icons.search, labels.menuItemSettings),
      ],
    );
  }

  NavigationDestination _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = selectedIndex == index;

    return NavigationDestination(
      icon: isSelected
          ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          const Icon(Icons.circle, size: 6, color: Colors.black),
        ],
      )
          : Icon(icon, color: Colors.grey.shade600),
      label: '',
    );
  }
}
