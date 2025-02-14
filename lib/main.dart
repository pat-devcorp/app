import 'package:app/Domain/Model/bootstrap.dart';
import 'package:app/Presentation/views/pages/login.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  Bootstrap bootstrap =  Bootstrap(appVersion: dotenv.get('APP_VERSION'), apiHost: dotenv.get('API_HOST'));
  setupLocator(bootstrap);

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    ),
  );
}
