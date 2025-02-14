import 'package:flutter/material.dart';

enum Padding {
  xlarge,
  large,
  medium,
  small,
  xsmall,
  screen,
}

extension PaddingExtension on BuildContext {
  Map<Padding, double> get paddings {
    return const {
      Padding.xlarge: 20,
      Padding.large: 16,
      Padding.medium: 12,
      Padding.small: 8,
      Padding.xsmall: 4,
      Padding.screen: 20,
    };
  }
}