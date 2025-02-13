import 'package:flutter/material.dart';

enum AppColorType {
  grayMediumBackground,
  whiteBackground,
  grayBackground,
  transparent,
  mainGreen,
  textBlack,
  mainBlue,
  textGray,
  textRed,
}

class AppColors {
  static const Color grayMediumBackground = Color(0xFFF4F4F4);
  static const Color whiteBackground      = Color(0xFFFFFFFF);
  static const Color grayBackground       = Color(0xFFDADADA);
  static const Color mainGreen            = Color(0xFF00AB00);
  static const Color textBlack            = Color(0xFF333333);
  static const Color mainBlue             = Color(0xFF1359DB);
  static const Color textGray             = Color(0xFFA6A6A6);
  static const Color textRed              = Color(0xFFFF0000);
  static const Color transparent          = Colors.transparent;
}

extension AppColorExtension on AppColorType {
  static final Map<AppColorType, Color> _colors = {
    AppColorType.grayMediumBackground   : AppColors.grayMediumBackground,
    AppColorType.whiteBackground        : AppColors.whiteBackground,
    AppColorType.grayBackground         : AppColors.grayBackground,
    AppColorType.transparent            : AppColors.transparent,
    AppColorType.mainGreen              : AppColors.mainGreen,
    AppColorType.textBlack              : AppColors.textBlack,
    AppColorType.mainBlue               : AppColors.mainBlue,
    AppColorType.textGray               : AppColors.textGray,
    AppColorType.textRed                : AppColors.textRed,
  };

  Color get color => _colors[this]!;
}