import 'dart:convert';

import 'package:flutter/services.dart';

import '/Domain/Model/bootstrap.dart';
import '/Presentation/views/pages/login.dart';
import 'Presentation/views/style/theme.dart';
import 'Presentation/views/style/util.dart';
import 'locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  Map<String, dynamic> localizedStrings = {};
  try {
    final String jsonString = await rootBundle.loadString('assets/lang/en.json');
    localizedStrings = json.decode(jsonString);
  } catch (e) {
    throw Exception("Error loading language: $e");
  }

  Bootstrap bootstrap =  Bootstrap(appVersion: dotenv.get('APP_VERSION'), apiHost: dotenv.get('API_HOST'), labelStrings: localizedStrings);
  setupLocator(bootstrap);

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "JetBrains Mono", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);
    final brightnessMode = brightness == Brightness.light ? theme.light() : theme.dark();

    return MaterialApp(
      theme: brightnessMode,
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Your home page
    );
  }
}
