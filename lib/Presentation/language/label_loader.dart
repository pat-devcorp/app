import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'ui_labels.dart';

class LabelLoader {
  static Future<UiLabels> loadLabels(String locale) async {
    String jsonString =
        await rootBundle.loadString('assets/language/$locale.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return UiLabels.fromJson(jsonMap);
  }
}
