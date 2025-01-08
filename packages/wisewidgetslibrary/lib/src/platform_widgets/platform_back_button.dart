import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widgets.dart';

/// [PlatformBackButton] with back icon and title
class PlatformBackButton
    extends PlatformWidget<CupertinoNavigationBarBackButton, Material> {
  /// Constructor [PlatformBackButton]
  const PlatformBackButton({
    super.key,
    this.previousPageTitle = 'Back',
    this.onPressed,
    this.color,
    this.iconSize = 24,
  });

  /// Previous page title (shorter than 12 characters and defaults to 'Back')
  /// only used for iOS
  final String previousPageTitle;

  /// Void callback onPressed (defaults to Navigator.of(context).pop)
  final VoidCallback? onPressed;

  /// Icon color (defaults to theme values)
  final Color? color;

  /// Icon size (defaults to 24) only used for Android
  final double iconSize;

  @override
  CupertinoNavigationBarBackButton createCupertinoWidget(BuildContext context) {
    return CupertinoNavigationBarBackButton(
      previousPageTitle: previousPageTitle,
      color: color,
      onPressed: onPressed ?? Navigator.of(context).pop,
    );
  }

  @override
  Material createMaterialWidget(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: IconButton(
        onPressed: onPressed ?? Navigator.of(context).pop,
        icon: Icon(
          Icons.arrow_back_rounded,
          color: color ?? Theme.of(context).appBarTheme.iconTheme?.color,
          size: iconSize,
        ),
      ),
    );
  }
}
