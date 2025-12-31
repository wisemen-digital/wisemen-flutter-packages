import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_scalars/platform/wise_scalars_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelWiseScalars();
  const channel = MethodChannel('wise_scalars');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  group('getTemperatureUnit', () {
    test('returns celsius for metric users', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getTemperatureUnit') {
            return 'celsius';
          }
          return null;
        },
      );

      final result = await platform.getTemperatureUnit();
      expect(result, 'celsius');
    });

    test('returns fahrenheit for imperial users', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getTemperatureUnit') {
            return 'fahrenheit';
          }
          return null;
        },
      );

      final result = await platform.getTemperatureUnit();
      expect(result, 'fahrenheit');
    });

    test('handles null response gracefully', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return null;
        },
      );

      final result = await platform.getTemperatureUnit();
      expect(result, isNull);
    });
  });

  group('getUsesMetricSystemForDistance', () {
    test('returns true for metric system users (Europe, Asia, etc.)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getUsesMetricSystemForDistance') {
            return true;
          }
          return null;
        },
      );

      final result = await platform.getUsesMetricSystemForDistance();
      expect(result, true);
    });

    test('returns false for imperial system users (US, UK, etc.)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getUsesMetricSystemForDistance') {
            return false;
          }
          return null;
        },
      );

      final result = await platform.getUsesMetricSystemForDistance();
      expect(result, false);
    });

    test('handles null response gracefully', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return null;
        },
      );

      final result = await platform.getUsesMetricSystemForDistance();
      expect(result, isNull);
    });
  });

  group('getDateFormatStyles', () {
    test('returns US date format styles', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getDateFormatStyles') {
            return {
              'short': 'M/d/yy',
              'medium': 'MMM d, yyyy',
              'long': 'MMMM d, yyyy',
              'full': 'EEEE, MMMM d, yyyy',
              'time': 'h:mm a',
            };
          }
          return null;
        },
      );

      final result = await platform.getDateFormatStyles();
      expect(result, isNotNull);
      expect(result!['short'], 'M/d/yy');
      expect(result['medium'], 'MMM d, yyyy');
      expect(result['long'], 'MMMM d, yyyy');
      expect(result['full'], 'EEEE, MMMM d, yyyy');
      expect(result['time'], 'h:mm a');
    });

    test('returns European date format styles', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getDateFormatStyles') {
            return {
              'short': 'dd/MM/yy',
              'medium': 'd MMM yyyy',
              'long': 'd MMMM yyyy',
              'full': 'EEEE d MMMM yyyy',
              'time': 'HH:mm',
            };
          }
          return null;
        },
      );

      final result = await platform.getDateFormatStyles();
      expect(result, isNotNull);
      expect(result!['short'], 'dd/MM/yy');
      expect(result['medium'], 'd MMM yyyy');
      expect(result['time'], 'HH:mm');
    });

    test('returns Asian date format styles', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getDateFormatStyles') {
            return {
              'short': 'yy/MM/dd',
              'medium': 'yyyy/MM/dd',
              'long': 'yyyy年M月d日',
              'full': 'yyyy年M月d日 EEEE',
              'time': 'H:mm',
            };
          }
          return null;
        },
      );

      final result = await platform.getDateFormatStyles();
      expect(result, isNotNull);
      expect(result!['short'], 'yy/MM/dd');
      expect(result['medium'], 'yyyy/MM/dd');
      expect(result['long'], 'yyyy年M月d日');
    });

    test('handles empty map response', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getDateFormatStyles') {
            return <String, String>{};
          }
          return null;
        },
      );

      final result = await platform.getDateFormatStyles();
      expect(result, isNotNull);
      expect(result, isEmpty);
    });

    test('handles null response gracefully', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return null;
        },
      );

      final result = await platform.getDateFormatStyles();
      expect(result, isNull);
    });
  });

  group('getFirstDayOfWeek', () {
    test('returns 1 for Monday (most of Europe, Asia)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getFirstDayOfWeek') {
            return 1;
          }
          return null;
        },
      );

      final result = await platform.getFirstDayOfWeek();
      expect(result, 1);
    });

    test('returns 7 for Sunday (US, Canada, etc.)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getFirstDayOfWeek') {
            return 7;
          }
          return null;
        },
      );

      final result = await platform.getFirstDayOfWeek();
      expect(result, 7);
    });

    test('returns 6 for Saturday (some Middle Eastern countries)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getFirstDayOfWeek') {
            return 6;
          }
          return null;
        },
      );

      final result = await platform.getFirstDayOfWeek();
      expect(result, 6);
    });

    test('handles null response gracefully', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return null;
        },
      );

      final result = await platform.getFirstDayOfWeek();
      expect(result, isNull);
    });
  });

  group('method channel integration', () {
    test('verifies correct method channel name', () {
      expect(platform.methodChannel.name, 'wise_scalars');
    });

    test('handles multiple sequential calls correctly', () async {
      var callCount = 0;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          callCount++;
          switch (methodCall.method) {
            case 'getTemperatureUnit':
              return 'celsius';
            case 'getUsesMetricSystemForDistance':
              return true;
            case 'getFirstDayOfWeek':
              return 1;
            default:
              return null;
          }
        },
      );

      await platform.getTemperatureUnit();
      await platform.getUsesMetricSystemForDistance();
      await platform.getFirstDayOfWeek();

      expect(callCount, 3);
    });

    test('simulates complete metric user profile', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          switch (methodCall.method) {
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
            case 'getFirstDayOfWeek':
              return 1;
            default:
              return null;
          }
        },
      );

      final tempUnit = await platform.getTemperatureUnit();
      final usesMetric = await platform.getUsesMetricSystemForDistance();
      final dateFormats = await platform.getDateFormatStyles();
      final firstDay = await platform.getFirstDayOfWeek();

      expect(tempUnit, 'celsius');
      expect(usesMetric, true);
      expect(dateFormats!['time'], 'HH:mm');
      expect(firstDay, 1);
    });

    test('simulates complete imperial user profile (US)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          switch (methodCall.method) {
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
            case 'getFirstDayOfWeek':
              return 7;
            default:
              return null;
          }
        },
      );

      final tempUnit = await platform.getTemperatureUnit();
      final usesMetric = await platform.getUsesMetricSystemForDistance();
      final dateFormats = await platform.getDateFormatStyles();
      final firstDay = await platform.getFirstDayOfWeek();

      expect(tempUnit, 'fahrenheit');
      expect(usesMetric, false);
      expect(dateFormats!['short'], 'M/d/yy');
      expect(dateFormats['time'], 'h:mm a');
      expect(firstDay, 7);
    });
  });
}
