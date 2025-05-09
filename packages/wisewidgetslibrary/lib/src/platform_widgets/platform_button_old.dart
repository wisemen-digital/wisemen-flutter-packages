import 'package:flutter/material.dart';

import 'platform_widgets.dart';

const _deprecatedText =
    'This version of PlatformButton is deprecated. Use PlatformButton2 instead (will be renamed to PlatformButton soon).';

/// [PlatformButton] with text or child
@Deprecated(_deprecatedText)
class PlatformButton extends StatelessWidget {
  /// Constructor [PlatformButton]
  @Deprecated(_deprecatedText)
  PlatformButton({
    super.key,
    this.text,
    this.child,
    this.textStyle = const TextStyle(color: Colors.black),
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.borderRadius,
    this.color = Colors.white,
    this.border,
    this.maxLines,
    this.loadingIndicatorColor,
    this.expand = true,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.disabledColor,
    this.boxShadow,
    this.height,
    this.width,
    this.textAlign = TextAlign.center,
    this.duration = Durations.medium2,
    this.gradient,
  }) {
    if (text != null && child != null) {
      throw ArgumentError(
        'Either the param text or content can be passed at a time.',
      );
    }
  }

  /// Child centered with padding
  final Widget? child;

  /// Button with only text (alternative to child)
  final String? text;

  /// Text style (only used when text != null)
  final TextStyle? textStyle;

  /// Text align (only used when text != null)
  final TextAlign? textAlign;

  /// Max lines (only used when text != null)
  final int? maxLines;

  /// Void callback onPressed
  final VoidCallback? onPressed;

  /// Is button disabled (show disabled state)
  final bool isDisabled;

  /// Is button loading (show loading indicator)
  final bool isLoading;

  /// BorderRadius (defaults to 8)
  final BorderRadius? borderRadius;

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

  /// Optional height
  final double? height;

  /// Optional width
  final double? width;

  /// Child margin
  final EdgeInsetsGeometry margin;

  /// Optional boxShadow
  final List<BoxShadow>? boxShadow;

  /// Optional gradient
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: !isDisabled && !isLoading ? onPressed : null,
          borderRadius: borderRadius,
          child: Ink(
            height: height,
            padding: padding,
            width: expand ? double.infinity : width,
            decoration: BoxDecoration(
              border: border,
              gradient: gradient,
              color: !isDisabled && !isLoading && onPressed != null
                  ? color
                  : (disabledColor ?? color.withValues(alpha: .4)),
              borderRadius: borderRadius,
              boxShadow: boxShadow,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  duration: duration,
                  opacity: isLoading ? 0 : 1,
                  child: child ??
                      Text(
                        text ?? '',
                        style: textStyle,
                        maxLines: maxLines,
                        textAlign: textAlign,
                      ),
                ),
                AnimatedOpacity(
                  opacity: isLoading ? 1 : 0,
                  duration: duration,
                  child: PlatformLoadingIndicator(
                    color: loadingIndicatorColor ?? textStyle?.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
