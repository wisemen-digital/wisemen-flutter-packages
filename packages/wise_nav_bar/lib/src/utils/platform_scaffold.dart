import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../native/platform_appbar.dart';
import 'platform_widget_helper.dart';

/// [PlatformScaffold] platform scaffold with [appBar] and [body]
final class PlatformScaffold extends PlatformWidget {
  /// Constructor [PlatformScaffold]
  const PlatformScaffold({
    required this.body,
    required super.platformService,
    this.appBar,
    this.backgroundColor,
    super.key,
  });

  /// Scaffold body
  final Widget body;

  /// Navigation bar (non sliver)
  final PlatformAppBar? appBar;

  /// Scaffold background color
  final Color? backgroundColor;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: appBar,
      backgroundColor: backgroundColor,
      child: body,
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: body,
    );
  }
}
