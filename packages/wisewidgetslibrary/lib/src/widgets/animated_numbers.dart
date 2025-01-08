import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// [AnimatedNumbers] widget
class AnimatedNumbers extends StatefulWidget {
  /// Constructor [AnimatedNumbers]
  const AnimatedNumbers({
    required this.numbers,
    required this.child,
    this.curve = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 1000),
    super.key,
  });

  /// List of animation number values
  final List<double> numbers;

  /// Children
  final Widget Function(List<double>) child;

  /// Animation duration (default 1000ms)
  final Duration duration;

  /// Animation curve (default Curves.easeInOut)
  final Curve curve;

  @override
  State<AnimatedNumbers> createState() => _AnimatedNumbersState();
}

class _AnimatedNumbersState extends State<AnimatedNumbers>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animations = widget.numbers
        .map(
          (factor) => Tween<double>(
            begin: factor,
            end: factor,
          ).animate(_animationController),
        )
        .toList();
  }

  @override
  void didUpdateWidget(AnimatedNumbers oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.numbers, oldWidget.numbers)) {
      for (var i = 0; i < widget.numbers.length; i++) {
        _animations[i] =
            Tween<double>(begin: oldWidget.numbers[i], end: widget.numbers[i])
                .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
      }
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
      builder: (context, child) =>
          widget.child(_animations.map((e) => e.value).toList()),
    );
  }
}
