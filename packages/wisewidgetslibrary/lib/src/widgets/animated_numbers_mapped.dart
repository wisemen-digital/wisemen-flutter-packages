import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// [AnimatedNumbersMapped] widget
class AnimatedNumbersMapped extends StatefulWidget {
  /// Constructor [AnimatedNumbersMapped]
  const AnimatedNumbersMapped({
    required this.numbers,
    required this.child,
    this.curve = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 1000),
    super.key,
  });

  /// Map of animation number values
  final Map<String, int?> numbers;

  /// Children
  final Widget Function(Map<String, double>) child;

  /// Animation duration (default 1000ms)
  final Duration duration;

  /// Animation curve (default Curves.easeInOut)
  final Curve curve;

  @override
  State<AnimatedNumbersMapped> createState() => _AnimatedNumbersMappedState();
}

class _AnimatedNumbersMappedState extends State<AnimatedNumbersMapped>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Map<String, Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animations = widget.numbers.map(
      (key, value) {
        return MapEntry(
          key,
          Tween<double>(
            begin: value?.toDouble() ?? 0,
            end: value?.toDouble() ?? 0,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
        );
      },
    );
  }

  @override
  void didUpdateWidget(AnimatedNumbersMapped oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!mapEquals(widget.numbers, oldWidget.numbers)) {
      for (final entry in widget.numbers.entries) {
        _animations[entry.key] =
            Tween<double>(
              begin: (oldWidget.numbers[entry.key] ?? 0).toDouble(),
              end: (entry.value ?? 0).toDouble(),
            ).animate(
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
      builder: (context, child) {
        final animatedValues = _animations.map(
          (key, animation) => MapEntry(key, animation.value),
        );
        return widget.child(animatedValues);
      },
    );
  }
}
