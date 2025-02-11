import 'package:crypto_app/Domain/Model/accountable_account.dart';
import 'package:crypto_app/Infrastructure/Service/rest_accountable_account.dart';

import 'package:crypto_app/Presentation/View/detail_accountable_account.dart';
import 'package:crypto_app/Presentation/View/add_account_dialog.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AccountableAccountPage extends StatefulWidget {
  const AccountableAccountPage({super.key});

  @override
  _AccountableAccountPageState createState() => _AccountableAccountPageState();
}

class _AccountableAccountPageState extends State<AccountableAccountPage> {
  final List<AccountableAccount> _accountableAccounts = [];

  @override
  void initState() {
    super.initState();
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    try {
      final restAccountableAccount = RestAccountableAccount(
          Dio(BaseOptions(contentType: "application/json")));
      List<AccountableAccount> accounts =
          await restAccountableAccount.getAccountableAccount();
      setState(() {
        _accountableAccounts.clear();
        _accountableAccounts.addAll(accounts);
      });
    } catch (e) {
      print("Error fetching accounts: $e");
      _accountableAccounts.addAll([
        AccountableAccount(accountableAccountId: 'mock1', appUserId: 'user1'),
        AccountableAccount(accountableAccountId: 'mock2', appUserId: 'user2'),
      ]);
    }
  }

  void _addNewAccount() async {
    final newAccount = await showDialog<AccountableAccount>(
      context: context,
      builder: (context) => const AddAccountDialog(),
    );

    if (newAccount != null) {
      setState(() {
        _accountableAccounts.insert(0, newAccount);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text('FLUTTER GUYS / RETROFIT'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _accountableAccounts.length + 1, // +1 for the "Add New" item
        itemBuilder: (context, index) {
          if (index == 0) {
            return Card(
              margin: const EdgeInsets.all(16),
              color: Colors.greenAccent,
              child: ListTile(
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text("Add New Account",
                    style: TextStyle(color: Colors.white)),
                onTap: _addNewAccount,
              ),
            );
          }
          final account = _accountableAccounts[index - 1];
          return Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              title: Text(account.accountableAccountId),
              subtitle: Text(account.appUserId),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailAccountableAccountPage(
                        accountableAccount: account),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
