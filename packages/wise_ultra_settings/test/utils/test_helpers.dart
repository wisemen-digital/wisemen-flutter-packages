import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';

/// Wraps a widget with proper theming for tests.
///
/// This helper ensures widgets that depend on WiseTheming have the
/// necessary theme context during testing.
Widget wrapWithTheming(Widget child) {
  final theming = WiseTheming(
    supportedThemes: supportedThemes,
    targetPlatform: TargetPlatform.iOS,
  );

  return MaterialApp(
    theme: theming.lightTheme,
    darkTheme: theming.darkTheme,
    home: child,
  );
}
