import 'package:flutter/material.dart';

class ContextMenuFloatingActionButton extends StatelessWidget {
  final List<ContextMenuAction> actions;

  const ContextMenuFloatingActionButton({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      onPressed: () {
        _showContextMenu(context);
      },
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      child: const Icon(Icons.menu),
    );
  }

  void _showContextMenu(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView.builder(
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return ListTile(
                leading: Icon(action.icon, color: colorScheme.onSurfaceVariant),
                title: Text(action.label,
                    style: TextStyle(color: colorScheme.onSurface)),
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
