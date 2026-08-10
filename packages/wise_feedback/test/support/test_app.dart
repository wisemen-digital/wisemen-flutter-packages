import 'package:flutter/material.dart';

/// Wraps [child] in a minimal `MaterialApp` for widget tests that pump
/// `FeedbackForm` directly, outside `BetterFeedback`.
///
/// The form takes its wording as a `WiseFeedbackStrings` parameter, so no
/// localization delegates are involved.
Widget testApp({required Widget child}) {
  return MaterialApp(home: Scaffold(body: child));
}
