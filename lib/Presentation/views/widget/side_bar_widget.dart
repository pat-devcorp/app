import 'package:app/Presentation/language/ui_labels.dart'; 
import 'package:app/Presentation/router/pages.dart';
import 'package:app/Presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

const Color greenColor = Color(0xFFaff21f);

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  SideBarWidgetState createState() => SideBarWidgetState();
}

class SideBarWidgetState extends State<SideBarWidget> with SingleTickerProviderStateMixin {
   int _selectedIndex = 0;
   final UiLabels labels = GetIt.instance<UiLabels>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(5, 0),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListView(
        children: [
          _buildLogo(),
          MenuItem(
            icon: Icons.dashboard, 
            title: labels.home,
            isSelected: _selectedIndex == 1,
            onTap: () {
              setState(() => _selectedIndex = 1);
              PageRouter.goToPage(context, page: Pages.home);
            },
          ),
          MenuItem(
            icon: Icons.person, 
            title: labels.clientList,
            isSelected: _selectedIndex == 2,
            onTap: () {
              setState(() => _selectedIndex = 2);
              PageRouter.goToPage(context, page: Pages.clientsList);
            }
          ),
          MenuItem(
            icon: Icons.person_add_sharp, 
            title: labels.registerClient,
            isSelected: _selectedIndex == 3,
            onTap: () {
              setState(() => _selectedIndex = 3);
              PageRouter.goToPage(context, page: Pages.registerClient);
            }
          ),
          _buildUpdateCard(),
          MenuItem(
            icon: Icons.logout_outlined, 
            title: labels.registerClient,
            isSelected: _selectedIndex == 4,
            onTap: () {
              setState(() => _selectedIndex = 4);
              PageRouter.goToPage(context, page: Pages.login);
            }
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.circle_outlined, color: greenColor, size: 35),
          Text(" 9780Bitcoin", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildUpdateCard() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.update, size: 40, color: Colors.black),
            SizedBox(height: 10),
            Text("Nuevo P2P", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Descubre nuestro\nmercado", style: TextStyle(color: Colors.black54)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Vamos   ", style: TextStyle(color: Color(0xFFF4F4F4))),
                  Icon(Icons.arrow_forward, color: Color(0xFFF4F4F4), size: 15)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  MenuItemState createState() => MenuItemState();
}

class MenuItemState extends State<MenuItem> {
  Color _containerColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _containerColor = Theme.of(context).focusColor),
      onExit: (_) => setState(() => _containerColor = Colors.transparent),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          decoration: BoxDecoration(
            color: _containerColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Icon(
              widget.icon,
              color: widget.isSelected ? greenColor : null,
              size: 20,
            ),
            title: Text(
              widget.title,
              style: const TextStyle(fontSize: 15),
            ),
            trailing: widget.isSelected
            ? const Icon(
              Icons.arrow_forward,
              size: 15,
            )
          : null,
          ),
        ),
      ),
    );
  }
}