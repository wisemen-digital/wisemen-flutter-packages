import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DeviceMetadataCollector', () {
    test('includes platform and app version, and never throws', () async {
      final collector = DeviceMetadataCollector(
        packageInfoLoader: () async => PackageInfo(
          appName: 'Demo',
          packageName: 'com.demo',
          version: '1.2.3',
          buildNumber: '45',
        ),
      );

      final metadata = await collector.collect();

      expect(metadata['platform'], isNotEmpty);
      expect(metadata['appVersion'], '1.2.3');
      expect(metadata['buildNumber'], '45');
    });

    test('returns partial data when a source fails', () async {
      final collector = DeviceMetadataCollector(
        packageInfoLoader: () async => throw Exception('no channel'),
      );

      // Device info channels are also absent in tests; collect() must still
      // return the platform key without throwing.
      final metadata = await collector.collect();

      expect(metadata['platform'], isNotEmpty);
      expect(metadata.containsKey('appVersion'), isFalse);
    });
  });
}
