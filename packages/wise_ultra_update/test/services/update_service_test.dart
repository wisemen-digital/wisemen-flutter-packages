import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test/test.dart';
import 'package:wise_ultra_update/src/network/services/update_service.dart';

void main() {
  group('UpdateService', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('updateServiceProvider can be read', () {
      final service = container.read(updateServiceProvider);
      expect(service, isA<UpdateService>());
    });

    test('UpdateService has getNeedsUpdate method', () {
      final service = container.read(updateServiceProvider);
      expect(service.getNeedsUpdate, isA<Function>());
    });
  });
}
