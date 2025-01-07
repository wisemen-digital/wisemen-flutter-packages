import 'package:flutter/material.dart';

/// Extensions on [DateTime] type
extension DateExtensions on DateTime {
  /// Checks if date is equal disregarding time
  bool isSameDate(DateTime? other) {
    if (other != null) {
      return year == other.year && month == other.month && day == other.day;
    } else {
      return false;
    }
  }

  /// Returns date without time
  DateTime get withoutTime {
    return DateTime(year, month, day);
  }

  /// Returns [TimeOfDay] from [DateTime]
  TimeOfDay get onlyTime {
    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Returns (Belgian) school year from date
  String get schoolYear {
    var schoolYears = '';
    if (month < 9) {
      schoolYears = '${year - 1} - $year';
    } else {
      schoolYears = '$year - ${year + 1}';
    }
    return schoolYears;
  }
}
