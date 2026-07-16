import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wise_feedback/generated/l10n.dart';

/// Wraps [child] in a MaterialApp configured with the wise_feedback
/// localizations delegate and the given [locale], for widget tests that pump
/// `FeedbackForm` directly (outside `BetterFeedback`).
Widget localizedApp({
  required Widget child,
  Locale locale = const Locale('en'),
}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: const [Locale('en'), Locale('nl'), Locale('fr')],
    localizationsDelegates: const [
      WiseFeedbackLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(body: child),
  );
}
