import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/wise_login_screen.dart';

/// Login screen route for app_router.dart usage
class WiseLoginScreenRoute extends PageRouteInfo<WiseScreenRouteArgs> {
  /// Constructor for [WiseLoginScreenRoute]
  WiseLoginScreenRoute({List<PageRouteInfo>? children, WidgetBuilder? builder})
      : super(
          WiseLoginScreenRoute.name,
          args: WiseScreenRouteArgs(
            builder: builder,
          ),
          initialChildren: children,
        );

  /// Route name
  static const String name = 'WiseLoginScreenRoute';

  /// Route page
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

/// Arguments for [WiseLoginScreenRoute]
/// Receives a [WidgetBuilder], usually a brand's logo
class WiseScreenRouteArgs {
  /// Constructor for [WiseScreenRouteArgs]
  const WiseScreenRouteArgs({
    this.builder,
  });

  /// The builder function used in a Scaffold
  /// Usually a brand's logo
  final WidgetBuilder? builder;
}
