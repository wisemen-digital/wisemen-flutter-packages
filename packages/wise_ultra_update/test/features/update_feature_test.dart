import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

import '../utils/mock_classes.dart';

void main() {
  group('UpdateFeature', () {
    late MockUpdateLocalizations mockLocalizations;
    late MockUpdateAssets mockAssets;
    late MockUpdateNavigationManager mockNavigationManager;
    late MockUpdateRepository mockRepository;

    setUp(() {
      mockLocalizations = MockUpdateLocalizations();
      mockAssets = MockUpdateAssets();
      mockNavigationManager = MockUpdateNavigationManager();
      mockRepository = MockUpdateRepository();

      // Setup default mocks
      when(() => mockLocalizations.newUpdateAvailableTitle).thenReturn('Title');
      when(() => mockLocalizations.newUpdateAvailableSubtitle).thenReturn('Subtitle');
      when(() => mockLocalizations.installUpdate).thenReturn('Install');
      when(() => mockLocalizations.illDoThisLater).thenReturn('Later');
      when(() => mockAssets.avatar).thenReturn(null);
    });

    test('init sets localizations', () {
      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      expect(UpdateFeature.localizations, mockLocalizations);
    });

    test('init sets assets', () {
      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      expect(UpdateFeature.assets, mockAssets);
    });

    test('init sets navigationManager', () {
      final provider = Provider((ref) => mockNavigationManager);

      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: provider,
      );

      expect(UpdateFeature.navigationManager, provider);
    });

    test('init sets custom repository when provided', () {
      final provider = Provider<UpdateRepository>((ref) => mockRepository);

      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
        updateRepository: provider,
      );

      expect(UpdateFeature.repository, provider);
    });

    test('init uses baseUpdateRepositoryProvider when repository not provided', () {
      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      expect(UpdateFeature.repository, baseUpdateRepositoryProvider);
    });

    test('init can be called multiple times', () {
      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      final newMockLocalizations = MockUpdateLocalizations();
      when(() => newMockLocalizations.newUpdateAvailableTitle).thenReturn('New Title');
      when(() => newMockLocalizations.newUpdateAvailableSubtitle).thenReturn('New Subtitle');
      when(() => newMockLocalizations.installUpdate).thenReturn('Install Now');
      when(() => newMockLocalizations.illDoThisLater).thenReturn('Later');

      UpdateFeature.init(
        updateLocalizations: newMockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      expect(UpdateFeature.localizations, newMockLocalizations);
    });

    test('localizations can be accessed after init', () {
      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      expect(UpdateFeature.localizations.newUpdateAvailableTitle, 'Title');
      expect(UpdateFeature.localizations.newUpdateAvailableSubtitle, 'Subtitle');
      expect(UpdateFeature.localizations.installUpdate, 'Install');
      expect(UpdateFeature.localizations.illDoThisLater, 'Later');
    });

    test('assets can be accessed after init', () {
      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      expect(UpdateFeature.assets.avatar, null);
    });

    test('navigationManager provider can be used', () {
      final provider = Provider((ref) => mockNavigationManager);

      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: provider,
      );

      final container = ProviderContainer();
      final manager = container.read(UpdateFeature.navigationManager);
      expect(manager, mockNavigationManager);
      container.dispose();
    });

    test('repository provider can be used', () {
      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      final container = ProviderContainer();
      final repo = container.read(UpdateFeature.repository);
      expect(repo, isA<UpdateRepository>());
      container.dispose();
    });
  });
}
