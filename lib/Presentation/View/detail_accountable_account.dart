import 'package:crypto_app/Domain/Model/accountable_account.dart';

import 'package:flutter/material.dart';

class DetailAccountableAccountPage extends StatelessWidget {
  final AccountableAccount accountableAccount;

  const DetailAccountableAccountPage(
      {super.key, required this.accountableAccount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${accountableAccount.accountableAccountId}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Accountable Account ID: ${accountableAccount.accountableAccountId}'),
            Text('App User ID: ${accountableAccount.appUserId}'),
            // Add more details here
          ],
        ),
      ),
    );
  }
}
