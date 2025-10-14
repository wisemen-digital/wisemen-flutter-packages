// ignore_for_file: comment_references

import 'package:flutter/material.dart';

/// [WiseThemeType] to translate [WiseTheme] to Material [ThemeData]
/// MaterialApp takes a `darkTheme` and `theme` parameter, this distinguishes
/// placement of a given [WiseTheme].
/// An app can have multiple [WiseTheme] instances of the same type
enum WiseThemeType {
  /// Used for instances where ThemeData's brightness would be light
  light,

  /// Used for instances where ThemeData's brightness would be light with accessibility contrast
  lightContrast,

  /// Used for instances where ThemeData's brightness would be dark
  dark,

  /// Used for instances where ThemeData's brightness would be dark with accessibility contrast
  darkContrast;

  /// Maps [WiseThemeType] to Flutter's built-in [Brightness] enum.
  Brightness get brightness {
    switch (this) {
      case WiseThemeType.light:
      case WiseThemeType.lightContrast:
        return Brightness.light;
      case WiseThemeType.dark:
      case WiseThemeType.darkContrast:
        return Brightness.dark;
    }
  }

  /// Maps [WiseThemeType] to Flutter's built-in [ThemeMode] enum.
  ThemeMode get themeMode {
    switch (this) {
      case WiseThemeType.light:
      case WiseThemeType.lightContrast:
        return ThemeMode.light;
      case WiseThemeType.dark:
      case WiseThemeType.darkContrast:
        return ThemeMode.dark;
    }
  }

  /// Indicates if the theme type is a high contrast variant.
  /// Useful for accessibility features and adapting UI elements accordingly.
  bool get isHighContrast {
    switch (this) {
      case WiseThemeType.light:
      case WiseThemeType.dark:
        return false;
      case WiseThemeType.lightContrast:
      case WiseThemeType.darkContrast:
        return true;
    }
  }
}
