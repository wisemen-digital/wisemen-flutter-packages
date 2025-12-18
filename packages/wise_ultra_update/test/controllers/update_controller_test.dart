import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

import '../helpers/test_app_wrapper.dart';
import '../utils/mock_classes.dart';

void main() {
  group('UpdateController', () {
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

    test('UpdateController class exists', () {
      expect(UpdateController, isNotNull);
    });

    test('UpdateController has showUpdateDialogIfNeeded method', () {
      expect(UpdateController.showUpdateDialogIfNeeded, isA<Function>());
    });

    testWidgets('does not show dialog when no update is needed', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (false, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              return ElevatedButton(
                onPressed: () async {
                  await UpdateController.showUpdateDialogIfNeeded(context, ref);
                },
                child: const Text('Check Update'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Check Update'));
      await tester.pumpAndSettle();

      expect(find.text('Update Available'), findsNothing);
    });

    testWidgets('shows dialog when update is available and required', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (true, true));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              return ElevatedButton(
                onPressed: () async {
                  await UpdateController.showUpdateDialogIfNeeded(context, ref);
                },
                child: const Text('Check Update'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Check Update'));
      await tester.pumpAndSettle();

      expect(find.text('Update Available'), findsOneWidget);
      expect(find.text('Later'), findsNothing);
    });

    testWidgets('shows dialog when update is available and optional', (tester) async {
      when(() => mockRepository.checkNeedsUpdate()).thenAnswer((_) async => (true, false));

      await tester.pumpWidget(
        TestAppWrapper(
          overrides: [
            UpdateFeature.repository.overrideWithValue(mockRepository),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              return ElevatedButton(
                onPressed: () async {
                  await UpdateController.showUpdateDialogIfNeeded(context, ref);
                },
                child: const Text('Check Update'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Check Update'));
      await tester.pumpAndSettle();

      expect(find.text('Update Available'), findsOneWidget);
      expect(find.text('Later'), findsOneWidget);
    });


  });
}
