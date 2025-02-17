import 'package:flutter/material.dart';

enum Dimension { xlarge, large, medium, small, xsmall }

extension DimensionsExtension on BuildContext {
  Map<Dimension, double> get dimensions {
    return const {
      Dimension.xlarge: 30,
      Dimension.large: 20,
      Dimension.medium: 12,
      Dimension.small: 8,
      Dimension.xsmall: 4,
    };
  }
}
