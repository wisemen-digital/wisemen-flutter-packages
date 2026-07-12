import 'package:flutter/widgets.dart';

/// A [NavigatorObserver] that records a breadcrumb of recently visited routes.
///
/// Add it to your app's `navigatorObservers` and pass the same instance to
/// `LinearFeedback(navigatorObserver: ...)`. The trail is attached to reports
/// so triagers can see where the user was.
class WiseFeedbackNavigatorObserver extends NavigatorObserver {
  /// Creates the observer, keeping at most [maxEntries] recent route names.
  WiseFeedbackNavigatorObserver({this.maxEntries = 20})
      : assert(maxEntries > 0, 'maxEntries must be positive');

  /// The maximum number of route names retained (oldest dropped first).
  final int maxEntries;

  final List<String> _breadcrumbs = <String>[];

  /// The recorded route names, oldest first.
  List<String> get breadcrumbs => List<String>.unmodifiable(_breadcrumbs);

  void _record(Route<dynamic>? route) {
    final name = route?.settings.name;
    if (name == null || name.isEmpty) {
      return;
    }
    _breadcrumbs.add(name);
    if (_breadcrumbs.length > maxEntries) {
      _breadcrumbs.removeAt(0);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _record(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _record(newRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _record(previousRoute);
  }
}
