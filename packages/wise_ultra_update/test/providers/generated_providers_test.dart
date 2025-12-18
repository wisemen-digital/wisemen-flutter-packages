import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test/test.dart';
import 'package:wise_ultra_update/src/features/update/providers/update_providers.dart';

void main() {
  group('Generated Providers', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('HasShownUpdate notifier can be accessed', () {
      final notifier = container.read(hasShownUpdateProvider.notifier);
      expect(notifier, isA<HasShownUpdate>());
    });

    test('HasShownUpdate build returns false initially', () {
      final notifier = container.read(hasShownUpdateProvider.notifier);
      expect(notifier.build(), false);
    });

    test('HasShownUpdate state can be read', () {
      final notifier = container.read(hasShownUpdateProvider.notifier);
      expect(notifier.state, false);
    });

    test('HasShownUpdate state can be modified', () {
      final notifier = container.read(hasShownUpdateProvider.notifier)
      ..changeValue(true);
      expect(notifier.state, true);
    });

    test('HasShownUpdate changeValue modifies state', () {
      final notifier = container.read(hasShownUpdateProvider.notifier)
      
      ..changeValue(true);
      expect(notifier.state, true);
      
      notifier.changeValue(false);
      expect(notifier.state, false);
    });

    test('HasShownUpdate provider reflects notifier state', () {
      final notifier = container.read(hasShownUpdateProvider.notifier)
      
      ..changeValue(true);
      expect(container.read(hasShownUpdateProvider), true);
      
      notifier.changeValue(false);
      expect(container.read(hasShownUpdateProvider), false);
    });

    test('Multiple containers have independent state', () {
      final container1 = ProviderContainer();
      final container2 = ProviderContainer();
      
      container1.read(hasShownUpdateProvider.notifier).changeValue(true);
      container2.read(hasShownUpdateProvider.notifier).changeValue(false);
      
      expect(container1.read(hasShownUpdateProvider), true);
      expect(container2.read(hasShownUpdateProvider), false);
      
      container1.dispose();
      container2.dispose();
    });

    test('HasShownUpdate is a HasShownUpdate instance', () {
      final notifier = container.read(hasShownUpdateProvider.notifier);
      expect(notifier, isA<HasShownUpdate>());
    });
  });
}
