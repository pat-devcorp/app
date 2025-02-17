import 'package:flutter/material.dart';

class CurvedBottomNavigationBar extends StatefulWidget {
  final int selectedIndex; // Make sure these are here!
  final Function(int) onTabChanged; // And here!

  CurvedBottomNavigationBar(
      {required this.selectedIndex, required this.onTabChanged});

  @override
  _CurvedBottomNavigationBarState createState() =>
      _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar> {
  int _selectedIndex = 0; // Track the currently selected index

  final List<NavigationItem> _navigationItems = [
    NavigationItem(icon: Icons.home, label: 'Home'),
    NavigationItem(icon: Icons.search, label: 'Explore'),
    NavigationItem(icon: Icons.add, label: 'Add'), // This will be in the center
    NavigationItem(icon: Icons.person, label: 'Profile'),
    NavigationItem(icon: Icons.settings, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Your main content here
        child: Text('Page Content Here'),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      // Use BottomAppBar to allow the curve
      color: Color(0xFFFAF8F0), // Light beige background
      shape: CircularNotchedRectangle(), // Key for the curve
      notchMargin: 8.0, // Adjust margin for the curve's effect
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Adjust padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              _navigationItems.map((item) => _buildNavItem(item)).toList(),
        ),
      ),
    );
  }

  Widget _buildNavItem(NavigationItem item) {
    int index = _navigationItems.indexOf(item);
    bool isSelected = index == _selectedIndex;

    return InkWell(
      // Make items tappable
      onTap: () {
        setState(() {
          _selectedIndex = index;
          // Handle navigation here based on index
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            size: 32, // Adjust icon size
            color: isSelected
                ? Color(0xFFE94F37)
                : Colors.grey, // Selected/unselected colors
          ),
          Text(
            item.label,
            style: TextStyle(
              color: isSelected ? Color(0xFFE94F37) : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem({required this.icon, required this.label});
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home Content'));
  }
}

class ExploreContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Explore Content'));
  }
}

class AddContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Add Content'));
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Content'));
  }
}

class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings Content'));
  }
}
