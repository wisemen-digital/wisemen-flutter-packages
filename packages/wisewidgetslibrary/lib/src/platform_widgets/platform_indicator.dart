import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

/// [PlatformLoadingIndicator] with CupertinoActivityIndicator and CircularProgressIndicator
class PlatformLoadingIndicator
    extends PlatformWidget<CupertinoActivityIndicator, SizedBox> {
  /// Constructor [PlatformLoadingIndicator]
  const PlatformLoadingIndicator({
    super.key,
    this.radius = 10.0,
    this.color,
    this.backgroundColor,
  });

  /// Radius of the loading indicator
  final double radius;

  /// Indicator color
  final Color? color;

  /// Background color (Android only)
  final Color? backgroundColor;

  @override
  CupertinoActivityIndicator createCupertinoWidget(BuildContext context) =>
      CupertinoActivityIndicator(
        radius: radius,
        color: color,
      );

  @override
  SizedBox createMaterialWidget(BuildContext context) {
    return SizedBox(
      height: radius * 2,
      width: radius * 2,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(color),
        strokeWidth: radius / 4,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
