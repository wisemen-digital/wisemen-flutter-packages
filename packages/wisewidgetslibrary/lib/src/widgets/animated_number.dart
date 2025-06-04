import 'package:flutter/material.dart';

/// [AnimatedNumber] widget
class AnimatedNumber extends StatefulWidget {
  /// Constructor [AnimatedNumber]
  const AnimatedNumber({
    required this.number,
    required this.child,
    this.curve = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 1000),
    super.key,
  });

  /// Animation value
  final double number;

  /// Child widget
  final Widget Function(double) child;

  /// Animation duration
  final Duration duration;

  /// Animation curve
  final Curve curve;

  @override
  State<AnimatedNumber> createState() => _AnimatedNumberState();
}

class _AnimatedNumberState extends State<AnimatedNumber>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: widget.number,
      end: widget.number,
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(AnimatedNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.number != oldWidget.number) {
      _animation = Tween<double>(begin: oldWidget.number, end: widget.number)
          .animate(
            CurvedAnimation(parent: _animationController, curve: widget.curve),
          );
      _animationController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => widget.child(_animation.value),
    );
  }
}
