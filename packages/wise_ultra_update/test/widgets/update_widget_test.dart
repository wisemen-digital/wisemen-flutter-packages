import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

import '../helpers/test_app_wrapper.dart';
import '../utils/mock_classes.dart';

void main() {
  group('UpdateWidget', () {
    late MockUpdateNavigationManager mockNavigationManager;
    late MockUpdateLocalizations mockLocalizations;
    late MockUpdateAssets mockAssets;

    setUp(() {
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
      );
    });

    test('UpdateWidget can be instantiated', () {
      const widget = UpdateWidget(isRequired: true);
      expect(widget.isRequired, true);
    });

    test('UpdateWidget with optional update', () {
      const widget = UpdateWidget(isRequired: false);
      expect(widget.isRequired, false);
    });

    test('UpdateWidget can have a key', () {
      const key = Key('update_widget_key');
      const widget = UpdateWidget(isRequired: true, key: key);
      expect(widget.key, key);
      expect(widget.isRequired, true);
    });

    testWidgets('displays update dialog with required update', (tester) async {
      await tester.pumpWidget(
        const TestAppWrapper(
          child: UpdateWidget(isRequired: true),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Update Available'), findsOneWidget);
      expect(find.text('A new version is available'), findsOneWidget);
      expect(find.text('Install'), findsOneWidget);
      expect(find.text('Later'), findsNothing);
    });

    testWidgets('displays update dialog with optional update', (tester) async {
      await tester.pumpWidget(
        const TestAppWrapper(
          child: UpdateWidget(isRequired: false),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Update Available'), findsOneWidget);
      expect(find.text('A new version is available'), findsOneWidget);
      expect(find.text('Install'), findsOneWidget);
      expect(find.text('Later'), findsOneWidget);
    });

    testWidgets('calls installUpdate when Install button is tapped', (tester) async {
      await tester.pumpWidget(
        const TestAppWrapper(
          child: UpdateWidget(isRequired: false),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Install'));
      await tester.pumpAndSettle();

      verify(() => mockNavigationManager.installUpdate()).called(1);
    });

    testWidgets('calls installLater when Later button is tapped', (tester) async {
      await tester.pumpWidget(
        const TestAppWrapper(
          child: UpdateWidget(isRequired: false),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Later'));
      await tester.pumpAndSettle();

      verify(() => mockNavigationManager.installLater()).called(1);
    });

    testWidgets('does not display avatar when avatar is null', (tester) async {
      await tester.pumpWidget(
        const TestAppWrapper(
          child: UpdateWidget(isRequired: false),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Image), findsNothing);
    });

    testWidgets('displays correct text for required update', (tester) async {
      await tester.pumpWidget(
        const TestAppWrapper(
          child: UpdateWidget(isRequired: true),
        ),
      );

      await tester.pumpAndSettle();

      // Verify all text is displayed
      expect(find.text('Update Available'), findsOneWidget);
      expect(find.text('A new version is available'), findsOneWidget);
      expect(find.text('Install'), findsOneWidget);
    });

    testWidgets('displays correct text for optional update', (tester) async {
      await tester.pumpWidget(
        const TestAppWrapper(
          child: UpdateWidget(isRequired: false),
        ),
      );

      await tester.pumpAndSettle();

      // Verify all text is displayed including Later button
      expect(find.text('Update Available'), findsOneWidget);
      expect(find.text('A new version is available'), findsOneWidget);
      expect(find.text('Install'), findsOneWidget);
      expect(find.text('Later'), findsOneWidget);
    });

    testWidgets('displays avatar when avatar path is provided', (tester) async {
      when(() => mockAssets.avatar).thenReturn('test/assets/test_avatar.png');

      UpdateFeature.init(
        updateLocalizations: mockLocalizations,
        updateAssets: mockAssets,
        updateNavigationManager: Provider((ref) => mockNavigationManager),
      );

      await tester.pumpWidget(
        const TestAppWrapper(
          child: UpdateWidget(isRequired: false),
        ),
      );

      await tester.pumpAndSettle();

      // Verify avatar image is displayed
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
