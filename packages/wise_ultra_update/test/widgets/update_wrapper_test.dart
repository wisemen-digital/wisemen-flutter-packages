import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

import '../helpers/test_app_wrapper.dart';
import '../utils/mock_classes.dart';

void main() {
  group('UpdateWrapper', () {
    late MockUpdateRepository mockRepository;
    late MockUpdateNavigationManager mockNavigationManager;
    late MockUpdateLocalizations mockLocalizations;
    late MockUpdateAssets mockAssets;

    setUp(() {
      mockRepository = MockUpdateRepository();
      mockNavigationManager = MockUpdateNavigationManager();
      mockLocalizations = MockUpdateLocalizations();
      mockAssets = MockUpdateAssets();

      when(() => mockLocalizations.newUpdateAvailableTitle).thenReturn('Update Available');
      when(() => mockLocalizations.newUpdateAvailableSubtitle).thenReturn('A new version is available');
      when(() => mockLocalizations.installUpdate).thenReturn('Install');
      when(() => mockLocalizations.illDoThisLater).thenReturn('Later');
      when(() => mockAssets.avatar).thenReturn(null);
      when(() => mockNavigationManager.installUpdate()).thenReturn(null);
      when(() => mockNavigationManager.installLater()).thenReturn(null);

      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
        updateRepository: Provider((ref) => mockRepository),
      );
    });

    test('UpdateWrapper can be instantiated', () {
      const widget = UpdateWrapper(child: Text('Test'));
      expect(widget.child, isA<Text>());
    });

    test('UpdateWrapper can have a key', () {
      const key = Key('wrapper_key');
      const widget = UpdateWrapper(child: Text('Test'), key: key);
      expect(widget.key, key);
      expect(widget.child, isA<Text>());
    });

    testWidgets('renders child widget', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (false, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: const UpdateWrapper(
            child: Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Child Widget'), findsOneWidget);
    });

    testWidgets('checks for update on init', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (false, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: const UpdateWrapper(
            child: Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      verify(() => mockRepository.checkNeedsUpdate()).called(1);
    });

    testWidgets('shows update dialog when update is available on init', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (true, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: const UpdateWrapper(
            child: Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Update Available'), findsOneWidget);
    });

    testWidgets('checks for update when app resumes', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (false, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: const UpdateWrapper(
            child: Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Simulate app lifecycle change to resumed
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      // Should be called twice: once on init, once on resume
      verify(() => mockRepository.checkNeedsUpdate()).called(2);
    });

    testWidgets('does not check for update when app is paused', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (false, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: const UpdateWrapper(
            child: Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Simulate app lifecycle change to paused
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();

      // Should only be called once on init, not on pause
      verify(() => mockRepository.checkNeedsUpdate()).called(1);
    });

    testWidgets('removes observer on dispose', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (false, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: const UpdateWrapper(
            child: Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Remove the widget by replacing with a different child
      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: const Text('New Widget'),
        ),
      );

      await tester.pumpAndSettle();

      // Verify no errors occur after disposal
      expect(find.text('New Widget'), findsOneWidget);
      expect(find.text('Child Widget'), findsNothing);
    });

    testWidgets('handles inactive lifecycle state', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (false, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: const UpdateWrapper(
            child: Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Simulate app lifecycle change to inactive
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await tester.pumpAndSettle();

      // Should only be called once on init, not on inactive
      verify(() => mockRepository.checkNeedsUpdate()).called(1);
    });
  });
}
