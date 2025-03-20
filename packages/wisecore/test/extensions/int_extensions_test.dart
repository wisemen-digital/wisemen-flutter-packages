import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/int_extensions.dart';

void main() {
  group('IntExtension', () {
    test('timeOfDayString should convert minutes to time string', () {
      expect(0.timeOfDayString, '00:00');
      expect(60.timeOfDayString, '01:00');
      expect(75.timeOfDayString, '01:15');
      expect(1440.timeOfDayString, '24:00');
    });

    test('timeOfDay should convert minutes to TimeOfDay', () {
      expect(0.timeOfDay, const TimeOfDay(hour: 0, minute: 0));
      expect(60.timeOfDay, const TimeOfDay(hour: 1, minute: 0));
      expect(75.timeOfDay, const TimeOfDay(hour: 1, minute: 15));
      expect(1440.timeOfDay, const TimeOfDay(hour: 24, minute: 0));
    });
  });
}
