import 'package:flutter/material.dart';

/// Extensions on [int] type
extension IntExtension on int {
  /// Converts an integer to a string representation of a time of day.
  String get timeOfDayString {
    if (this >= 1440) {
      return '24:00';
    } else {
      final duration = Duration(minutes: this);
      return '${duration.inHours.remainder(24).toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}';
    }
  }

  /// Converts an integer to a [TimeOfDay] object.
  TimeOfDay get timeOfDay {
    return TimeOfDay(hour: this ~/ 60, minute: this % 60);
  }
}
