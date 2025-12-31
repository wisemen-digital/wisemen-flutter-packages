import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_scalars/base/base.dart';
import 'package:wise_scalars/scalar_types/scalar_types.dart';

void main() {
  group('Temperature', () {
    test('creates temperature with value and unit', () {
      const temp = Temperature(value: 20, unit: TemperatureUnit.celsius);

      expect(temp.value, 20);
      expect(temp.unit, TemperatureUnit.celsius);
    });

    group('equality', () {
      test('same celsius values are equal', () {
        const temp1 = Temperature(value: 20, unit: TemperatureUnit.celsius);
        const temp2 = Temperature(value: 20, unit: TemperatureUnit.celsius);

        expect(temp1, equals(temp2));
      });

      test('equivalent temperatures in different units are equal', () {
        const celsius = Temperature(value: 0, unit: TemperatureUnit.celsius);
        const fahrenheit = Temperature(value: 32, unit: TemperatureUnit.fahrenheit);

        expect(celsius, equals(fahrenheit));
      });

      test('different values are not equal', () {
        const temp1 = Temperature(value: 20, unit: TemperatureUnit.celsius);
        const temp2 = Temperature(value: 25, unit: TemperatureUnit.celsius);

        expect(temp1, isNot(equals(temp2)));
      });
    });

    group('compareTo', () {
      test('compares correctly in same unit', () {
        const lower = Temperature(value: 10, unit: TemperatureUnit.celsius);
        const higher = Temperature(value: 20, unit: TemperatureUnit.celsius);

        expect(lower.compareTo(higher), lessThan(0));
        expect(higher.compareTo(lower), greaterThan(0));
        expect(lower.compareTo(lower), 0);
      });

      test('compares across different units', () {
        const celsius = Temperature(value: 0, unit: TemperatureUnit.celsius);
        const fahrenheit = Temperature(value: 50, unit: TemperatureUnit.fahrenheit);

        expect(celsius.compareTo(fahrenheit), lessThan(0));
      });

      test('throws for incompatible types', () {
        const temp = Temperature(value: 20, unit: TemperatureUnit.celsius);
        const distance = Distance(value: 100, unit: DistanceUnit.meters);

        expect(() => temp.compareTo(distance), throwsArgumentError);
      });
    });

    testWidgets('label with celsius preference', (tester) async {
      const temp = Temperature(value: 20, unit: TemperatureUnit.celsius);
      final options = await _createOptions(temperatureUnit: TemperatureUnit.celsius);

      await tester.pumpWidget(
        _buildTestWidget(options, (context) {
          expect(temp.label(context), '20°C');
          expect(temp.labelValue(context), '20');
        }),
      );
    });

    testWidgets('label with fahrenheit preference', (tester) async {
      const temp = Temperature(value: 20, unit: TemperatureUnit.celsius);
      final options = await _createOptions(temperatureUnit: TemperatureUnit.fahrenheit);

      await tester.pumpWidget(
        _buildTestWidget(options, (context) {
          expect(temp.label(context), '68°F');
          expect(temp.labelValue(context), '68');
        }),
      );
    });

    testWidgets('label without system preference', (tester) async {
      const temp = Temperature(value: 20, unit: TemperatureUnit.celsius);
      final options = await _createOptions();

      await tester.pumpWidget(
        _buildTestWidget(options, (context) {
          expect(temp.label(context), '20°C');
        }),
      );
    });
  });

  group('TemperatureUnit', () {
    test('symbols are correct', () {
      expect(TemperatureUnit.celsius.symbol, '°C');
      expect(TemperatureUnit.fahrenheit.symbol, '°F');
      expect(TemperatureUnit.kelvin.symbol, ' K');
    });

    group('calculateFrom', () {
      test('celsius to fahrenheit', () {
        const temp = Temperature(value: 0, unit: TemperatureUnit.celsius);
        expect(TemperatureUnit.fahrenheit.calculateFrom(temp), 32);
      });

      test('fahrenheit to celsius', () {
        const temp = Temperature(value: 32, unit: TemperatureUnit.fahrenheit);
        expect(TemperatureUnit.celsius.calculateFrom(temp), 0);
      });

      test('celsius to kelvin', () {
        const temp = Temperature(value: 0, unit: TemperatureUnit.celsius);
        expect(TemperatureUnit.kelvin.calculateFrom(temp), 273.15);
      });

      test('same unit returns original value', () {
        const temp = Temperature(value: 20, unit: TemperatureUnit.celsius);
        expect(TemperatureUnit.celsius.calculateFrom(temp), 20);
      });
    });

    group('fromString', () {
      test('parses celsius', () {
        expect(TemperatureUnit.fromString('celsius'), TemperatureUnit.celsius);
        expect(TemperatureUnit.fromString('Celsius'), TemperatureUnit.celsius);
      });

      test('parses fahrenheit', () {
        expect(TemperatureUnit.fromString('fahrenheit'), TemperatureUnit.fahrenheit);
        expect(TemperatureUnit.fromString('fahrenhe'), TemperatureUnit.fahrenheit); // Android bug
      });

      test('parses kelvin', () {
        expect(TemperatureUnit.fromString('kelvin'), TemperatureUnit.kelvin);
      });

      test('returns null for invalid input', () {
        expect(TemperatureUnit.fromString('invalid'), isNull);
        expect(TemperatureUnit.fromString(null), isNull);
      });
    });
  });

  group('Distance', () {
    test('creates distance with value and unit', () {
      const dist = Distance(value: 100, unit: DistanceUnit.meters);

      expect(dist.value, 100);
      expect(dist.unit, DistanceUnit.meters);
    });

    group('equality', () {
      test('same values in same unit are equal', () {
        const dist1 = Distance(value: 100, unit: DistanceUnit.meters);
        const dist2 = Distance(value: 100, unit: DistanceUnit.meters);

        expect(dist1, equals(dist2));
      });

      test('equivalent distances in different units are equal', () {
        const meters = Distance(value: 1000, unit: DistanceUnit.meters);
        const km = Distance(value: 1, unit: DistanceUnit.kilometers);

        expect(meters, equals(km));
      });

      test('different values are not equal', () {
        const dist1 = Distance(value: 100, unit: DistanceUnit.meters);
        const dist2 = Distance(value: 200, unit: DistanceUnit.meters);

        expect(dist1, isNot(equals(dist2)));
      });
    });

    group('compareTo', () {
      test('compares correctly in same unit', () {
        const shorter = Distance(value: 50, unit: DistanceUnit.meters);
        const longer = Distance(value: 100, unit: DistanceUnit.meters);

        expect(shorter.compareTo(longer), lessThan(0));
        expect(longer.compareTo(shorter), greaterThan(0));
        expect(shorter.compareTo(shorter), 0);
      });

      test('compares across different units', () {
        const meters = Distance(value: 500, unit: DistanceUnit.meters);
        const km = Distance(value: 1, unit: DistanceUnit.kilometers);

        expect(meters.compareTo(km), lessThan(0));
      });

      test('throws for incompatible types', () {
        const dist = Distance(value: 100, unit: DistanceUnit.meters);
        const temp = Temperature(value: 20, unit: TemperatureUnit.celsius);

        expect(() => dist.compareTo(temp), throwsArgumentError);
      });
    });

    testWidgets('label with metric preference', (tester) async {
      const dist = Distance(value: 100, unit: DistanceUnit.meters);
      final options = await _createOptions(usesMetricDistance: true);

      await tester.pumpWidget(
        _buildTestWidget(options, (context) {
          expect(dist.label(context), '100 m');
          expect(dist.labelValue(context), '100');
        }),
      );
    });

    testWidgets('label with imperial preference', (tester) async {
      const dist = Distance(value: 100, unit: DistanceUnit.meters);
      final options = await _createOptions(usesMetricDistance: false);

      await tester.pumpWidget(
        _buildTestWidget(options, (context) {
          expect(dist.label(context), contains('yd'));
        }),
      );
    });

    testWidgets('label defaults to metric', (tester) async {
      const dist = Distance(value: 1000, unit: DistanceUnit.meters);
      final options = await _createOptions();

      await tester.pumpWidget(
        _buildTestWidget(options, (context) {
          expect(dist.label(context), '1000 m');
        }),
      );
    });
  });

  group('DistanceUnit', () {
    test('symbols are correct', () {
      expect(DistanceUnit.millimeters.symbol, 'mm');
      expect(DistanceUnit.centimeters.symbol, 'cm');
      expect(DistanceUnit.meters.symbol, 'm');
      expect(DistanceUnit.kilometers.symbol, 'km');
      expect(DistanceUnit.inches.symbol, 'in');
      expect(DistanceUnit.feet.symbol, 'ft');
      expect(DistanceUnit.yards.symbol, 'yd');
      expect(DistanceUnit.miles.symbol, 'mi');
    });

    test('isMetric is correct', () {
      expect(DistanceUnit.millimeters.isMetric, true);
      expect(DistanceUnit.meters.isMetric, true);
      expect(DistanceUnit.kilometers.isMetric, true);
      expect(DistanceUnit.inches.isMetric, false);
      expect(DistanceUnit.feet.isMetric, false);
      expect(DistanceUnit.miles.isMetric, false);
    });

    group('calculateFrom', () {
      test('converts meters to kilometers', () {
        const dist = Distance(value: 1000, unit: DistanceUnit.meters);
        final result = DistanceUnit.kilometers.calculateFrom(dist, useMetric: true);

        expect(result.unit, DistanceUnit.kilometers);
        expect(result.value, 1);
      });

      test('converts meters to feet', () {
        const dist = Distance(value: 100, unit: DistanceUnit.meters);
        final result = DistanceUnit.feet.calculateFrom(dist, useMetric: false);

        expect(result.unit, DistanceUnit.feet);
        expect(result.value, closeTo(328, 1));
      });

      test('respects metric preference', () {
        const dist = Distance(value: 1000, unit: DistanceUnit.meters);
        final metric = DistanceUnit.meters.calculateFrom(dist, useMetric: true);

        expect(metric.unit.isMetric, true);
      });

      test('respects imperial preference', () {
        const dist = Distance(value: 1000, unit: DistanceUnit.meters);
        final imperial = DistanceUnit.feet.calculateFrom(dist, useMetric: false);

        expect(imperial.unit.isMetric, false);
      });
    });
  });
}

Future<ScalarOptions> _createOptions({
  TemperatureUnit? temperatureUnit,
  bool? usesMetricDistance,
}) async {
  const channel = MethodChannel('wise_scalars');

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
    channel,
    (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getFirstDayOfWeek':
          return 1;
        case 'getTemperatureUnit':
          return temperatureUnit?.name;
        case 'getUsesMetricSystemForDistance':
          return usesMetricDistance;
        case 'getDateFormatStyles':
          return {};
        default:
          return null;
      }
    },
  );

  return ScalarOptions.fromMethodChannel();
}

Widget _buildTestWidget(ScalarOptions options, void Function(BuildContext) test) {
  return WiseScalarScope(
    options: options,
    child: Builder(
      builder: (context) {
        test(context);
        return const SizedBox.shrink();
      },
    ),
  );
}
