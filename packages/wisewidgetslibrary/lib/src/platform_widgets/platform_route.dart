import 'dart:io';
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
}) {
  if (kIsWeb) {
    return MaterialPageRoute<T>(
      builder: (_) => route,
      fullscreenDialog: fullscreenDialog,
      settings: settings,
    );
  } else {
    if (Platform.isAndroid) {
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
    } else if (Platform.isIOS) {
      return CupertinoPageRoute<T>(
        builder: (_) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
    } else {
      return MaterialPageRoute<T>(
        builder: (_) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
    }
  }
}
