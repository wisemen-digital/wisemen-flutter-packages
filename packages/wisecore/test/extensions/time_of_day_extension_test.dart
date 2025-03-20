import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/time_of_day_extension.dart';

void main() {
  group('TimeOfDayExtension', () {
    test('plusMinutes should add minutes correctly', () {
      final time = TimeOfDay(hour: 10, minute: 30);
      final result = time.plusMinutes(45);
      expect(result.hour, 11);
      expect(result.minute, 15);
    });

    test('laterOrEqualThan should compare times correctly', () {
      final time1 = TimeOfDay(hour: 10, minute: 30);
      final time2 = TimeOfDay(hour: 11, minute: 0);
      expect(time1.laterOrEqualThan(time2), false);
      expect(time2.laterOrEqualThan(time1), true);
      expect(time1.laterOrEqualThan(time1), true);
    });

    test('asDouble should convert time to double correctly', () {
      final time = TimeOfDay(hour: 10, minute: 30);
      expect(time.asDouble, 10.5);
    });

    testWidgets('customFormat should format time correctly', (WidgetTester tester) async {
      final time = TimeOfDay(hour: 10, minute: 30);
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final formattedTime = time.customFormat(context: context);
              expect(formattedTime, '10:30 AM');
              return Container();
            },
          ),
        ),
      );
    });

    test('format24Hour should format time to 24-hour string correctly', () {
      final time = TimeOfDay(hour: 10, minute: 30);
      expect(time.format24Hour, '10:30');
    });

    test('toMinutes should convert time to minutes correctly', () {
      final time = TimeOfDay(hour: 10, minute: 30);
      expect(time.toMinutes(), 630);
    });
  });

  group('StringToTimeOfDay', () {
    test('toTimeOfDay should convert string to TimeOfDay correctly', () {
      const timeString = '10:30';
      final time = timeString.toTimeOfDay();
      expect(time.hour, 10);
      expect(time.minute, 30);
    });

    test('toTimeOfDay should handle null or invalid string correctly', () {
      const String? nullString = null;
      expect(nullString.toTimeOfDay(), const TimeOfDay(hour: 0, minute: 0));

      const invalidString = 'invalid';
      expect(() => invalidString.toTimeOfDay(), throwsFormatException);
    });
  });
}