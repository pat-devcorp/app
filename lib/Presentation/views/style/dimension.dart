import 'package:flutter/material.dart';

enum Dimension { xlarge, large, medium, small, xsmall }

extension DimensionsExtension on BuildContext {
  Map<Dimension, double> get dimensions {
    return const {
      Dimension.xlarge: 20,
      Dimension.large: 16,
      Dimension.medium: 12,
      Dimension.small: 8,
      Dimension.xsmall: 4,
    };
  }
}