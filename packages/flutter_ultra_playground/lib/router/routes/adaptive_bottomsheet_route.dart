import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/shared/utils/platform_utils.dart';

class AdaptiveBottomSheetRoute<R> extends CustomRoute {
  AdaptiveBottomSheetRoute({
    required super.page,
    super.fullscreenDialog,
    super.maintainState,
    super.fullMatch = false,
    super.guards,
    super.usesPathAsKey = false,
    super.children,
    super.meta = const {},
    super.title,
    super.path,
    super.keepHistory,
    super.initial,
    super.allowSnapshotting = true,
    bool Function()? swipeToDismiss,
    super.restorationId,
  }) : super(
         customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
           if (PlatformUtils.isIos) {
             return CupertinoSheetRoute<T>(
               builder: (_) => MediaQuery.removePadding(removeTop: true, context: context, child: child),
               settings: page,
             );
           } else {
             return ModalBottomSheetRoute<T>(
               useSafeArea: true,
               builder: (_) => child,
               settings: page,
               isScrollControlled: true,
               isDismissible: swipeToDismiss?.call() ?? true,
               enableDrag: swipeToDismiss?.call() ?? true,
             );
           }
         },
         barrierDismissible: swipeToDismiss?.call() ?? true,
       );
}
