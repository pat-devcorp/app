import 'package:crypto_app/Presentation/View/accountable_account.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Acountable Account App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AccountableAccountPage(), // Use your page here
    );
  }
}
