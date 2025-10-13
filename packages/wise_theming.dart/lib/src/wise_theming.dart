import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base/base.dart';
import 'theming/theming.dart';

class WiseTheming {
  static late List<WiseTheme> supportedThemes;
  static late WiseTheme currentTheme;

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

  static WiseTheming init({
    required List<WiseTheme> supportedThemes,
    required String currentTheme,
  }) {
    WiseTheming.supportedThemes = supportedThemes;

    return setCurrentTheme(currentTheme);
  }

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
