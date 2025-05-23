import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/wise_login_screen.dart';

class WiseLoginScreenRoute extends PageRouteInfo<WiseScreenRouteArgs> {
  WiseLoginScreenRoute({List<PageRouteInfo>? children, WidgetBuilder? builder})
      : super(
          WiseLoginScreenRoute.name,
          args: WiseScreenRouteArgs(
            builder: builder,
          ),
          initialChildren: children,
        );

  static const String name = 'WiseLoginScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WiseScreenRouteArgs>();
      return WiseLoginScreen(
        builder: args.builder,
      );
    },
  );
}

class WiseScreenRouteArgs {
  const WiseScreenRouteArgs({
    this.builder,
  });

  final WidgetBuilder? builder;
}
