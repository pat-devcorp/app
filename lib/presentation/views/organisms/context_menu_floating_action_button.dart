import 'package:flutter/material.dart';

import '../style/dimensions.dart';

class ContextMenuFloatingActionButton extends StatelessWidget {
  final List<ContextMenuAction> actions;

  const ContextMenuFloatingActionButton({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final kPrimary = colorScheme.primary;
    final kOnPrimary = colorScheme.onPrimary;
    final kSurface = colorScheme.surface;
    final kOnSurfaceVariant = colorScheme.onSurfaceVariant;
    final kOnSurface = colorScheme.onSurface;
    final kLayoutRadius = Dimensions.radius.xlarge;

    return FloatingActionButton(
      onPressed: () {
        _showContextMenu(context, colorScheme, kSurface, kOnSurfaceVariant,
            kOnSurface, kLayoutRadius);
      },
      backgroundColor: kPrimary,
      foregroundColor: kOnPrimary,
      child: const Icon(Icons.menu),
    );
  }

  void _showContextMenu(
      BuildContext context,
      ColorScheme colorScheme,
      Color surface,
      Color onSurfaceVariant,
      Color onSurface,
      double layoutRadius) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(layoutRadius),
              topRight: Radius.circular(layoutRadius),
            ),
          ),
          child: ListView.builder(
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return ListTile(
                leading: Icon(action.icon, color: onSurfaceVariant),
                title: Text(action.label, style: TextStyle(color: onSurface)),
                onTap: () {
                  action.onPressed();
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class ContextMenuAction {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  ContextMenuAction(
      {required this.icon, required this.label, required this.onPressed});
}
