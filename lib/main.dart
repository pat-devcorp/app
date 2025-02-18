import 'dart:developer' show log;
import 'package:app/Presentation/riverpods/theme_riverpod.dart';
import 'package:app/Presentation/views/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/Domain/Model/bootstrap.dart';
import 'Presentation/language/label_loader.dart';
import 'Presentation/language/ui_labels.dart';
import 'Presentation/views/style/theme.dart';
import 'Presentation/views/style/util.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  UiLabels labels =
      await LabelLoader.loadLabels('es');

  Bootstrap bootstrap = Bootstrap(
      appVersion: dotenv.get('APP_VERSION'), apiHost: dotenv.get('API_HOST'));
  log('Bootstrap load: $bootstrap');
  setupLocator(bootstrap, labels);

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget  {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeRiverpodProvider);
    TextTheme textTheme = createTextTheme(context, "JetBrains Mono", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);
    final brightnessMode = themeMode == ThemeMode.light ? theme.light() : theme.dark();
    return MaterialApp(
      themeMode: ref.watch(themeRiverpodProvider),
      theme: brightnessMode,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
