import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

/// PlatformRoute with MaterialPageRoute, PageTransition and CupertinoPageRoute
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
      return PageTransition(
        child: route,
        childCurrent: currentRoute,
        type: currentRoute != null
            ? PageTransitionType.rightToLeftJoined
            : PageTransitionType.rightToLeft,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
        duration: const Duration(milliseconds: 250),
        reverseDuration: const Duration(milliseconds: 250),
      );
    case TargetPlatform.iOS:
      return CupertinoPageRoute<T>(
        builder: (_) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
    default:
      return MaterialPageRoute<T>(
        builder: (_) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
  }
}
