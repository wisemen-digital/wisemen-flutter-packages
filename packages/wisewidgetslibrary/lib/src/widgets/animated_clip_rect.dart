import 'package:flutter/material.dart';

///AnimatedClipRect is a widget that animates the clip of its child widget.
class AnimatedClipRect extends StatefulWidget {
  ///Constructor [AnimatedClipRect]
  const AnimatedClipRect({
    required this.child,
    required this.open,
    super.key,
    this.horizontalAnimation = false,
    this.verticalAnimation = true,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration,
    this.curve = Curves.easeInOut,
    this.reverseCurve,
    this.animationBehavior = AnimationBehavior.normal,
    this.clipBehavior = Clip.hardEdge,
  });
  @override
  // ignore: library_private_types_in_public_api
  _AnimatedClipRectState createState() => _AnimatedClipRectState();

  /// Child widget
  final Widget child;

  /// Open state (true to open, false to close)
  final bool open;

  /// Horizontal animation (default false)
  final bool horizontalAnimation;

  /// Vertical animation (default true)
  final bool verticalAnimation;

  /// Alignment (default Alignment.center)
  final Alignment alignment;

  /// AnimationDuration (default 300ms)
  final Duration duration;

  /// Reverse animation duration (default duration)
  final Duration? reverseDuration;

  /// Animation curve (default Curves.easeInOut)
  final Curve curve;

  /// Reverse animation curve (default curve)
  final Curve? reverseCurve;

  /// Clip behavior (default Clip.hardEdge)
  final Clip clipBehavior;

  ///The behavior of the controller when AccessibilityFeatures.disableAnimations is true.
  final AnimationBehavior animationBehavior;
}

class _AnimatedClipRectState extends State<AnimatedClipRect>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration ?? widget.duration,
      vsync: this,
      value: widget.open ? 1 : 0,
      animationBehavior: widget.animationBehavior,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve ?? widget.curve,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.open
        ? _animationController.forward()
        : _animationController.reverse();

    return ClipRect(
      clipBehavior: widget.clipBehavior,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, child) {
          return Align(
            alignment: widget.alignment,
            heightFactor: widget.verticalAnimation ? _animation.value : 1,
            widthFactor: widget.horizontalAnimation ? _animation.value : 1,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
