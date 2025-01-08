import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

/// [PlatformIconButton] with CupertinoButton and IconButton
class PlatformIconButton extends PlatformWidget<CupertinoButton, Material> {
  /// Constructor [PlatformIconButton]
  const PlatformIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.backgroundColor = Colors.transparent,
    this.splashColor,
    this.splashRadius,
    this.minSize = 5,
  });

  /// Icon widget
  final Widget icon;

  /// Background color (defaults to transparent)
  final Color backgroundColor;

  /// Void callback onPressed
  final VoidCallback? onPressed;

  /// Splash color (defaults to theme values)
  final Color? splashColor;

  /// Splash radius
  final double? splashRadius;

  /// Minimum size (defaults to 5)
  final double minSize;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) =>
      CupertinoButton(
        onPressed: onPressed,
        color: backgroundColor,
        padding: EdgeInsets.zero,
        minSize: minSize,
        child: icon,
      );

  @override
  Material createMaterialWidget(BuildContext context) => Material(
        color: backgroundColor,
        child: IconButton(
          icon: icon,
          splashColor: splashColor,
          splashRadius: splashRadius,
          onPressed: onPressed,
        ),
      );
}
