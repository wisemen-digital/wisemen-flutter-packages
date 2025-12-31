import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:wise_scalars/wise_scalars.dart';

void main() {
  group('DateFormatPatterns constructor', () {
    test('creates instance with all required formats', () {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      expect(patterns.short.pattern, 'dd/MM/yy');
      expect(patterns.medium.pattern, 'd MMM yyyy');
      expect(patterns.long.pattern, 'd MMMM yyyy');
      expect(patterns.full.pattern, 'EEEE d MMMM yyyy');
      expect(patterns.time.pattern, 'HH:mm');
    });
  });

  group('DateFormatPatterns.init', () {
    test('creates instance with default intl patterns', () {
      final patterns = DateFormatPatterns.init();

      expect(patterns.short, isA<DateFormat>());
      expect(patterns.medium, isA<DateFormat>());
      expect(patterns.long, isA<DateFormat>());
      expect(patterns.full, isA<DateFormat>());
      expect(patterns.time, isA<DateFormat>());
    });

    test('uses yMd pattern for short format', () {
      final patterns = DateFormatPatterns.init();
      final expected = DateFormat.yMd();

      expect(patterns.short.pattern, expected.pattern);
    });

    test('uses yMMMd pattern for medium format', () {
      final patterns = DateFormatPatterns.init();
      final expected = DateFormat.yMMMd();

      expect(patterns.medium.pattern, expected.pattern);
    });

    test('uses yMMMMd pattern for long format', () {
      final patterns = DateFormatPatterns.init();
      final expected = DateFormat.yMMMMd();

      expect(patterns.long.pattern, expected.pattern);
    });

    test('uses yMMMMEEEEd pattern for full format', () {
      final patterns = DateFormatPatterns.init();
      final expected = DateFormat.yMMMMEEEEd();

      expect(patterns.full.pattern, expected.pattern);
    });

    test('uses jm pattern for time format', () {
      final patterns = DateFormatPatterns.init();
      final expected = DateFormat.jm();

      expect(patterns.time.pattern, expected.pattern);
    });
  });

  group('DateFormatPatterns.fromMap', () {
    test('creates instance from valid map', () {
      final map = {
        'short': 'dd/MM/yy',
        'medium': 'd MMM yyyy',
        'long': 'd MMMM yyyy',
        'full': 'EEEE d MMMM yyyy',
        'time': 'HH:mm',
      };

      final patterns = DateFormatPatterns.fromMap(map);

      expect(patterns.short.pattern, 'dd/MM/yy');
      expect(patterns.medium.pattern, 'd MMM yyyy');
      expect(patterns.long.pattern, 'd MMMM yyyy');
      expect(patterns.full.pattern, 'EEEE d MMMM yyyy');
      expect(patterns.time.pattern, 'HH:mm');
    });

    test('creates instance from US format map', () {
      final map = {
        'short': 'M/d/yy',
        'medium': 'MMM d, yyyy',
        'long': 'MMMM d, yyyy',
        'full': 'EEEE, MMMM d, yyyy',
        'time': 'h:mm a',
      };

      final patterns = DateFormatPatterns.fromMap(map);

      expect(patterns.short.pattern, 'M/d/yy');
      expect(patterns.medium.pattern, 'MMM d, yyyy');
      expect(patterns.long.pattern, 'MMMM d, yyyy');
      expect(patterns.full.pattern, 'EEEE, MMMM d, yyyy');
      expect(patterns.time.pattern, 'h:mm a');
    });

    test('creates instance from Asian format map', () {
      final map = {
        'short': 'yy/MM/dd',
        'medium': 'yyyy/MM/dd',
        'long': 'yyyy年M月d日',
        'full': 'yyyy年M月d日 EEEE',
        'time': 'H:mm',
      };

      final patterns = DateFormatPatterns.fromMap(map);

      expect(patterns.short.pattern, 'yy/MM/dd');
      expect(patterns.medium.pattern, 'yyyy/MM/dd');
      expect(patterns.long.pattern, 'yyyy年M月d日');
      expect(patterns.full.pattern, 'yyyy年M月d日 EEEE');
      expect(patterns.time.pattern, 'H:mm');
    });

    test('returns default patterns when map is null', () {
      final patterns = DateFormatPatterns.fromMap(null);
      final expected = DateFormatPatterns.init();

      expect(patterns.short.pattern, expected.short.pattern);
      expect(patterns.medium.pattern, expected.medium.pattern);
      expect(patterns.long.pattern, expected.long.pattern);
      expect(patterns.full.pattern, expected.full.pattern);
      expect(patterns.time.pattern, expected.time.pattern);
    });

    test('creates instance with 24-hour time format', () {
      final map = {
        'short': 'dd/MM/yy',
        'medium': 'd MMM yyyy',
        'long': 'd MMMM yyyy',
        'full': 'EEEE d MMMM yyyy',
        'time': 'HH:mm:ss',
      };

      final patterns = DateFormatPatterns.fromMap(map);

      expect(patterns.time.pattern, 'HH:mm:ss');
    });

    test('creates instance with 12-hour time format', () {
      final map = {
        'short': 'dd/MM/yy',
        'medium': 'd MMM yyyy',
        'long': 'd MMMM yyyy',
        'full': 'EEEE d MMMM yyyy',
        'time': 'h:mm:ss a',
      };

      final patterns = DateFormatPatterns.fromMap(map);

      expect(patterns.time.pattern, 'h:mm:ss a');
    });
  });

  group('DateFormatPatterns equality', () {
    test('identical patterns are equal', () {
      final patterns1 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final patterns2 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      expect(patterns1, equals(patterns2));
    });

    test('patterns with different short format are not equal', () {
      final patterns1 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final patterns2 = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      expect(patterns1, isNot(equals(patterns2)));
    });

    test('patterns with different medium format are not equal', () {
      final patterns1 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final patterns2 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      expect(patterns1, isNot(equals(patterns2)));
    });

    test('patterns with different long format are not equal', () {
      final patterns1 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final patterns2 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      expect(patterns1, isNot(equals(patterns2)));
    });

    test('patterns with different full format are not equal', () {
      final patterns1 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final patterns2 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('HH:mm'),
      );

      expect(patterns1, isNot(equals(patterns2)));
    });

    test('patterns with different time format are not equal', () {
      final patterns1 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final patterns2 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('h:mm a'),
      );

      expect(patterns1, isNot(equals(patterns2)));
    });

    test('identity equality works', () {
      final patterns = DateFormatPatterns.init();

      expect(identical(patterns, patterns), true);
      expect(patterns, equals(patterns));
    });

    test('default init patterns are equal when created separately', () {
      final patterns1 = DateFormatPatterns.init();
      final patterns2 = DateFormatPatterns.init();

      expect(patterns1, equals(patterns2));
    });
  });

  group('DateFormatPatterns hashCode', () {
    test('hashCode is consistent across multiple calls', () {
      final patterns = DateFormatPatterns.init();

      final hash1 = patterns.hashCode;
      final hash2 = patterns.hashCode;
      final hash3 = patterns.hashCode;

      expect(hash1, equals(hash2));
      expect(hash2, equals(hash3));
    });
  });

  group('DateFormatPatternsExtension.short', () {
    testWidgets('formats date using short pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.short(context);
              expect(formatted, '15/03/24');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats date using US short pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('h:mm a'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.short(context);
              expect(formatted, '3/15/24');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats different dates correctly', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              expect(DateTime(2024).short(context), '01/01/24');
              expect(DateTime(2024, 12, 31).short(context), '31/12/24');
              expect(DateTime(2023, 6, 15).short(context), '15/06/23');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('DateFormatPatternsExtension.medium', () {
    testWidgets('formats date using medium pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.medium(context);
              expect(formatted, '15 Mar 2024');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats date using US medium pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('h:mm a'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.medium(context);
              expect(formatted, 'Mar 15, 2024');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('DateFormatPatternsExtension.long', () {
    testWidgets('formats date using long pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.long(context);
              expect(formatted, '15 March 2024');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats date using US long pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('h:mm a'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.long(context);
              expect(formatted, 'March 15, 2024');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('DateFormatPatternsExtension.full', () {
    testWidgets('formats date using full pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.full(context);
              expect(formatted, 'Friday 15 March 2024');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats date using US full pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('h:mm a'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.full(context);
              expect(formatted, 'Friday, March 15, 2024');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('DateFormatPatternsExtension.time', () {
    testWidgets('formats time using 24-hour pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15, 14, 30);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.time(context);
              expect(formatted, '14:30');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats time using 12-hour pattern', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('h:mm a'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15, 14, 30);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              final formatted = date.time(context);
              expect(formatted, '2:30 PM');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats different times correctly', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              expect(DateTime(2024).time(context), '00:00');
              expect(DateTime(2024, 1, 1, 12).time(context), '12:00');
              expect(DateTime(2024, 1, 1, 23, 59).time(context), '23:59');
              expect(DateTime(2024, 1, 1, 9, 5).time(context), '09:05');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats AM times correctly with 12-hour pattern', (
      tester,
    ) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('h:mm a'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              expect(DateTime(2024, 1, 1, 0, 30).time(context), '12:30 AM');
              expect(DateTime(2024, 1, 1, 9, 15).time(context), '9:15 AM');
              expect(DateTime(2024, 1, 1, 11, 59).time(context), '11:59 AM');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats PM times correctly with 12-hour pattern', (
      tester,
    ) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('h:mm a'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              expect(DateTime(2024, 1, 1, 12).time(context), '12:00 PM');
              expect(DateTime(2024, 1, 1, 15, 45).time(context), '3:45 PM');
              expect(DateTime(2024, 1, 1, 23, 59).time(context), '11:59 PM');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('DateFormatPatternsExtension integration', () {
    testWidgets('all format methods work on same date', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 3, 15, 14, 30);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              expect(date.short(context), '15/03/24');
              expect(date.medium(context), '15 Mar 2024');
              expect(date.long(context), '15 March 2024');
              expect(date.full(context), 'Friday 15 March 2024');
              expect(date.time(context), '14:30');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('formats work with different pattern updates', (tester) async {
      final patterns1 = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options1 = await _createScalarOptions(
        dateFormatPatterns: patterns1,
      );
      final date = DateTime(2024, 3, 15, 14, 30);

      String? formattedShort;

      await tester.pumpWidget(
        WiseScalarScope(
          options: options1,
          child: Builder(
            builder: (context) {
              formattedShort = date.short(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(formattedShort, '15/03/24');

      // Update with US patterns
      final patterns2 = DateFormatPatterns(
        short: DateFormat('M/d/yy'),
        medium: DateFormat('MMM d, yyyy'),
        long: DateFormat('MMMM d, yyyy'),
        full: DateFormat('EEEE, MMMM d, yyyy'),
        time: DateFormat('h:mm a'),
      );

      final options2 = await _createScalarOptions(
        dateFormatPatterns: patterns2,
      );

      await tester.pumpWidget(
        WiseScalarScope(
          options: options2,
          child: Builder(
            builder: (context) {
              formattedShort = date.short(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(formattedShort, '3/15/24');
    });
  });

  group('DateFormatPatterns edge cases', () {
    testWidgets('handles leap year dates', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);
      final date = DateTime(2024, 2, 29); // Leap year date

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              expect(date.short(context), '29/02/24');
              expect(date.medium(context), '29 Feb 2024');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('handles year boundaries', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              expect(DateTime(2023, 12, 31).short(context), '31/12/23');
              expect(DateTime(2024).short(context), '01/01/24');
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('handles midnight and end of day times', (tester) async {
      final patterns = DateFormatPatterns(
        short: DateFormat('dd/MM/yy'),
        medium: DateFormat('d MMM yyyy'),
        long: DateFormat('d MMMM yyyy'),
        full: DateFormat('EEEE d MMMM yyyy'),
        time: DateFormat('HH:mm:ss'),
      );

      final options = await _createScalarOptions(dateFormatPatterns: patterns);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              expect(DateTime(2024).time(context), '00:00:00');
              expect(
                DateTime(2024, 1, 1, 23, 59, 59).time(context),
                '23:59:59',
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}

Future<ScalarOptions> _createScalarOptions({
  required DateFormatPatterns dateFormatPatterns,
}) async {
  const channel = MethodChannel('wise_scalars');

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'getFirstDayOfWeek':
              return 1;
            case 'getTemperatureUnit':
              return TemperatureUnit.celsius.name;
            case 'getUsesMetricSystemForDistance':
              return true;
            case 'getDateFormatStyles':
              return {
                'short': dateFormatPatterns.short.pattern,
                'medium': dateFormatPatterns.medium.pattern,
                'long': dateFormatPatterns.long.pattern,
                'full': dateFormatPatterns.full.pattern,
                'time': dateFormatPatterns.time.pattern,
              };
            default:
              return null;
          }
        },
      );

  return ScalarOptions.fromMethodChannel();
}
