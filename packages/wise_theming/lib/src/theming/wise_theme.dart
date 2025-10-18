import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import 'theming.dart';

/// Represents a complete theme configuration with light and dark color schemes.
///
/// A [WiseTheme] encapsulates all color definitions for both light and dark modes
/// of a particular theme. Each theme is uniquely identified by its [identifier].
///
/// Example:
/// ```dart
/// final myTheme = WiseTheme(
///   identifier: 'my-theme',
///   themeType: WiseThemeType.light,
///   textColors: MyTextColors(),
///   foregroundColors: MyForegroundColors(),
///   borderColors: MyBorderColors(),
///   backgroundColors: MyBackgroundColors(),
///   utilityColors: MyUtilityColors(),
/// );
/// ```
class WiseTheme implements ThemeExtension<WiseTheme> {
  /// Creates a [WiseTheme] instance with the provided color schemes and type.
  const WiseTheme({
    required this.identifier,
    required this.themeType,
    required this.backgroundColors,
    required this.borderColors,
    required this.foregroundColors,
    required this.textColors,
    required this.utilityColors,
  });

  /// A unique identifier for this theme.
  ///
  /// Used to select and switch between different themes at runtime.
  final String identifier;

  /// Theme type for the Material app to distinguish between light and dark themes.
  final WiseThemeType themeType;

  /// Color scheme for background elements.
  final BackgroundColors backgroundColors;

  /// Color scheme for border elements.
  final BorderColors borderColors;

  /// Color scheme for foreground elements.
  final ForegroundColors foregroundColors;

  /// Color scheme for text elements.
  final TextColors textColors;

  /// Color scheme for utility elements.
  final UtilityColors utilityColors;

  @override
  ThemeExtension<WiseTheme> copyWith({
    String? identifier,
    WiseThemeType? themeType,
    BackgroundColors? backgroundColors,
    BorderColors? borderColors,
    ForegroundColors? foregroundColors,
    TextColors? textColors,
    UtilityColors? utilityColors,
  }) {
    return WiseTheme(
      identifier: identifier ?? this.identifier,
      themeType: themeType ?? this.themeType,
      backgroundColors: backgroundColors ?? this.backgroundColors,
      borderColors: borderColors ?? this.borderColors,
      foregroundColors: foregroundColors ?? this.foregroundColors,
      textColors: textColors ?? this.textColors,
      utilityColors: utilityColors ?? this.utilityColors,
    );
  }

  @override
  ThemeExtension<WiseTheme> lerp(
      covariant ThemeExtension<WiseTheme>? other, double t) {
    if (other is! WiseTheme) return this;
    return WiseTheme(
      identifier: t < 0.5 ? identifier : other.identifier,
      themeType: t < 0.5 ? themeType : other.themeType,
      backgroundColors:
          BackgroundColors.lerp(backgroundColors, other.backgroundColors, t),
      borderColors: BorderColors.lerp(borderColors, other.borderColors, t),
      foregroundColors:
          ForegroundColors.lerp(foregroundColors, other.foregroundColors, t),
      textColors: TextColors.lerp(textColors, other.textColors, t),
      utilityColors: UtilityColors.lerp(utilityColors, other.utilityColors, t),
    );
  }

  @override
  Object get type => WiseTheme;

  /// Generates a Material [ThemeData] based on the current theme.
  ///
  /// requires a [TargetPlatform] to set font family and other platform-specific styles.
  ///
  /// The generated theme includes:
  /// - Material and Cupertino theme configurations
  /// Returns a [ThemeData] configured for a MaterialApp.
  ThemeData asThemeData(TargetPlatform platform) {
    final isIOS =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    return ThemeData(
      extensions: [this],
      brightness: themeType.brightness,
      useMaterial3: true,
      fontFamily: isIOS ? 'CupertinoSystemDisplay' : 'RobotoFlex',
      splashFactory: isIOS ? NoSplash.splashFactory : null,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.fuchsia: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      scaffoldBackgroundColor: backgroundColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: foregroundColors.primary,
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        brightness: themeType.brightness,
        primary: foregroundColors.brandPrimary,
        onPrimary: textColors.primaryOnBrand,
        secondary: foregroundColors.primary,
        onSecondary: textColors.primary,
        tertiary: foregroundColors.tertiary,
        onTertiary: textColors.primary,
        error: foregroundColors.errorPrimary,
        onError: textColors.errorPrimary,
        errorContainer: backgroundColors.errorPrimary,
        onErrorContainer: foregroundColors.errorSecondary,
        primaryContainer: backgroundColors.brandPrimary,
        onPrimaryContainer: textColors.secondaryOnBrand,
        primaryFixed: foregroundColors.brandPrimary,
        primaryFixedDim: foregroundColors.brandSecondary,
        onPrimaryFixed: textColors.primaryOnBrand,
        onPrimaryFixedVariant: textColors.secondaryOnBrand,
        secondaryContainer: backgroundColors.secondary,
        onSecondaryContainer: textColors.secondary,
        secondaryFixed: foregroundColors.secondary,
        secondaryFixedDim: foregroundColors.tertiary,
        onSecondaryFixed: textColors.primary,
        onSecondaryFixedVariant: textColors.secondary,
        tertiaryContainer: backgroundColors.tertiary,
        onTertiaryContainer: textColors.tertiary,
        tertiaryFixed: foregroundColors.tertiary,
        tertiaryFixedDim: foregroundColors.quaternary,
        onTertiaryFixed: textColors.primary,
        onTertiaryFixedVariant: textColors.tertiary,
        outline: borderColors.primary,
        outlineVariant: borderColors.secondary,
        surface: backgroundColors.primary,
        onSurface: textColors.primary,
        surfaceDim: backgroundColors.secondary,
        surfaceBright: backgroundColors.tertiary,
        surfaceContainerLowest: backgroundColors.primary,
        surfaceContainerLow: backgroundColors.secondary,
        surfaceContainer: backgroundColors.tertiary,
        surfaceContainerHigh: backgroundColors.quaternary,
        surfaceContainerHighest: foregroundColors.quinary,
        onSurfaceVariant: textColors.secondary,
        inverseSurface: backgroundColors.disabled,
        onInverseSurface: textColors.disabled,
        inversePrimary: foregroundColors.disabled,
        shadow: backgroundColors.disabled,
        scrim: backgroundColors.secondaryHover,
        surfaceTint: foregroundColors.primary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColors.primary,
        foregroundColor: textColors.primary,
        iconTheme: IconThemeData(color: textColors.primary),
        actionsIconTheme: IconThemeData(color: textColors.primary),
        elevation: 0,
        centerTitle: isIOS,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: foregroundColors.brandPrimary,
        primaryContrastingColor: textColors.primaryOnBrand,
        barBackgroundColor: backgroundColors.primary,
        brightness: themeType.brightness,
        scaffoldBackgroundColor: backgroundColors.primary,
      ),
    );
  }
}
