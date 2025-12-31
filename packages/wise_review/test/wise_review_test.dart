import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise_review/wise_review.dart';
import 'package:wisecore/wisecore.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WiseReview Widget Tests', () {
    testWidgets('renders child widget', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test Child'),
            ),
          ),
        ),
      );

      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('increments open count on init', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 5});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(prefs.getInt('app_open_count'), 6);
    });

    testWidgets('does not show review when count is below minimum',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 5});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: true,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Widget should still render
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('respects custom minimumOpenCount',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 2});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              minimumOpenCount: 3,
              canShowReview: true,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(prefs.getInt('app_open_count'), 3);
    });

    testWidgets('handles canShowReview false', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 15});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should not crash and should render child
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('updates when canShowReview changes from false to true',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 15});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Update to canShowReview: true
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: true,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('does not trigger when canShowReview stays false',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 15});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Update with canShowReview still false
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test Updated'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Updated'), findsOneWidget);
    });

    testWidgets('initializes with zero count when no previous value',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(prefs.getInt('app_open_count'), 1);
    });

    testWidgets('handles multiple children', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Column(
                children: [
                  Text('Child 1'),
                  Text('Child 2'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
    });

    testWidgets('widget disposes correctly', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Remove the widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: Text('New Screen'),
          ),
        ),
      );

      expect(find.text('New Screen'), findsOneWidget);
      expect(find.text('Test'), findsNothing);
    });
  });

  group('WiseReview Lifecycle Tests', () {
    testWidgets('increments count on app resume', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 5});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Simulate app lifecycle change to resumed
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      // Initial increment (6) + resume increment (7)
      expect(prefs.getInt('app_open_count'), 7);
    });

    testWidgets('does not increment on app pause', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 5});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final countBeforePause = prefs.getInt('app_open_count');

      // Simulate app lifecycle change to paused
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();

      final countAfterPause = prefs.getInt('app_open_count');

      expect(countAfterPause, countBeforePause);
    });

    testWidgets('does not increment on app inactive',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 5});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final countBeforeInactive = prefs.getInt('app_open_count');

      // Simulate app lifecycle change to inactive
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await tester.pumpAndSettle();

      final countAfterInactive = prefs.getInt('app_open_count');

      expect(countAfterInactive, countBeforeInactive);
    });
  });

  group('WiseReview Edge Cases', () {
    testWidgets('handles zero minimumOpenCount', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              minimumOpenCount: 0,
              canShowReview: true,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('handles very large minimumOpenCount',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 100});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: true,
              minimumOpenCount: 1000000,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('handles exact minimumOpenCount threshold',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 9});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: true,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(prefs.getInt('app_open_count'), 10);
    });

    testWidgets('handles default minimumOpenCount of 10',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: true,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should increment to 1, but not show review (needs 10)
      expect(prefs.getInt('app_open_count'), 1);
      expect(find.text('Test'), findsOneWidget);
    });
  });

  group('WiseReview Integration Tests', () {
    testWidgets('increments count across multiple widget rebuilds',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 0});
      final prefs = await SharedPreferences.getInstance();

      // First build
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test 1'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(prefs.getInt('app_open_count'), 1);

      // Rebuild with different child
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test 2'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      // Count should not increment on rebuild, only on init
      expect(prefs.getInt('app_open_count'), 1);
    });

    testWidgets('handles rapid lifecycle changes', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'app_open_count': 0});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: WiseReview(
              canShowReview: false,
              child: Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Rapid lifecycle changes
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await tester.pump();
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump();
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      // Should only increment once for resumed
      expect(prefs.getInt('app_open_count'), 2);
    });
  });
}
