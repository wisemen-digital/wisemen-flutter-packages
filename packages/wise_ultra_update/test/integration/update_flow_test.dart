import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

class MockUpdateLocalizations extends Mock implements UpdateLocalizations {}

class MockUpdateAssets extends Mock implements UpdateAssets {}

class MockUpdateNavigationManager extends Mock implements UpdateNavigationManager {}

void main() {
  group('Update Flow Integration', () {
    late ProviderContainer container;
    late MockUpdateLocalizations mockLocalizations;
    late MockUpdateAssets mockAssets;
    late MockUpdateNavigationManager mockNavigationManager;

    setUp(() {
      mockLocalizations = MockUpdateLocalizations();
      mockAssets = MockUpdateAssets();
      mockNavigationManager = MockUpdateNavigationManager();

      when(() => mockLocalizations.newUpdateAvailableTitle).thenReturn('Update Available');
      when(() => mockLocalizations.newUpdateAvailableSubtitle).thenReturn('A new version is available');
      when(() => mockLocalizations.installUpdate).thenReturn('Install');
      when(() => mockLocalizations.illDoThisLater).thenReturn('Later');
      when(() => mockAssets.avatar).thenReturn(null);

      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('hasShownUpdate provider starts as false', () {
      final hasShown = container.read(hasShownUpdateProvider);
      expect(hasShown, false);
    });

    test('hasShownUpdate can be changed to true', () {
      container.read(hasShownUpdateProvider.notifier).changeValue(true);
      final hasShown = container.read(hasShownUpdateProvider);
      expect(hasShown, true);
    });

    test('UpdateFeature provides access to all components', () {
      expect(UpdateFeature.localizations, mockLocalizations);
      expect(UpdateFeature.assets, mockAssets);
      expect(UpdateFeature.navigationManager, isA<Provider>());
      expect(UpdateFeature.repository, isA<Provider>());
    });

    test('UpdateFeature localizations work correctly', () {
      expect(UpdateFeature.localizations.newUpdateAvailableTitle, 'Update Available');
      expect(UpdateFeature.localizations.newUpdateAvailableSubtitle, 'A new version is available');
      expect(UpdateFeature.localizations.installUpdate, 'Install');
      expect(UpdateFeature.localizations.illDoThisLater, 'Later');
    });

    test('UpdateFeature assets work correctly', () {
      expect(UpdateFeature.assets.avatar, null);
    });

    test('UpdateFeature navigationManager can be read from container', () {
      final manager = container.read(UpdateFeature.navigationManager);
      expect(manager, mockNavigationManager);
    });

    test('UpdateFeature repository can be read from container', () {
      final repo = container.read(UpdateFeature.repository);
      expect(repo, isA<UpdateRepository>());
    });

    test('baseUpdateRepositoryProvider provides BaseUpdateRepository', () {
      final repo = container.read(baseUpdateRepositoryProvider);
      expect(repo, isA<BaseUpdateRepository>());
    });

    test('updateServiceProvider provides UpdateService', () {
      final service = container.read(updateServiceProvider);
      expect(service, isA<UpdateService>());
    });

    test('hasShownUpdate provider is keepAlive', () {
      // Change value
      container.read(hasShownUpdateProvider.notifier).changeValue(true);
      
      // Read multiple times
      expect(container.read(hasShownUpdateProvider), true);
      expect(container.read(hasShownUpdateProvider), true);
      expect(container.read(hasShownUpdateProvider), true);
    });

    test('hasShownUpdate can toggle between true and false', () {
      final notifier = container.read(hasShownUpdateProvider.notifier);
      
      expect(container.read(hasShownUpdateProvider), false);
      
      notifier.changeValue(true);
      expect(container.read(hasShownUpdateProvider), true);
      
      notifier.changeValue(false);
      expect(container.read(hasShownUpdateProvider), false);
      
      notifier.changeValue(true);
      expect(container.read(hasShownUpdateProvider), true);
    });
  });
}
