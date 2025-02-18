import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff016e00),
      surfaceTint: Color(0xff016e00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00ab00),
      onPrimaryContainer: Color(0xff003400),
      secondary: Color(0xff005826),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff007334),
      onSecondaryContainer: Color(0xff95f5a7),
      tertiary: Color(0xff0042ae),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1359db),
      onTertiaryContainer: Color(0xffd7dfff),
      error: Color(0xffbc0100),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffeb0000),
      onErrorContainer: Color(0xfffffbff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff444748),
      outline: Color(0xff747878),
      outlineVariant: Color(0xffc4c7c7),
      shadow: Color(0xFFD8D8D8),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff55e243),
      primaryFixed: Color(0xff77ff61),
      onPrimaryFixed: Color(0xff002200),
      primaryFixedDim: Color(0xff55e243),
      onPrimaryFixedVariant: Color(0xff015300),
      secondaryFixed: Color(0xff97f8a9),
      onSecondaryFixed: Color(0xff00210a),
      secondaryFixedDim: Color(0xff7cdb8f),
      onSecondaryFixedVariant: Color(0xff005323),
      tertiaryFixed: Color(0xffdbe1ff),
      onTertiaryFixed: Color(0xff00184a),
      tertiaryFixedDim: Color(0xffb3c5ff),
      onTertiaryFixedVariant: Color(0xff003fa5),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004000),
      surfaceTint: Color(0xff016e00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff017f00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00401a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff007334),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003082),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1359db),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740100),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffdc0100),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff333738),
      outline: Color(0xff4f5354),
      outlineVariant: Color(0xff6a6e6e),
      shadow: Color(0xFFD8D8D8),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff55e243),
      primaryFixed: Color(0xff017f00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff016300),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff177d3d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff00622c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2764e6),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff004bc3),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c5),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffdfdcdb),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003500),
      surfaceTint: Color(0xff016e00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff015600),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003414),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff005525),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00276d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff0041aa),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600000),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff980100),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292d2d),
      outlineVariant: Color(0xff464a4a),
      shadow: Color(0xFFD8D8D8),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff55e243),
      primaryFixed: Color(0xff015600),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003c00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff005525),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003c18),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff0041aa),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff002c7b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff55e243),
      surfaceTint: Color(0xff55e243),
      onPrimary: Color(0xff003a00),
      primaryContainer: Color(0xff00ab00),
      onPrimaryContainer: Color(0xff003400),
      secondary: Color(0xff7cdb8f),
      onSecondary: Color(0xff003916),
      secondaryContainer: Color(0xff007334),
      onSecondaryContainer: Color(0xff95f5a7),
      tertiary: Color(0xffb3c5ff),
      onTertiary: Color(0xff002a76),
      tertiaryContainer: Color(0xff1359db),
      onTertiaryContainer: Color(0xffd7dfff),
      error: Color(0xffffb4a8),
      onError: Color(0xff690100),
      errorContainer: Color(0xffff5540),
      onErrorContainer: Color(0xff360000),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc4c7c7),
      outline: Color(0xff8e9192),
      outlineVariant: Color(0xff444748),
      shadow: Color(0xFF050505),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff016e00),
      primaryFixed: Color(0xff77ff61),
      onPrimaryFixed: Color(0xff002200),
      primaryFixedDim: Color(0xff55e243),
      onPrimaryFixedVariant: Color(0xff015300),
      secondaryFixed: Color(0xff97f8a9),
      onSecondaryFixed: Color(0xff00210a),
      secondaryFixedDim: Color(0xff7cdb8f),
      onSecondaryFixedVariant: Color(0xff005323),
      tertiaryFixed: Color(0xffdbe1ff),
      onTertiaryFixed: Color(0xff00184a),
      tertiaryFixedDim: Color(0xffb3c5ff),
      onTertiaryFixedVariant: Color(0xff003fa5),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff6df958),
      surfaceTint: Color(0xff55e243),
      onPrimary: Color(0xff002d00),
      primaryContainer: Color(0xff00ab00),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff91f1a3),
      onSecondary: Color(0xff002d10),
      secondaryContainer: Color(0xff44a35d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd2dbff),
      onTertiary: Color(0xff00215f),
      tertiaryContainer: Color(0xff5f8bff),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cb),
      onError: Color(0xff540000),
      errorContainer: Color(0xffff5540),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadddd),
      outline: Color(0xffafb2b3),
      outlineVariant: Color(0xff8d9191),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff015500),
      primaryFixed: Color(0xff77ff61),
      onPrimaryFixed: Color(0xff001600),
      primaryFixedDim: Color(0xff55e243),
      onPrimaryFixedVariant: Color(0xff004000),
      secondaryFixed: Color(0xff97f8a9),
      onSecondaryFixed: Color(0xff001505),
      secondaryFixedDim: Color(0xff7cdb8f),
      onSecondaryFixedVariant: Color(0xff00401a),
      tertiaryFixed: Color(0xffdbe1ff),
      onTertiaryFixed: Color(0xff000e34),
      tertiaryFixedDim: Color(0xffb3c5ff),
      onTertiaryFixedVariant: Color(0xff003082),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc7ffb5),
      surfaceTint: Color(0xff55e243),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff51de3f),
      onPrimaryContainer: Color(0xff000f00),
      secondary: Color(0xffc1ffc7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff78d78b),
      onSecondaryContainer: Color(0xff000f03),
      tertiary: Color(0xffedefff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffaec1ff),
      onTertiaryContainer: Color(0xff000927),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea1),
      onErrorContainer: Color(0xff220000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeef0f1),
      outlineVariant: Color(0xffc0c3c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff015500),
      primaryFixed: Color(0xff77ff61),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff55e243),
      onPrimaryFixedVariant: Color(0xff001600),
      secondaryFixed: Color(0xff97f8a9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff7cdb8f),
      onSecondaryFixedVariant: Color(0xff001505),
      tertiaryFixed: Color(0xffdbe1ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb3c5ff),
      onTertiaryFixedVariant: Color(0xff000e34),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff474646),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );

  /// Custom Color 1
  static const customColor1 = ExtendedColor(
    seed: Color(0xff333333),
    value: Color(0xff333333),
    light: ColorFamily(
      color: Color(0xff1e1e1e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff333333),
      onColorContainer: Color(0xff9c9b9b),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff1e1e1e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff333333),
      onColorContainer: Color(0xff9c9b9b),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff1e1e1e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff333333),
      onColorContainer: Color(0xff9c9b9b),
    ),
    dark: ColorFamily(
      color: Color(0xffc8c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff333333),
      onColorContainer: Color(0xff9c9b9b),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffc8c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff333333),
      onColorContainer: Color(0xff9c9b9b),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffc8c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff333333),
      onColorContainer: Color(0xff9c9b9b),
    ),
  );

  /// Custom Color 2
  static const customColor2 = ExtendedColor(
    seed: Color(0xffa6a6a6),
    value: Color(0xffa6a6a6),
    light: ColorFamily(
      color: Color(0xff5e5e5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffa6a6a6),
      onColorContainer: Color(0xff3b3c3c),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff5e5e5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffa6a6a6),
      onColorContainer: Color(0xff3b3c3c),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff5e5e5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffa6a6a6),
      onColorContainer: Color(0xff3b3c3c),
    ),
    dark: ColorFamily(
      color: Color(0xffc7c6c6),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffa6a6a6),
      onColorContainer: Color(0xff3b3c3c),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffc7c6c6),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffa6a6a6),
      onColorContainer: Color(0xff3b3c3c),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffc7c6c6),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffa6a6a6),
      onColorContainer: Color(0xff3b3c3c),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    customColor1,
    customColor2,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
