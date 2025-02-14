import 'dart:convert';
import '../language/localization_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalizationNotifier extends StateNotifier<LocalizationService> {
  LocalizationNotifier() : super(LocalizationService(loginButtonLabel: 'Login', welcomeMessage: 'Welcome', logoutButtonLabel: 'Logout')) {
    loadLanguage('en'); // Default language
  }

  Future<void> loadLanguage(String languageCode) async {
    final String jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    state = LocalizationService.fromJson(jsonMap);
  }
}

final localizationProvider = StateNotifierProvider<LocalizationNotifier, LocalizationService>(
      (ref) => LocalizationNotifier(),
);
