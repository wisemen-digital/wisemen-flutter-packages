import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Returns true when running on web
bool get isWeb => kIsWeb;

/// Returns true when running on iOS
bool get isIos => !kIsWeb && Platform.isIOS;

/// Returns true when running on Android
bool get isAndroid => !kIsWeb && Platform.isAndroid;

/// Class for copying with null values
class Optional<T> {
  /// Constructor for [Optional]
  const Optional.value(this.value);

  /// Optional value
  final T value;
}

/// Pretty print json
String prettyJson(dynamic json) {
  final spaces = ' ' * 4;
  final encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

/// Custom page scroll physics
// ignore: must_be_immutable
class CustomLockScrollPhysics extends ScrollPhysics {
  /// Creates physics for a [PageView].
  /// [lockLeft] Lock scroll to the left
  /// [lockRight] Lock scroll to the right
  CustomLockScrollPhysics({
    super.parent,
    this.lockLeft = false,
    this.lockRight = false,
  });

  /// Lock swipe on drag-drop gesture
  /// If it is a user gesture, [applyPhysicsToUserOffset] is called before [applyBoundaryConditions];
  /// If it is a programming gesture eg. `controller.animateTo(index)`, [applyPhysicsToUserOffset] is not called.
  bool _lock = false;

  /// Lock scroll to the left
  final bool lockLeft;

  /// Lock scroll to the right
  final bool lockRight;

  @override
  CustomLockScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomLockScrollPhysics(
      parent: buildParent(ancestor),
      lockLeft: lockLeft,
      lockRight: lockRight,
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if ((lockRight && offset < 0) || (lockLeft && offset > 0)) {
      _lock = true;
      return 0;
    }

    return offset;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(
      () {
        if (value == position.pixels) {
          throw FlutterError(
              '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
              'The proposed new position, $value, is exactly equal to the current position of the '
              'given ${position.runtimeType}, ${position.pixels}.\n'
              'The applyBoundaryConditions method should only be called when the value is '
              'going to actually change the pixels, otherwise it is redundant.\n'
              'The physics object in question was:\n'
              '  $this\n'
              'The position object in question was:\n'
              '  $position\n');
        }
        return true;
      }(),
      'Boundary assertion failed',
    );

    /*
     * Handle the hard boundaries (min and max extents)
     * (identical to ClampingScrollPhysics)
     */
    // under-scroll
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    // over-scroll
    else if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      return value - position.pixels;
    }
    // hit top edge
    else if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.pixels;
    }
    // hit bottom edge
    else if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      return value - position.pixels;
    }

    final isGoingLeft = value <= position.pixels;
    final isGoingRight = value >= position.pixels;
    if (_lock && ((lockLeft && isGoingLeft) || (lockRight && isGoingRight))) {
      _lock = false;
      return value - position.pixels;
    }

    return 0;
  }
}

/// Debounces function calls based on duration
class Debouncer {
  /// Constructor for [Debouncer]
  Debouncer({this.duration = Durations.long1});

  /// Duration for debouncing
  final Duration duration;

  Timer? _timer;

  /// Run the action after the duration has passed
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }
}

/// Returns a [Timer] that repeatedly calls the specified callback with a fixed duration.
Timer makePeriodicTimer(
  Duration duration,
  void Function(Timer timer) callback, {
  bool fireNow = false,
}) {
  final timer = Timer.periodic(duration, callback);
  if (fireNow) {
    callback(timer);
  }
  return timer;
}

/// Shows a snackbar with the given message (Android only)
void showSnackBar({required BuildContext context, required String? message}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(
    SnackBar(
      content: Text(message ?? ''),
    ),
  );
}
