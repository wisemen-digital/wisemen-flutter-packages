import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that animates between maps of numeric values with smooth transitions.
///
/// When [numbers] changes, the widget animates from the previous values to the
/// new values using the specified [duration] and [curve].
///
/// This widget uses Flutter's [TweenAnimationBuilder] internally with a custom
/// [_MapTween] to handle map interpolation.
///
/// Example:
/// ```dart
/// AnimatedNumbersMapped(
///   numbers: {'likes': 42, 'comments': 7},
///   child: (context, values) => Row(
///     children: [
///       Text('Likes: ${values['likes']?.toStringAsFixed(0)}'),
///       Text('Comments: ${values['comments']?.toStringAsFixed(0)}'),
///     ],
///   ),
/// )
/// ```
class AnimatedNumbersMapped extends StatelessWidget {
  /// Creates an [AnimatedNumbersMapped] widget.
  ///
  /// The [numbers] and [child] parameters are required.
  const AnimatedNumbersMapped({
    required this.numbers,
    required this.child,
    this.curve = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 1000),
    super.key,
  });

  /// The target map of numeric values to animate towards.
  final Map<String, int> numbers;

  /// Builder function that receives the current animated values
  /// and returns the widget to display.
  final Widget Function(BuildContext context, Map<String, double> values) child;

  /// The duration of the animation.
  ///
  /// Defaults to 1000 milliseconds.
  final Duration duration;

  /// The curve to apply to the animation.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Map<String, double>>(
      tween: _MapTween(
        end: numbers.map((key, value) => MapEntry(key, value.toDouble())),
      ),
      duration: duration,
      curve: curve,
      builder: (context, values, _) => child(context, values),
    );
  }
}

/// A custom [Tween] that interpolates between two maps of doubles.
class _MapTween extends Tween<Map<String, double>> {
  _MapTween({required Map<String, double> end}) : super(end: end);

  @override
  Map<String, double> lerp(double t) {
    final beginMap = begin ?? end!;
    final endMap = end!;

    return {
      for (final key in endMap.keys)
        key: lerpDouble(
          beginMap[key] ?? 0,
          endMap[key] ?? 0,
          t,
        )!,
    };
  }
}
