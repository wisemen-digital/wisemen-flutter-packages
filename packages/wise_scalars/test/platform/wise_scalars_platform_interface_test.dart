import 'package:flutter_test/flutter_test.dart';
import 'package:wise_scalars/platform/wise_scalars_method_channel.dart';
import 'package:wise_scalars/platform/wise_scalars_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WiseScalarsPlatform', () {
    test('default instance is MethodChannelWiseScalars', () {
      expect(WiseScalarsPlatform.instance, isA<MethodChannelWiseScalars>());
    });

    test('can set custom platform instance', () {
      final customPlatform = MockWiseScalarsPlatform();
      WiseScalarsPlatform.instance = customPlatform;

      expect(WiseScalarsPlatform.instance, customPlatform);

      // Reset to default
      WiseScalarsPlatform.instance = MethodChannelWiseScalars();
    });
  });

  group('WiseScalarsPlatform default implementations', () {
    late MockWiseScalarsPlatform platform;

    setUp(() {
      platform = MockWiseScalarsPlatform();
    });

    test('getTemperatureUnit throws UnimplementedError by default', () {
      expect(
        () => platform.getTemperatureUnit(),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('getUsesMetricSystemForDistance throws UnimplementedError by default', () {
      expect(
        () => platform.getUsesMetricSystemForDistance(),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('getDateFormatStyles throws UnimplementedError by default', () {
      expect(
        () => platform.getDateFormatStyles(),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('getFirstDayOfWeek throws UnimplementedError by default', () {
      expect(
        () => platform.getFirstDayOfWeek(),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });

  group('Custom platform implementation scenarios', () {
    test('can implement custom platform with metric settings', () async {
      final customPlatform = MetricPlatformMock();
      WiseScalarsPlatform.instance = customPlatform;

      final tempUnit = await WiseScalarsPlatform.instance.getTemperatureUnit();
      final usesMetric = await WiseScalarsPlatform.instance.getUsesMetricSystemForDistance();
      final firstDay = await WiseScalarsPlatform.instance.getFirstDayOfWeek();

      expect(tempUnit, 'celsius');
      expect(usesMetric, true);
      expect(firstDay, 1);

      // Reset to default
      WiseScalarsPlatform.instance = MethodChannelWiseScalars();
    });

    test('can implement custom platform with imperial settings', () async {
      final customPlatform = ImperialPlatformMock();
      WiseScalarsPlatform.instance = customPlatform;

      final tempUnit = await WiseScalarsPlatform.instance.getTemperatureUnit();
      final usesMetric = await WiseScalarsPlatform.instance.getUsesMetricSystemForDistance();
      final firstDay = await WiseScalarsPlatform.instance.getFirstDayOfWeek();

      expect(tempUnit, 'fahrenheit');
      expect(usesMetric, false);
      expect(firstDay, 7);

      // Reset to default
      WiseScalarsPlatform.instance = MethodChannelWiseScalars();
    });

    test('can implement custom platform with specific date formats', () async {
      final customPlatform = CustomDateFormatPlatformMock();
      WiseScalarsPlatform.instance = customPlatform;

      final dateFormats = await WiseScalarsPlatform.instance.getDateFormatStyles();

      expect(dateFormats, isNotNull);
      expect(dateFormats!['short'], 'dd-MM-yyyy');
      expect(dateFormats['time'], 'HH:mm:ss');

      // Reset to default
      WiseScalarsPlatform.instance = MethodChannelWiseScalars();
    });

    test('can handle platform returning null values', () async {
      final customPlatform = NullReturningPlatformMock();
      WiseScalarsPlatform.instance = customPlatform;

      final tempUnit = await WiseScalarsPlatform.instance.getTemperatureUnit();
      final usesMetric = await WiseScalarsPlatform.instance.getUsesMetricSystemForDistance();
      final dateFormats = await WiseScalarsPlatform.instance.getDateFormatStyles();
      final firstDay = await WiseScalarsPlatform.instance.getFirstDayOfWeek();

      expect(tempUnit, isNull);
      expect(usesMetric, isNull);
      expect(dateFormats, isNull);
      expect(firstDay, isNull);

      // Reset to default
      WiseScalarsPlatform.instance = MethodChannelWiseScalars();
    });
  });
}

/// Mock platform implementation that doesn't override methods
/// to test default UnimplementedError behavior
class MockWiseScalarsPlatform extends WiseScalarsPlatform {}

/// Mock platform with metric system settings (Europe, Asia, most of world)
class MetricPlatformMock extends WiseScalarsPlatform {
  @override
  Future<String?> getTemperatureUnit() async => 'celsius';

  @override
  Future<bool?> getUsesMetricSystemForDistance() async => true;

  @override
  Future<Map<String, String>?> getDateFormatStyles() async => {
    'short': 'dd/MM/yy',
    'medium': 'd MMM yyyy',
    'long': 'd MMMM yyyy',
    'full': 'EEEE d MMMM yyyy',
    'time': 'HH:mm',
  };

  @override
  Future<int?> getFirstDayOfWeek() async => 1; // Monday
}

/// Mock platform with imperial system settings (US)
class ImperialPlatformMock extends WiseScalarsPlatform {
  @override
  Future<String?> getTemperatureUnit() async => 'fahrenheit';

  @override
  Future<bool?> getUsesMetricSystemForDistance() async => false;

  @override
  Future<Map<String, String>?> getDateFormatStyles() async => {
    'short': 'M/d/yy',
    'medium': 'MMM d, yyyy',
    'long': 'MMMM d, yyyy',
    'full': 'EEEE, MMMM d, yyyy',
    'time': 'h:mm a',
  };

  @override
  Future<int?> getFirstDayOfWeek() async => 7; // Sunday
}

/// Mock platform with custom date format patterns
class CustomDateFormatPlatformMock extends WiseScalarsPlatform {
  @override
  Future<String?> getTemperatureUnit() async => 'celsius';

  @override
  Future<bool?> getUsesMetricSystemForDistance() async => true;

  @override
  Future<Map<String, String>?> getDateFormatStyles() async => {
    'short': 'dd-MM-yyyy',
    'medium': 'dd MMM yyyy',
    'long': 'dd MMMM yyyy',
    'full': 'EEEE, dd MMMM yyyy',
    'time': 'HH:mm:ss',
  };

  @override
  Future<int?> getFirstDayOfWeek() async => 1;
}

/// Mock platform that returns null for all methods
class NullReturningPlatformMock extends WiseScalarsPlatform {
  @override
  Future<String?> getTemperatureUnit() async => null;

  @override
  Future<bool?> getUsesMetricSystemForDistance() async => null;

  @override
  Future<Map<String, String>?> getDateFormatStyles() async => null;

  @override
  Future<int?> getFirstDayOfWeek() async => null;
}
