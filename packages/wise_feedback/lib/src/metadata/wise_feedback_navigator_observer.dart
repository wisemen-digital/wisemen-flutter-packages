import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

/// A [NavigatorObserver] that records a breadcrumb of recently visited routes.
///
/// Add it to your app's `navigatorObservers` and pass the same instance to
/// `WiseFeedback(navigatorObserver: ...)`. The trail is attached to reports
/// so triagers can see where the user was.
///
/// It extends auto_route's [AutoRouterObserver], so tab switches (bottom bar
/// or tab bar taps inside an `AutoTabsRouter`) are recorded alongside pushes,
/// pops and replacements. On a plain [Navigator] it behaves like any other
/// [NavigatorObserver].
class WiseFeedbackNavigatorObserver extends AutoRouterObserver {
  /// Creates the observer, keeping at most [maxEntries] recent route names.
  WiseFeedbackNavigatorObserver({this.maxEntries = 20})
    : assert(maxEntries > 0, 'maxEntries must be positive');

  /// The maximum number of route names retained (oldest dropped first).
  final int maxEntries;

  final List<String> _breadcrumbs = <String>[];

  /// The recorded route names, oldest first.
  List<String> get breadcrumbs => List<String>.unmodifiable(_breadcrumbs);

  void _record(Route<dynamic>? route) => _add(route?.settings.name);

  void _add(String? name) {
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

  /// Records a tab the user activated for the first time.
  ///
  /// A null [previousRoute] means the tab was built without the user moving to
  /// it — the initially active tab, or a sibling eagerly built by an
  /// `AutoTabsRouter` with `lazyLoad: false` — so it is not a breadcrumb.
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    if (previousRoute == null) {
      return;
    }
    _add(route.name);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _add(route.name);
  }
}
