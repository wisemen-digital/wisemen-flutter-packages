import 'dart:io';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData baseTheme = ThemeData(
    useMaterial3: true,
    fontFamily: Platform.isIOS ? 'CupertinoSystemDisplay' : 'RobotoFlex',
    appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
    splashFactory: Platform.isIOS ? NoSplash.splashFactory : null, //remove ripple effect on InkWell buttons on IOS
  );

  //dark theme
  static ThemeData darkTheme = baseTheme.copyWith(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      // TODO(Anyone): set dark theme values
    ),
  );

  //light theme
  static ThemeData lightTheme = baseTheme.copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      // TODO(Anyone): set light theme values
    ),
  );
}
