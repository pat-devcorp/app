import 'package:crypto_app/Domain/Model/accountable_account.dart';

import 'package:flutter/material.dart';

class AddAccountDialog extends StatefulWidget {
  const AddAccountDialog({super.key});

  @override
  AddAccountDialogState createState() => AddAccountDialogState();
}

class AddAccountDialogState extends State<AddAccountDialog> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Account"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _idController,
            decoration: const InputDecoration(labelText: "Account ID"),
          ),
          TextField(
            controller: _userController,
            decoration: const InputDecoration(labelText: "User ID"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final newAccount = AccountableAccount(
              accountableAccountId: _idController.text,
              appUserId: _userController.text,
            );
            Navigator.pop(context, newAccount);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
