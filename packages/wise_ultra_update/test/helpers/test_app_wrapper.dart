import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_theming/wise_theming.dart';

/// Wraps a widget with MaterialApp and WiseTheming for testing
class TestAppWrapper extends StatelessWidget {
  const TestAppWrapper({
    required this.child,
    this.overrides = const [],
    super.key,
  });

  final Widget child;
  final List<Object> overrides;

  @override
  Widget build(BuildContext context) {
    final theming = WiseTheming(
      supportedThemes: supportedThemes,
      targetPlatform: TargetPlatform.iOS,
    );

    return ProviderScope(
      overrides: overrides.cast(),
      child: ValueListenableBuilder(
        valueListenable: theming,
        builder: (context, theme, _) {
          return MaterialApp(
            title: 'Test App',
            themeMode: theme?.themeType.themeMode,
            theme: theming.lightTheme,
            darkTheme: theming.darkTheme,
            highContrastTheme: theming.lightContrastTheme,
            highContrastDarkTheme: theming.darkContrastTheme,
            home: Scaffold(body: child),
          );
        },
      ),
    );
  }
}
