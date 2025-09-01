import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Colors.teal[700]!,
      surfaceTint: const Color(0xff00687b),
      onPrimary: const Color(0xffffffff),
      primaryContainer: const Color(0xffafecff),
      onPrimaryContainer: const Color(0xff004e5d),
      secondary: const Color(0xff4b6269),
      onSecondary: const Color(0xffffffff),
      secondaryContainer: const Color(0xffcee7ef),
      onSecondaryContainer: const Color(0xff344a51),
      tertiary: const Color(0xff575c7e),
      onTertiary: const Color(0xffffffff),
      tertiaryContainer: const Color(0xffdee0ff),
      onTertiaryContainer: const Color(0xff404565),
      error: const Color(0xffba1a1a),
      onError: const Color(0xffffffff),
      errorContainer: const Color(0xffffdad6),
      onErrorContainer: const Color(0xff93000a),
      surface: const Color(0xfff5fafc),
      onSurface: const Color(0xff171c1e),
      onSurfaceVariant: const Color(0xff40484b),
      outline: const Color(0xff70787c),
      outlineVariant: const Color(0xffbfc8cb),
      shadow: const Color(0xff000000),
      scrim: const Color(0xff000000),
      inverseSurface: const Color(0xff2c3133),
      inversePrimary: const Color(0xff85d2e8),
      primaryFixed: const Color(0xffafecff),
      onPrimaryFixed: const Color(0xff001f27),
      primaryFixedDim: const Color(0xff85d2e8),
      onPrimaryFixedVariant: const Color(0xff004e5d),
      secondaryFixed: const Color(0xffcee7ef),
      onSecondaryFixed: const Color(0xff061f25),
      secondaryFixedDim: const Color(0xffb2cbd3),
      onSecondaryFixedVariant: const Color(0xff344a51),
      tertiaryFixed: const Color(0xffdee0ff),
      onTertiaryFixed: const Color(0xff141937),
      tertiaryFixedDim: const Color(0xffc0c4eb),
      onTertiaryFixedVariant: const Color(0xff404565),
      surfaceDim: const Color(0xffd6dbdd),
      surfaceBright: const Color(0xfff5fafc),
      surfaceContainerLowest: const Color(0xffffffff),
      surfaceContainerLow: const Color(0xffeff4f7),
      surfaceContainer: const Color(0xffe9eff1),
      surfaceContainerHigh: const Color(0xffe4e9eb),
      surfaceContainerHighest: const Color(0xffdee3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003c48),
      surfaceTint: Color(0xff00687b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1f778b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff233940),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5a7178),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2f3453),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff666b8d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff0c1214),
      onSurfaceVariant: Color(0xff2f383a),
      outline: Color(0xff4b5457),
      outlineVariant: Color(0xff666e72),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff85d2e8),
      primaryFixed: Color(0xff1f778b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005d6f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5a7178),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff42585f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff666b8d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4e5374),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c7ca),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffe4e9eb),
      surfaceContainerHigh: Color(0xffd8dee0),
      surfaceContainerHighest: Color(0xffcdd2d5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00313c),
      surfaceTint: Color(0xff00687b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005160),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff182f36),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff364d54),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff252a48),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff424767),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252d30),
      outlineVariant: Color(0xff424b4e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff85d2e8),
      primaryFixed: Color(0xff005160),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003844),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff364d54),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1f363d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff424767),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2b314f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4babc),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf1f4),
      surfaceContainer: Color(0xffdee3e6),
      surfaceContainerHigh: Color(0xffd0d5d8),
      surfaceContainerHighest: Color(0xffc2c7ca),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff85d2e8),
      surfaceTint: Color(0xff85d2e8),
      onPrimary: Color(0xff003641),
      primaryContainer: Color(0xff004e5d),
      onPrimaryContainer: Color(0xffafecff),
      secondary: Color(0xffb2cbd3),
      onSecondary: Color(0xff1d343a),
      secondaryContainer: Color(0xff344a51),
      onSecondaryContainer: Color(0xffcee7ef),
      tertiary: Color(0xffc0c4eb),
      onTertiary: Color(0xff292e4d),
      tertiaryContainer: Color(0xff404565),
      onTertiaryContainer: Color(0xffdee0ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffdee3e6),
      onSurfaceVariant: Color(0xffbfc8cb),
      outline: Color(0xff899295),
      outlineVariant: Color(0xff40484b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff00687b),
      primaryFixed: Color(0xffafecff),
      onPrimaryFixed: Color(0xff001f27),
      primaryFixedDim: Color(0xff85d2e8),
      onPrimaryFixedVariant: Color(0xff004e5d),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff061f25),
      secondaryFixedDim: Color(0xffb2cbd3),
      onSecondaryFixedVariant: Color(0xff344a51),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff141937),
      tertiaryFixedDim: Color(0xffc0c4eb),
      onTertiaryFixedVariant: Color(0xff404565),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2022),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9be8ff),
      surfaceTint: Color(0xff85d2e8),
      onPrimary: Color(0xff002a33),
      primaryContainer: Color(0xff4d9bb0),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc8e0e9),
      onSecondary: Color(0xff11292f),
      secondaryContainer: Color(0xff7d959c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd6daff),
      onTertiary: Color(0xff1e2342),
      tertiaryContainer: Color(0xff8a8eb3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd5dee1),
      outline: Color(0xffaab3b7),
      outlineVariant: Color(0xff899295),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff004f5f),
      primaryFixed: Color(0xffafecff),
      onPrimaryFixed: Color(0xff001419),
      primaryFixedDim: Color(0xff85d2e8),
      onPrimaryFixedVariant: Color(0xff003c48),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff001419),
      secondaryFixedDim: Color(0xffb2cbd3),
      onSecondaryFixedVariant: Color(0xff233940),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff090e2c),
      tertiaryFixedDim: Color(0xffc0c4eb),
      onTertiaryFixedVariant: Color(0xff2f3453),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff404547),
      surfaceContainerLowest: Color(0xff04080a),
      surfaceContainerLow: Color(0xff191e20),
      surfaceContainer: Color(0xff23292b),
      surfaceContainerHigh: Color(0xff2e3335),
      surfaceContainerHighest: Color(0xff393f41),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd7f5ff),
      surfaceTint: Color(0xff85d2e8),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff81cee4),
      onPrimaryContainer: Color(0xff000d12),
      secondary: Color(0xffdbf4fd),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffaec7cf),
      onSecondaryContainer: Color(0xff000d12),
      tertiary: Color(0xffefeeff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbcc0e7),
      onTertiaryContainer: Color(0xff040826),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe9f1f5),
      outlineVariant: Color(0xffbbc4c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff004f5f),
      primaryFixed: Color(0xffafecff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff85d2e8),
      onPrimaryFixedVariant: Color(0xff001419),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb2cbd3),
      onSecondaryFixedVariant: Color(0xff001419),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc0c4eb),
      onTertiaryFixedVariant: Color(0xff090e2c),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff4b5153),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b2022),
      surfaceContainer: Color(0xff2c3133),
      surfaceContainerHigh: Color(0xff373c3e),
      surfaceContainerHighest: Color(0xff42484a),
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
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
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
