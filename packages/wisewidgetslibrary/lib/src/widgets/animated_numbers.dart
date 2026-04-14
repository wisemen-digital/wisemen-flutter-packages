import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that animates between lists of numeric values with smooth transitions.
///
/// When [numbers] changes, the widget animates from the previous values to the
/// new values using the specified [duration] and [curve].
///
/// This widget uses Flutter's [TweenAnimationBuilder] internally with a custom
/// [_ListTween] to handle list interpolation.
///
/// Example:
/// ```dart
/// AnimatedNumbers(
///   numbers: [value1, value2, value3],
///   child: (context, values) => Row(
///     children: values.map((v) => Text(v.toStringAsFixed(0))).toList(),
///   ),
/// )
/// ```
class AnimatedNumbers extends StatelessWidget {
  /// Creates an [AnimatedNumbers] widget.
  ///
  /// The [numbers] and [child] parameters are required.
  const AnimatedNumbers({
    required this.numbers,
    required this.child,
    this.curve = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 1000),
    super.key,
  });

  /// The target list of numeric values to animate towards.
  final List<double> numbers;

  /// Builder function that receives the current animated values
  /// and returns the widget to display.
  final Widget Function(BuildContext context, List<double> values) child;

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
    return TweenAnimationBuilder<List<double>>(
      tween: _ListTween(end: numbers),
      duration: duration,
      curve: curve,
      builder: (context, values, _) => child(context, values),
    );
  }
}

/// A custom [Tween] that interpolates between two lists of doubles.
class _ListTween extends Tween<List<double>> {
  _ListTween({required List<double> end}) : super(end: end);

  @override
  List<double> lerp(double t) {
    final beginList = begin ?? end!;
    final endList = end!;

    // Handle different list lengths by using the longer list's length
    final maxLength = endList.length;
    return [
      for (var i = 0; i < maxLength; i++)
        lerpDouble(
          i < beginList.length ? beginList[i] : 0,
          endList[i],
          t,
        )!,
    ];
  }
}
