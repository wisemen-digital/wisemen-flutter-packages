import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './base/base.dart';
import './colors/colors.dart';
import './styles/styles.dart';
import './theming/theming.dart';

/// A theming system for Flutter applications that provides comprehensive theme management
/// with support for multiple themes and light/dark mode.
///
/// This class manages theme initialization and switching, providing Material and Cupertino
/// themes that are synchronized with the current theme's color scheme.
///
/// Example:
/// ```dart
/// // Initialize the theming system
/// final theming = WiseTheming.init(
///   supportedThemes: [myCustomTheme],
///   currentTheme: 'default',
/// );
///
/// // Use in MaterialApp
/// MaterialApp(
///   theme: theming.getLightTheme(),
///   darkTheme: theming.getdarkTheme(),
///   ...
/// );
/// ```
class WiseTheming {
  /// The list of all themes supported by the application.
  ///
  /// This should be set during initialization via [init].
  static List<WiseTheme> supportedThemes = [];

  /// The currently active theme.
  ///
  /// This is set during initialization and can be changed using [setCurrentTheme].
  static WiseTheme currentTheme = baseTheme;

  /// Base theme configuration used as a foundation for both light and dark themes.
  ///
  /// This includes platform-specific configurations such as:
  /// - Material 3 design system
  /// - Platform-specific fonts (CupertinoSystemDisplay for iOS, RobotoFlex for others)
  /// - Platform-specific splash effects
  /// - Custom page transitions
  static ThemeData baseThemeData = ThemeData(
    useMaterial3: true,
    fontFamily: !kIsWeb && Platform.isIOS ? 'CupertinoSystemDisplay' : 'RobotoFlex',
    appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
    splashFactory: !kIsWeb && Platform.isIOS ? NoSplash.splashFactory : null,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  /// Generates a light theme based on the current theme's light color scheme.
  ///
  /// The generated theme includes:
  /// - Material and Cupertino theme configurations
  /// - Light color scheme mapped from [currentTheme.lightColors]
  /// - Optional custom input decoration theme
  ///
  /// [inputDecoration] - Optional input decoration theme to override the default.
  ///
  /// Returns a [ThemeData] configured for light mode.
  ThemeData getLightTheme({InputDecorationTheme? inputDecoration}) {
    return baseThemeData.copyWith(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(),
      scaffoldBackgroundColor: currentTheme.lightColors.backgroundColors.primary,
      colorScheme: ColorScheme.light(
        primary: currentTheme.lightColors.backgroundColors.primary,
        onSurface: currentTheme.lightColors.foregroundColors.primary,
        onPrimaryFixedVariant: currentTheme.lightColors.textColors.primary,
        onSurfaceVariant: currentTheme.lightColors.borderColors.primary,
        error: currentTheme.lightColors.foregroundColors.errorPrimary,
        errorContainer: currentTheme.lightColors.backgroundColors.errorPrimary,
        onErrorContainer: currentTheme.lightColors.foregroundColors.errorPrimary,
        tertiary: currentTheme.lightColors.backgroundColors.tertiary,
        onTertiary: currentTheme.lightColors.foregroundColors.tertiary,
        inversePrimary: currentTheme.lightColors.foregroundColors.primary,
        surfaceContainer: currentTheme.lightColors.backgroundColors.secondary,
        primaryContainer: currentTheme.lightColors.foregroundColors.secondary,
      ),
      inputDecorationTheme: inputDecoration,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: currentTheme.lightColors.backgroundColors.primary,
        primaryContrastingColor: currentTheme.lightColors.foregroundColors.primary,
        barBackgroundColor: currentTheme.lightColors.backgroundColors.primary,
        brightness: Brightness.light,
        scaffoldBackgroundColor: currentTheme.lightColors.backgroundColors.primary,
      ),
    );
  }

  /// Generates a dark theme based on the current theme's dark color scheme.
  ///
  /// The generated theme includes:
  /// - Material and Cupertino theme configurations
  /// - Dark color scheme mapped from [currentTheme.darkColors]
  /// - Optional custom input decoration theme
  ///
  /// [inputDecoration] - Optional input decoration theme to override the default.
  ///
  /// Returns a [ThemeData] configured for dark mode.
  ThemeData getdarkTheme({InputDecorationTheme? inputDecoration}) {
    return baseThemeData.copyWith(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(),
      scaffoldBackgroundColor: currentTheme.darkColors.backgroundColors.primary,
      colorScheme: ColorScheme.light(
        primary: currentTheme.darkColors.backgroundColors.primary,
        onSurface: currentTheme.darkColors.foregroundColors.primary,
        onPrimaryFixedVariant: currentTheme.darkColors.textColors.primary,
        onSurfaceVariant: currentTheme.darkColors.borderColors.primary,
        error: currentTheme.darkColors.foregroundColors.errorPrimary,
        errorContainer: currentTheme.darkColors.backgroundColors.errorPrimary,
        onErrorContainer: currentTheme.darkColors.foregroundColors.errorPrimary,
        tertiary: currentTheme.darkColors.backgroundColors.tertiary,
        onTertiary: currentTheme.darkColors.foregroundColors.tertiary,
        inversePrimary: currentTheme.darkColors.foregroundColors.primary,
        surfaceContainer: currentTheme.darkColors.backgroundColors.secondary,
        primaryContainer: currentTheme.darkColors.foregroundColors.secondary,
      ),
      inputDecorationTheme: inputDecoration,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: currentTheme.darkColors.backgroundColors.primary,
        primaryContrastingColor: currentTheme.darkColors.foregroundColors.primary,
        barBackgroundColor: currentTheme.darkColors.backgroundColors.primary,
        brightness: Brightness.light,
        scaffoldBackgroundColor: currentTheme.darkColors.backgroundColors.primary,
      ),
    );
  }

  /// Initializes the theming system with supported themes and sets the current theme.
  ///
  /// This method must be called before using any other theming functionality.
  /// It sets up the list of available themes and activates the specified theme.
  ///
  /// [supportedThemes] - List of all themes that the application supports.
  /// [currentTheme] - The identifier of the theme to activate initially.
  ///
  /// Returns a [WiseTheming] instance configured with the current theme.
  ///
  /// Example:
  /// ```dart
  /// final theming = WiseTheming.init(
  ///   supportedThemes: [theme1, theme2],
  ///   currentTheme: 'theme1',
  /// );
  /// ```
  static WiseTheming init({
    required List<WiseTheme> supportedThemes,
    required String currentTheme,
  }) {
    WiseTheming.supportedThemes = supportedThemes;

    return setCurrentTheme(currentTheme);
  }

  /// Changes the current active theme to the one matching the provided identifier.
  ///
  /// If a theme with the given identifier is found in [supportedThemes], it becomes
  /// the new [currentTheme]. If no matching theme is found, the base theme is used instead.
  ///
  /// [themeIdentifier] - The identifier of the theme to activate.
  ///
  /// Returns a [WiseTheming] instance configured with the selected theme.
  ///
  /// Example:
  /// ```dart
  /// // Switch to a different theme
  /// final theming = WiseTheming.setCurrentTheme('dark-mode');
  /// ```
  static WiseTheming setCurrentTheme(String themeIdentifier) {
    final themes = supportedThemes.where((t) => t.identifier == themeIdentifier);

    if (themes.isNotEmpty) {
      currentTheme = themes.first;
    } else {
      currentTheme = baseTheme;
    }

    return WiseTheming();
  }
}

/// Extension on [BuildContext] providing convenient access to theme properties.
///
/// This extension provides quick access to commonly used theme properties
/// without needing to call `Theme.of(context)` repeatedly.
extension ThemeExtention on BuildContext {
  /// Returns the current [ColorScheme] from the theme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current [Brightness] (light or dark mode) from the color scheme.
  Brightness get brightness => colorScheme.brightness;
}

/// Extension on [BuildContext] providing access to theme-aware color sets.
///
/// This extension automatically selects the appropriate color set (light or dark)
/// based on the current brightness setting. Each getter returns a type-specific
/// color collection that adapts to the current theme mode.
///
/// Example:
/// ```dart
/// // In a widget build method
/// Container(
///   color: context.bgColor.primary,
///   child: Text(
///     'Hello',
///     style: TextStyle(color: context.textColor.primary),
///   ),
/// )
/// ```
extension ColorClassesExtensions on BuildContext {
  bool get _isDark => brightness == Brightness.dark;

  /// Returns the appropriate [TextColors] for the current brightness.
  TextColors get textColor => _isDark ? DarkTextColors() : LightTextColors();

  /// Returns the appropriate [ForegroundColors] for the current brightness.
  ForegroundColors get fgColor => _isDark ? DarkForegroundColors() : LightForegroundColors();

  /// Returns the appropriate [BorderColors] for the current brightness.
  BorderColors get borderColor => _isDark ? DarkBorderColors() : LightBorderColors();

  /// Returns the appropriate [BackgroundColors] for the current brightness.
  BackgroundColors get bgColor => _isDark ? DarkBackgroundColors() : LightBackgroundColors();

  /// Returns the appropriate [UtilityColors] for the current brightness.
  UtilityColors get utilityColor => _isDark ? DarkUtilityColors() : LightUtilityColors();
}

/// Extension on [BuildContext] providing convenient access to pre-styled text styles.
///
/// This extension provides quick access to common text styles with appropriate colors
/// automatically applied based on the current theme brightness.
///
/// Example:
/// ```dart
/// Text('Title', style: context.title)
/// Text('Body text', style: context.normal)
/// Text('Label', style: context.label)
/// ```
extension TextStyleExtension on BuildContext {
  /// Returns the title text style with appropriate color for the current theme.
  TextStyle get title => AppStyles.title.copyWith(color: textColor.primaryOnBrand);

  /// Returns the normal body text style with appropriate color for the current theme.
  TextStyle get normal => AppStyles.normal.copyWith(color: textColor.primary);

  /// Returns the label text style with appropriate color for the current theme.
  TextStyle get label => AppStyles.label.copyWith(color: textColor.secondary);

  /// Returns the button text style with appropriate color for the current theme.
  TextStyle get button => AppStyles.button.copyWith(color: textColor.primaryOnBrand);
}
