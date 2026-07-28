import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// PlatformRoute with MaterialPageRoute, PageRouteBuilder and CupertinoPageRoute
Route<T> platformRoute<T>({
  required Widget route,
  Widget? currentRoute,
  RouteSettings? settings,
  bool fullscreenDialog = false,
  bool isWeb = kIsWeb,
}) {
  if (isWeb) {
    return MaterialPageRoute<T>(
      builder: (_) => route,
      fullscreenDialog: fullscreenDialog,
      settings: settings,
    );
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      late final PageRouteBuilder<T> pageRoute;

      pageRoute = PageRouteBuilder<T>(
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return const FadeForwardsPageTransitionsBuilder().buildTransitions<T>(
            pageRoute,
            context,
            animation,
            secondaryAnimation,
            child,
          );
        },
      );

      return pageRoute;

    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
    case TargetPlatform.linux:
      return CupertinoPageRoute<T>(
        builder: (_) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );

    case TargetPlatform.windows:
    case TargetPlatform.fuchsia:
      return MaterialPageRoute<T>(
        builder: (_) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
  }
}
