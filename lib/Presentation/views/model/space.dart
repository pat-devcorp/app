import 'package:flutter/material.dart';

enum Space {
  xlarge,
  large,
  medium,
  small,
  xsmall,
}

extension SpaceExtension on BuildContext {
  Map<Space, double> get dimensions {
    return const {
      Space.xlarge: 20,
      Space.large: 16,
      Space.medium: 12,
      Space.small: 8,
      Space.xsmall: 4,
    };
  }
}