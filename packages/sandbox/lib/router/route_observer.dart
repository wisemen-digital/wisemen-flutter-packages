import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sandbox/features/shared/shared.dart';

class AppRouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    talker.debug('New route pushed: ${route.settings.name}');
    if (previousRoute == null) {
      //if first route, remove splash screen
      FlutterNativeSplash.remove();
    }
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    talker.debug('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    talker.debug('Tab route re-visited: ${route.name}');
  }
}
