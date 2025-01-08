import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widgets.dart';

/// [PlatformCloseButton] cross icon on Android, text button on iOS
class PlatformCloseButton extends PlatformWidget<CupertinoButton, Material> {
  /// Constructor [PlatformCloseButton]
  const PlatformCloseButton({
    super.key,
    this.title = 'Close',
    this.textStyle,
    this.onPressed,
    this.color = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.iconHeight = 32,
    this.border,
    this.iconSize = 22,
  });

  /// Button title (defaults to 'Close')
  final String title;

  /// Title text style only on iOS
  final TextStyle? textStyle;

  /// [VoidCallback] onPressed (defaults to Navigator.of(context).pop)
  final VoidCallback? onPressed;

  /// Icon color (defaults to black)
  final Color? color;

  /// Background color (defaults to transparent) only on Android
  final Color? backgroundColor;

  /// Icon height (defaults to 32) only on Android
  final double iconHeight;

  /// Icon size (defaults to 22) only on Android
  final double? iconSize;

  /// Button border only on Android
  final Border? border;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      onPressed: onPressed ?? Navigator.of(context, rootNavigator: true).pop,
      child: AutoSizeText(
        title,
        style: textStyle,
        maxLines: 1,
      ),
    );
  }

  @override
  Material createMaterialWidget(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(iconHeight),
        onTap: onPressed ?? Navigator.of(context, rootNavigator: true).pop,
        child: Ink(
          height: iconHeight,
          width: iconHeight,
          child: Icon(
            Icons.close_rounded,
            color: color,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
