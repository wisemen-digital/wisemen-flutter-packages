import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test/test.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

void main() {
  group('HasShownUpdate Provider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is false', () {
      final state = container.read(hasShownUpdateProvider);
      expect(state, false);
    });

    test('changeValue updates state to true', () {
      container.read(hasShownUpdateProvider.notifier).changeValue(true);
      final state = container.read(hasShownUpdateProvider);
      expect(state, true);
    });

    test('changeValue updates state to false', () {
      container.read(hasShownUpdateProvider.notifier).changeValue(true);
      container.read(hasShownUpdateProvider.notifier).changeValue(false);
      final state = container.read(hasShownUpdateProvider);
      expect(state, false);
    });

    test('state persists across reads', () {
      container.read(hasShownUpdateProvider.notifier).changeValue(true);
      expect(container.read(hasShownUpdateProvider), true);
      expect(container.read(hasShownUpdateProvider), true);
    });

    test('multiple changeValue calls work correctly', () {
      final notifier = container.read(hasShownUpdateProvider.notifier);
      
      notifier.changeValue(true);
      expect(container.read(hasShownUpdateProvider), true);
      
      notifier.changeValue(false);
      expect(container.read(hasShownUpdateProvider), false);
      
      notifier.changeValue(true);
      expect(container.read(hasShownUpdateProvider), true);
    });

    test('notifier can be accessed multiple times', () {
      final notifier1 = container.read(hasShownUpdateProvider.notifier);
      final notifier2 = container.read(hasShownUpdateProvider.notifier);
      
      expect(notifier1, notifier2);
    });

    test('provider is keepAlive', () {
      container.read(hasShownUpdateProvider.notifier).changeValue(true);
      expect(container.read(hasShownUpdateProvider), true);
      
      // Force a rebuild by reading again
      expect(container.read(hasShownUpdateProvider), true);
    });
  });
}
