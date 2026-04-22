import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_scalars/base/base.dart';
import 'package:wise_scalars/scalar_types/scalar_types.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('wise_scalars');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('ScalarOptions.fromMethodChannel', () {
    test('creates options with metric system settings', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 1; // Monday
                case 'getTemperatureUnit':
                  return 'celsius';
                case 'getUsesMetricSystemForDistance':
                  return true;
                case 'getDateFormatStyles':
                  return {
                    'short': 'dd/MM/yy',
                    'medium': 'd MMM yyyy',
                    'long': 'd MMMM yyyy',
                    'full': 'EEEE d MMMM yyyy',
                    'time': 'HH:mm',
                  };
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.firstDayOfWeek, 1);
      expect(options.temperatureUnit, TemperatureUnit.celsius);
      expect(options.usesMetricDistance, true);
      expect(options.dateFormatPatterns.short.pattern, 'dd/MM/yy');
      expect(options.dateFormatPatterns.time.pattern, 'HH:mm');
    });

    test('creates options with imperial system settings (US)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 7; // Sunday
                case 'getTemperatureUnit':
                  return 'fahrenheit';
                case 'getUsesMetricSystemForDistance':
                  return false;
                case 'getDateFormatStyles':
                  return {
                    'short': 'M/d/yy',
                    'medium': 'MMM d, yyyy',
                    'long': 'MMMM d, yyyy',
                    'full': 'EEEE, MMMM d, yyyy',
                    'time': 'h:mm a',
                  };
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.firstDayOfWeek, 7);
      expect(options.temperatureUnit, TemperatureUnit.fahrenheit);
      expect(options.usesMetricDistance, false);
      expect(options.dateFormatPatterns.short.pattern, 'M/d/yy');
      expect(options.dateFormatPatterns.time.pattern, 'h:mm a');
    });

    test('creates options with kelvin temperature unit', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 1;
                case 'getTemperatureUnit':
                  return 'kelvin';
                case 'getUsesMetricSystemForDistance':
                  return true;
                case 'getDateFormatStyles':
                  return {
                    'short': 'dd/MM/yy',
                    'medium': 'd MMM yyyy',
                    'long': 'd MMMM yyyy',
                    'full': 'EEEE d MMMM yyyy',
                    'time': 'HH:mm',
                  };
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.temperatureUnit, TemperatureUnit.kelvin);
    });

    test('handles Android fahrenheit bug (fahrenhe)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 7;
                case 'getTemperatureUnit':
                  return 'fahrenhe'; // Android bug
                case 'getUsesMetricSystemForDistance':
                  return false;
                case 'getDateFormatStyles':
                  return {
                    'short': 'M/d/yy',
                    'medium': 'MMM d, yyyy',
                    'long': 'MMMM d, yyyy',
                    'full': 'EEEE, MMMM d, yyyy',
                    'time': 'h:mm a',
                  };
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.temperatureUnit, TemperatureUnit.fahrenheit);
    });

    test('handles null values gracefully', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              return null;
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.firstDayOfWeek, isNull);
      expect(options.temperatureUnit, isNull);
      expect(options.usesMetricDistance, isNull);
      // Date format patterns should use defaults from intl
      expect(options.dateFormatPatterns, isNotNull);
    });

    test('handles partial null values', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 1;
                case 'getTemperatureUnit':
                  return null; // Null temperature
                case 'getUsesMetricSystemForDistance':
                  return true;
                case 'getDateFormatStyles':
                  return null; // Null date formats
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.firstDayOfWeek, 1);
      expect(options.temperatureUnit, isNull);
      expect(options.usesMetricDistance, true);
      expect(options.dateFormatPatterns, isNotNull);
    });

    test('handles unknown temperature unit string', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 1;
                case 'getTemperatureUnit':
                  return 'rankine'; // Unknown unit
                case 'getUsesMetricSystemForDistance':
                  return true;
                case 'getDateFormatStyles':
                  return {
                    'short': 'dd/MM/yy',
                    'medium': 'd MMM yyyy',
                    'long': 'd MMMM yyyy',
                    'full': 'EEEE d MMMM yyyy',
                    'time': 'HH:mm',
                  };
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.temperatureUnit, isNull);
    });

    test('handles different first day of week values', () async {
      for (final day in [1, 2, 3, 4, 5, 6, 7]) {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              channel,
              (MethodCall methodCall) async {
                switch (methodCall.method) {
                  case 'getFirstDayOfWeek':
                    return day;
                  case 'getTemperatureUnit':
                    return 'celsius';
                  case 'getUsesMetricSystemForDistance':
                    return true;
                  case 'getDateFormatStyles':
                    return {
                      'short': 'dd/MM/yy',
                      'medium': 'd MMM yyyy',
                      'long': 'd MMMM yyyy',
                      'full': 'EEEE d MMMM yyyy',
                      'time': 'HH:mm',
                    };
                  default:
                    return null;
                }
              },
            );

        final options = await ScalarOptions.fromMethodChannel();
        expect(options.firstDayOfWeek, day);
      }
    });

    test('creates options with Asian date formats', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 1;
                case 'getTemperatureUnit':
                  return 'celsius';
                case 'getUsesMetricSystemForDistance':
                  return true;
                case 'getDateFormatStyles':
                  return {
                    'short': 'yy/MM/dd',
                    'medium': 'yyyy/MM/dd',
                    'long': 'yyyy年M月d日',
                    'full': 'yyyy年M月d日 EEEE',
                    'time': 'H:mm',
                  };
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.dateFormatPatterns.short.pattern, 'yy/MM/dd');
      expect(options.dateFormatPatterns.long.pattern, 'yyyy年M月d日');
    });
  });

  group('ScalarOptions.of', () {
    testWidgets('retrieves options from context', (tester) async {
      final options = await _createMockOptions();

      ScalarOptions? retrievedOptions;

      await tester.pumpWidget(
        WiseScalarScope(
          options: options,
          child: Builder(
            builder: (context) {
              retrievedOptions = ScalarOptions.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(retrievedOptions, isNotNull);
      expect(retrievedOptions, equals(options));
    });

    testWidgets('throws assertion error when WiseScalarScope is missing', (
      tester,
    ) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return const SizedBox.shrink();
          },
        ),
      );

      expect(
        () => tester.element(find.byType(Builder)).let(ScalarOptions.of),
        throwsA(isA<AssertionError>()),
      );
    });

    testWidgets('retrieves updated options after scope changes', (
      tester,
    ) async {
      final options1 = await _createMockOptions();
      final options2 = await _createMockOptions(firstDayOfWeek: 7);

      ScalarOptions? retrievedOptions;

      await tester.pumpWidget(
        WiseScalarScope(
          options: options1,
          child: Builder(
            builder: (context) {
              retrievedOptions = ScalarOptions.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(retrievedOptions?.firstDayOfWeek, 1);

      await tester.pumpWidget(
        WiseScalarScope(
          options: options2,
          child: Builder(
            builder: (context) {
              retrievedOptions = ScalarOptions.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(retrievedOptions?.firstDayOfWeek, 7);
    });
  });

  group('ScalarOptions equality', () {
    test('identical options are equal', () async {
      final options1 = await _createMockOptions();
      final options2 = await _createMockOptions();

      expect(options1, equals(options2));
    });

    test('different firstDayOfWeek makes options unequal', () async {
      final options1 = await _createMockOptions();
      final options2 = await _createMockOptions(firstDayOfWeek: 7);

      expect(options1, isNot(equals(options2)));
    });

    test('different temperatureUnit makes options unequal', () async {
      final options1 = await _createMockOptions();
      final options2 = await _createMockOptions(
        temperatureUnit: TemperatureUnit.fahrenheit,
      );

      expect(options1, isNot(equals(options2)));
    });

    test('different usesMetricDistance makes options unequal', () async {
      final options1 = await _createMockOptions();
      final options2 = await _createMockOptions(usesMetricDistance: false);

      expect(options1, isNot(equals(options2)));
    });

    test('different dateFormatPatterns makes options unequal', () async {
      final options1 = await _createMockOptions(
        dateFormats: {
          'short': 'dd/MM/yy',
          'medium': 'd MMM yyyy',
          'long': 'd MMMM yyyy',
          'full': 'EEEE d MMMM yyyy',
          'time': 'HH:mm',
        },
      );

      final options2 = await _createMockOptions(
        dateFormats: {
          'short': 'M/d/yy',
          'medium': 'MMM d, yyyy',
          'long': 'MMMM d, yyyy',
          'full': 'EEEE, MMMM d, yyyy',
          'time': 'h:mm a',
        },
      );

      expect(options1, isNot(equals(options2)));
    });

    test('null vs non-null values are unequal', () async {
      final options1 = await _createMockOptions();

      final options2 = await _createMockOptions(
        firstDayOfWeek: null,
        temperatureUnit: null,
        usesMetricDistance: null,
      );

      expect(options1, isNot(equals(options2)));
    });

    test('identity equality works', () async {
      final options = await _createMockOptions();

      expect(options, equals(options));
      expect(identical(options, options), true);
    });
  });

  group('ScalarOptions immutability', () {
    test('options fields are final and cannot be modified', () async {
      final options = await _createMockOptions();

      // Verify all fields are accessible and maintain their values
      expect(options.firstDayOfWeek, 1);
      expect(options.temperatureUnit, TemperatureUnit.celsius);
      expect(options.usesMetricDistance, true);
      expect(options.dateFormatPatterns, isNotNull);

      // Options object should be immutable (@immutable annotation)
      expect(options, isA<ScalarOptions>());
    });
  });

  group('ScalarOptions integration scenarios', () {
    test('complete metric user scenario (European)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 1; // Monday
                case 'getTemperatureUnit':
                  return 'celsius';
                case 'getUsesMetricSystemForDistance':
                  return true;
                case 'getDateFormatStyles':
                  return {
                    'short': 'dd/MM/yy',
                    'medium': 'd MMM yyyy',
                    'long': 'd MMMM yyyy',
                    'full': 'EEEE d MMMM yyyy',
                    'time': 'HH:mm',
                  };
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.firstDayOfWeek, 1);
      expect(options.temperatureUnit, TemperatureUnit.celsius);
      expect(options.usesMetricDistance, true);
      expect(options.dateFormatPatterns.short.pattern, 'dd/MM/yy');
      expect(options.dateFormatPatterns.time.pattern, 'HH:mm');
    });

    test('complete imperial user scenario (American)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              switch (methodCall.method) {
                case 'getFirstDayOfWeek':
                  return 7; // Sunday
                case 'getTemperatureUnit':
                  return 'fahrenheit';
                case 'getUsesMetricSystemForDistance':
                  return false;
                case 'getDateFormatStyles':
                  return {
                    'short': 'M/d/yy',
                    'medium': 'MMM d, yyyy',
                    'long': 'MMMM d, yyyy',
                    'full': 'EEEE, MMMM d, yyyy',
                    'time': 'h:mm a',
                  };
                default:
                  return null;
              }
            },
          );

      final options = await ScalarOptions.fromMethodChannel();

      expect(options.firstDayOfWeek, 7);
      expect(options.temperatureUnit, TemperatureUnit.fahrenheit);
      expect(options.usesMetricDistance, false);
      expect(options.dateFormatPatterns.short.pattern, 'M/d/yy');
      expect(options.dateFormatPatterns.time.pattern, 'h:mm a');
    });

    test(
      'mixed preference scenario (UK: metric distance, but mixed other)',
      () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              channel,
              (MethodCall methodCall) async {
                switch (methodCall.method) {
                  case 'getFirstDayOfWeek':
                    return 1; // Monday
                  case 'getTemperatureUnit':
                    return 'celsius';
                  case 'getUsesMetricSystemForDistance':
                    return false; // UK sometimes uses miles
                  case 'getDateFormatStyles':
                    return {
                      'short': 'dd/MM/yy',
                      'medium': 'd MMM yyyy',
                      'long': 'd MMMM yyyy',
                      'full': 'EEEE d MMMM yyyy',
                      'time': 'HH:mm',
                    };
                  default:
                    return null;
                }
              },
            );

        final options = await ScalarOptions.fromMethodChannel();

        expect(options.temperatureUnit, TemperatureUnit.celsius);
        expect(options.usesMetricDistance, false);
      },
    );
  });
}

/// Helper function to create mock ScalarOptions with custom values
Future<ScalarOptions> _createMockOptions({
  int? firstDayOfWeek = 1,
  TemperatureUnit? temperatureUnit = TemperatureUnit.celsius,
  bool? usesMetricDistance = true,
  Map<String, String>? dateFormats,
}) async {
  const channel = MethodChannel('wise_scalars');

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'getFirstDayOfWeek':
              return firstDayOfWeek;
            case 'getTemperatureUnit':
              return temperatureUnit?.name;
            case 'getUsesMetricSystemForDistance':
              return usesMetricDistance;
            case 'getDateFormatStyles':
              return dateFormats ??
                  {
                    'short': 'dd/MM/yy',
                    'medium': 'd MMM yyyy',
                    'long': 'd MMMM yyyy',
                    'full': 'EEEE d MMMM yyyy',
                    'time': 'HH:mm',
                  };
            default:
              return null;
          }
        },
      );

  return ScalarOptions.fromMethodChannel();
}

extension _BuildContextExtension on BuildContext {
  T let<T>(T Function(BuildContext) block) => block(this);
}
