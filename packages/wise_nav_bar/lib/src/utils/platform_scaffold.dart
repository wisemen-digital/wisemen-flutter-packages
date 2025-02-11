import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';

import 'platform_nav_bar_helper.dart';

/// [BasePlatformScaffold] platform scaffold with [navBar] and [body]
final class BasePlatformScaffold extends PlatformWidget {
  /// Constructor [BasePlatformScaffold]
  const BasePlatformScaffold({
    required this.body,
    this.navBar,
    this.backgroundColor,
    super.key,
  });

  /// Scaffold body
  final Widget body;

  /// Navigation bar (non sliver)
  final BaseWiseNavBar? navBar;

  /// Scaffold background color
  final Color? backgroundColor;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navBar,
      backgroundColor: backgroundColor,
      child: body,
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: navBar,
      body: body,
    );
  }
}
