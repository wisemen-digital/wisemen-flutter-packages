import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_indicator.dart';
import 'platform_widget.dart';

/// [PlatformAnimatedButton] with child and loading states
class PlatformAnimatedButton extends PlatformWidget<Widget, Widget> {
  /// Constructor [PlatformAnimatedButton]
  const PlatformAnimatedButton({
    super.key,
    this.child,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.borderRadiusValue = 8,
    this.color = Colors.white,
    this.border,
    this.loadingIndicatorColor,
    this.expand = true,
    this.padding = const EdgeInsets.all(15),
    this.disabledColor,
    this.duration = Durations.medium2,
  });

  /// Child centered with padding
  final Widget? child;

  /// Void callback onPressed
  final VoidCallback? onPressed;

  /// Is button disabled (show disabled state)
  final bool isDisabled;

  /// Is button loading (show loading indicator)
  final bool isLoading;

  /// BorderRadius value (circular border radius)
  final double borderRadiusValue;

  /// Background color
  final Color color;

  /// Button border
  final BoxBorder? border;

  /// Optional loading indicator color (default from [ThemeData])
  final Color? loadingIndicatorColor;

  /// Expand button width to [double.infinity]
  final bool expand;

  /// Child padding (default 15)
  final EdgeInsetsGeometry padding;

  /// Disabled color (default color with opacity .4)
  final Color? disabledColor;

  /// Animation duration (default 300ms)
  final Duration duration;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    var busy = false;
    return SizedBox(
      width: expand ? double.infinity : null,
      child: AnimatedContainer(
        duration: duration,
        decoration: BoxDecoration(
          color: color,
          border: border,
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(borderRadiusValue - 1),
          onPressed: !isDisabled && !isLoading
              ? () async {
                  if (busy == false) {
                    if (onPressed != null) {
                      onPressed!();
                      busy = true;
                    }
                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () {
                        busy = false;
                      },
                    );
                  }
                }
              : null,
          color: Colors.transparent,
          minimumSize: Size.zero,
          disabledColor: disabledColor ?? color.withValues(alpha: .4),
          pressedOpacity: .8,
          child: isLoading
              ? Padding(
                  padding: padding,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: PlatformLoadingIndicator(
                      color: loadingIndicatorColor,
                    ),
                  ),
                )
              : Padding(
                  padding: padding,
                  child: child,
                ),
        ),
      ),
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    var busy = false;
    return SizedBox(
      width: expand ? double.infinity : null,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            decoration: BoxDecoration(
              border: border,
              color: isDisabled || isLoading
                  ? disabledColor ?? color.withValues(alpha: .4)
                  : color,
              borderRadius: BorderRadius.circular(borderRadiusValue),
            ),
            child: isLoading
                ? Padding(
                    padding: padding,
                    child: Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: loadingIndicatorColor,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: padding,
                    child: Center(
                      child: child,
                    ),
                  ),
          ),
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(borderRadiusValue),
                onTap: !isDisabled && !isLoading
                    ? () async {
                        if (busy == false) {
                          if (onPressed != null) {
                            onPressed!();
                            busy = true;
                          }
                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () {
                              busy = false;
                            },
                          );
                        }
                      }
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
