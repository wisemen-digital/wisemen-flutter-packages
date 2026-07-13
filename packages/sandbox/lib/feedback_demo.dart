import 'package:wise_feedback/wise_feedback.dart';

/// Shared navigation observer for the wise_feedback smoke test.
///
/// Referenced both by `WiseFeedback(navigatorObserver: ...)` in main.dart and
/// by the app's router `navigatorObservers` so the breadcrumb is recorded.
final wiseFeedbackObserver = WiseFeedbackNavigatorObserver();
