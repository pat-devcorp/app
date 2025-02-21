import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'setup_locator.dart';
import 'domain/model/bootstrap.dart';
import 'presentation/language/label_loader.dart';
import 'presentation/language/ui_labels.dart';
//import 'presentation/views/style/theme.dart';
//import 'presentation/views/style/util.dart';
import 'presentation/views/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  UiLabels labels = await LabelLoader.loadLabels('es');

  Bootstrap bootstrap = (appVersion: dotenv.get('APP_VERSION'), apiHost: dotenv.get('API_HOST'), requestTimeoutInSeconds: int.parse(dotenv.get('REQUEST_TIMEOUT')));
  setupLocator(bootstrap, labels);

  log('Bootstrap load: $bootstrap');

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
    //final brightness = View.of(context).platformDispatcher.platformBrightness;
    //TextTheme textTheme = createTextTheme(context, "JetBrains Mono", "Roboto");
    //final brightnessMode = brightness == Brightness.light ? theme.light() : theme.dark();

    return MaterialApp(
      //theme: brightnessMode,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
