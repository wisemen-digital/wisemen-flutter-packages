import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extensions on [TimeOfDay]
extension TimeOfDayExtension on TimeOfDay {
  /// Adds minutes to [TimeOfDay]
  TimeOfDay plusMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      final mofd = hour * 60 + minute;
      final newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        final newHour = newMofd ~/ 60;
        final newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }

  /// Checks if [TimeOfDay] is later than or equal to other
  bool laterOrEqualThan(TimeOfDay other) {
    if (hour < other.hour) return false;
    if (hour > other.hour) return true;
    if (minute < other.minute) return false;
    if (minute > other.minute) return true;
    return true;
  }

  /// Converts [TimeOfDay] to double
  double get asDouble => hour + minute / 60.0;

  /// Formats [TimeOfDay] to string
  String customFormat({
    required BuildContext context,
    bool is24h = true,
  }) {
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(
      this,
    );
  }

  /// Formats [TimeOfDay] to string
  String get format24Hour {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour, minute);
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  /// Formats [TimeOfDay] to int in minutes
  int toMinutes() {
    return (hour * 60) + minute;
  }
}

/// [String] to [TimeOfDay] extension
extension StringToTimeOfDay on String? {
  /// Converts a string to a [TimeOfDay] object
  TimeOfDay toTimeOfDay() {
    if ((this?.length ?? 0) >= 5) {
      return TimeOfDay(
        hour: int.parse(this?.substring(0, 2) ?? '0'),
        minute: int.parse(this?.substring(3, 5) ?? '0'),
      );
    }
    return const TimeOfDay(hour: 0, minute: 0);
  }
}
