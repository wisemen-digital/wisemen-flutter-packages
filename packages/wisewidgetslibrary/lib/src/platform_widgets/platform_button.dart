import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widgets.dart';

// ignore: deprecated_member_use_from_same_package
/// [PlatformButton2] which returns a [CupertinoButton] or [MaterialButton]. To use the old platform button widget, use [PlatformButton].
class PlatformButton2 extends PlatformWidget {
  /// Constructor for [PlatformButton2]
  const PlatformButton2({
    required this.child,
    required this.onPressed,
    required this.color,
    required this.foregroundColor,
    super.key,
    this.loadingChild,
    this.isDisabled = false,
    this.isLoading = false,
    this.disabledColor,
    this.size = const Size.fromHeight(48),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(10),
    ),
    this.padding = const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    this.borderSide,
  });

  /// Constructor for [PlatformButton2] with text
  PlatformButton2.text({
    required String text,
    required TextStyle textStyle,
    required this.onPressed,
    required this.color,
    required this.foregroundColor,
    super.key,
    this.loadingChild,
    this.isDisabled = false,
    this.isLoading = false,
    this.disabledColor,
    this.size = const Size.fromHeight(48),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(10),
    ),
    this.padding = const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    this.borderSide,
  }) : child = Text(
          text,
          style: textStyle,
        );

  /// Button size
  final Size size;

  /// Button child
  final Widget child;

  /// Optional loading child
  final Widget? loadingChild;

  /// Button press callback
  final VoidCallback? onPressed;

  /// Button disabled state
  final bool isDisabled;

  /// Button loading state
  final bool isLoading;

  /// Button Color
  final Color color;

  /// Button foreground color
  final Color foregroundColor;

  /// Button padding
  final Color? disabledColor;

  /// Button border radius
  final BorderRadius borderRadius;

  /// Button border, [MaterialButton] only
  final BorderSide? borderSide;

  /// Button padding
  final EdgeInsetsGeometry padding;

  /// Checks if button can be pressed
  bool get canBePressed => !isDisabled && !isLoading;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: CupertinoButton(
        padding: padding,
        onPressed: canBePressed ? onPressed : null,
        disabledColor: disabledColor ?? color.withValues(alpha: .4),
        color: color,
        borderRadius: borderRadius,
        child: Center(
          child: AnimatedSwitcher(
            duration: Durations.short1,
            child: isLoading
                ? loadingChild ??
                    CupertinoActivityIndicator(
                      color: foregroundColor,
                    )
                : child,
          ),
        ),
      ),
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: MaterialButton(
        height: size.height,
        onPressed: canBePressed ? onPressed : null,
        disabledColor: disabledColor,
        color: color,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: borderSide ?? BorderSide.none,
        ),
        elevation: 0,
        child: Center(
          child: AnimatedSwitcher(
            duration: Durations.short1,
            child: isLoading
                ? loadingChild ??
                    CircularProgressIndicator(
                      color: foregroundColor,
                    )
                : child,
          ),
        ),
      ),
    );
  }
}
