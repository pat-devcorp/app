import 'package:flutter/material.dart';

enum FontSize {
  headline1,
  headline2,
  headline3,
  headline4,
  headline5,
  headline6,
  subtitle1,
  subtitle2,
  bodyText1,
  bodyText2,
  button,
}

extension FontSizeExtension on BuildContext {
  Map<FontSize, double> get fontSizes {
    return const {
      FontSize.headline1: 28,
      FontSize.headline2: 24,
      FontSize.headline3: 20,
      FontSize.headline4: 18,
      FontSize.headline5: 16,
      FontSize.headline6: 14,
      FontSize.subtitle1: 16,
      FontSize.subtitle2: 16,
      FontSize.bodyText1: 16,
      FontSize.bodyText2: 14,
      FontSize.button: 20,
    };
  }
}