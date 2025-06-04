import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_bottom_bar.dart';
import 'platform_widget.dart';

/// [PlatformTabScaffold] with CupertinoTabScaffold and Scaffold
class PlatformTabScaffold
    extends PlatformWidget<CupertinoTabScaffold, Scaffold> {
  /// Constructor [PlatformTabScaffold]
  const PlatformTabScaffold({
    required this.index,
    required this.body,
    required this.bottomBar,
    required this.tabBuilder,
    super.key,
  });

  /// Bottom bar
  final PlatformBottomBar bottomBar;

  /// Tab builder
  final Widget Function(BuildContext, int) tabBuilder;

  /// Tab body
  final Widget body;

  /// Current index
  final int index;

  @override
  CupertinoTabScaffold createCupertinoWidget(BuildContext context) =>
      CupertinoTabScaffold(
        tabBar: bottomBar.createCupertinoWidget(context),
        tabBuilder: tabBuilder,
      );

  @override
  Scaffold createMaterialWidget(BuildContext context) => Scaffold(
    body: body,
    bottomNavigationBar: bottomBar,
  );
}
