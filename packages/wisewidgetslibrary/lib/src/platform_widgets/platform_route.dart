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
    case TargetPlatform.android:
      return MaterialPageRoute<T>(
        builder: (_) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
  }
}
