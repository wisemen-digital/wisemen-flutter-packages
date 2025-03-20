import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/date_extensions.dart';

void main() {
  group('DateExtensions', () {
    test('isSameDate should return true for same dates', () {
      final date1 = DateTime(2025, 3, 16);
      final date2 = DateTime(2025, 3, 16);
      expect(date1.isSameDate(date2), isTrue);
    });

    test('isSameDate should return false for different dates', () {
      final date1 = DateTime(2025, 3, 16);
      final date2 = DateTime(2025, 3, 17);
      expect(date1.isSameDate(date2), isFalse);
    });

    test('isSameDate should return false for null date', () {
      final date1 = DateTime(2025, 3, 16);
      expect(date1.isSameDate(null), isFalse);
    });

    test('withoutTime should return date without time', () {
      final date = DateTime(2025, 3, 16, 15, 30);
      final dateWithoutTime = date.withoutTime;
      expect(dateWithoutTime, DateTime(2025, 3, 16));
    });

    test('onlyTime should return TimeOfDay from DateTime', () {
      final date = DateTime(2025, 3, 16, 15, 30);
      final timeOfDay = date.onlyTime;
      expect(timeOfDay, const TimeOfDay(hour: 15, minute: 30));
    });

    test('schoolYear should return correct school year for dates before September', () {
      final date = DateTime(2025, 3, 16);
      expect(date.schoolYear, '2024 - 2025');
    });

    test('schoolYear should return correct school year for dates from September onwards', () {
      final date = DateTime(2025, 9, 15);
      expect(date.schoolYear, '2025 - 2026');
    });
  });
}