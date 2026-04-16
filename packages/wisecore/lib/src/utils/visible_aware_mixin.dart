import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

/// An interface used to mark classes as VisibleAware entities
/// usually implemented by widget States
mixin class VisibleAware {
  /// Called when the top route has been popped off, and the current route
  /// shows up. Or Called when the current route has been pushed.
  void onViewDidAppear(AppearanceType type) {}
}

/// An enum to specify the state change type for [VisibleAware]s
enum AppearanceType {
  /// On route push
  push,

  /// On route pop
  pop,

  /// On tab change
  tabChange,

  /// On app resume from background
  backgroundResume
}

class _AppLifecycleObserver with WidgetsBindingObserver {
  _AppLifecycleObserver(this.onStateChanged);
  final void Function(AppLifecycleState state) onStateChanged;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    onStateChanged(state);
  }
}

/// a helper mixin to utilizes [VisibleAware] in a better manner
/// and reduce boilerplate code
/// It automatically subscribes to the [VisibleAwareObserver] and listens to app lifecycle changes.
/// Don't forget to add the [VisibleAwareObserver] to your [NavigatorObserver] list in your app.
mixin VisibleAwareStateMixin<T extends StatefulWidget> on State<T> implements VisibleAware {
  VisibleAwareObserver? _observer;
  late final _AppLifecycleObserver _lifecycleObserver;

  @override
  void initState() {
    super.initState();
    _lifecycleObserver = _AppLifecycleObserver(_handleAppLifecycleState);
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // RouterScope exposes the list of provided observers
    // including inherited observers
    _observer = RouterScope.of(context).firstObserverOfType<VisibleAwareObserver>();

    if (_observer != null) {
      // we subscribe to the observer by passing our
      // VisibleAware state and the scoped routeData
      _observer!.subscribe(this, context.routeData);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);
    _observer?.unsubscribe(this);
    super.dispose();
  }

  @override
  void onViewDidAppear(AppearanceType type) {}

  void _handleAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && (_observer?.isTopRoute(context.routeData) ?? false)) {
      onViewDidAppear(AppearanceType.backgroundResume);
    }
  }
}

/// A [Navigator] observer that notifies [VisibleAware]s of changes to the
/// state of their [Route].
///
/// [VisibleAwareObserver] informs subscribers whenever a route of type `T` is pushed
/// on top of their own route of type `T` or popped from it. This is for example
/// useful to keep track of page transitions, e.g. a `RouteObserver<PageRoute>`
/// will inform subscribed [VisibleAware]s whenever the user navigates away from
/// the current page route to another page route.
class VisibleAwareObserver extends AutoRouterObserver {
  final Map<LocalKey, Set<VisibleAware>> _listeners = <LocalKey, Set<VisibleAware>>{};

  /// Subscribe [VisibleAware] to be informed about changes to [route].
  ///
  /// Going forward, [VisibleAware] will be informed about qualifying changes
  /// to [route], e.g. when [route] is covered by another route or when [route]
  /// is popped off the [Navigator] stack.
  void subscribe<T>(VisibleAware routeAware, RouteData<T> route) {
    final subscribers = _listeners.putIfAbsent(route.key, () => <VisibleAware>{});
    if (subscribers.add(routeAware)) {
      routeAware.onViewDidAppear(AppearanceType.push);
    }
  }

  /// Unsubscribe [VisibleAware].
  ///
  /// [VisibleAware] is no longer informed about changes to its route. If the given argument was
  /// subscribed to multiple types, this will unregister it (once) from each type.
  void unsubscribe(VisibleAware routeAware) {
    for (final route in _listeners.keys) {
      final subscribers = _listeners[route];
      subscribers?.remove(routeAware);
    }
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    final subscribers = _listeners[route.routeInfo.key]?.toList();
    if (subscribers != null) {
      for (final routeAware in subscribers) {
        routeAware.onViewDidAppear(AppearanceType.push);
      }
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    final subscribers = _listeners[route.routeInfo.key]?.toList();
    if (subscribers != null) {
      for (final routeAware in subscribers) {
        routeAware.onViewDidAppear(AppearanceType.tabChange);
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings is AutoRoutePage && previousRoute?.settings is AutoRoutePage) {
      final previousKey = (previousRoute!.settings as AutoRoutePage).routeData.router.topMatch.key;
      final previousSubscribers = _listeners[previousKey]?.toList();

      if (previousSubscribers != null) {
        for (final routeAware in previousSubscribers) {
          routeAware.onViewDidAppear(AppearanceType.pop);
        }
        return;
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings is AutoRoutePage && previousRoute?.settings is AutoRoutePage) {
      final previousKey = (previousRoute!.settings as AutoRoutePage).routeData.router.topMatch.key;
      final previousSubscribers = _listeners[previousKey];

      if (previousSubscribers != null) {
        for (final routeAware in previousSubscribers) {
          routeAware.onViewDidAppear(AppearanceType.push);
        }
      }
    }
  }

  /// Checks if the given [routeData] is currently the top route.
  bool isTopRoute<T>(RouteData<T> routeData) {
    final subscribers = _listeners[routeData.key];
    if (subscribers == null || subscribers.isEmpty) {
      return false;
    }
    final currentKey = routeData.router.routeData.router.topMatch.key;

    return currentKey == routeData.key;
  }
}
