import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_sliver_refresh_control.dart';

class FakeBuildContext extends Fake implements BuildContext {}

class MockOnChangedCallback extends Mock {
  void call({required bool value});
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  testWidgets('createCupertinoWidget returns CupertinoSliverRefreshControl',
      (tester) async {
    final platformRefreshControl = PlatformSliverRefreshControl(
      onRefresh: () => Future.delayed(const Duration(seconds: 1)),
      color: Colors.black,
      backgroundColor: Colors.white,
    );

    final cupertinoRefreshControl =
        platformRefreshControl.createCupertinoWidget(FakeBuildContext());

    expect(cupertinoRefreshControl, isA<CupertinoSliverRefreshControl>());
  });

  testWidgets(
      'createMaterialWidget returns CupertinoSliverRefreshControl with CustomMaterialRefreshProgressIndicator',
      (tester) async {
    final platformRefreshControl = PlatformSliverRefreshControl(
      onRefresh: () => Future.delayed(const Duration(seconds: 1)),
      color: Colors.black,
      backgroundColor: Colors.white,
    );

    final materialRefreshControl =
        platformRefreshControl.createMaterialWidget(FakeBuildContext());

    expect(materialRefreshControl, isA<CupertinoSliverRefreshControl>());
  });

  testWidgets('Refresh indicator builder shows correct states',
      (WidgetTester tester) async {
    const testColor = Colors.blue;
    const testBackgroundColor = Colors.grey;

    // Helper function to pump the builder with specific state
    Future<void> pumpBuilder(
      RefreshIndicatorMode state,
      double extent,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) {
            return PlatformSliverRefreshControl(
              onRefresh: () => Future.delayed(const Duration(seconds: 1)),
              color: testColor,
              backgroundColor: testBackgroundColor,
            ).buildRefreshIndicator(state, extent);
          },
        ),
      );
    }

    // --- Test Case 1: Inactive State ---
    await pumpBuilder(RefreshIndicatorMode.inactive, 0);

    // Find the indicator
    final indicatorFinder = find.byType(CustomMaterialRefreshProgressIndicator);
    expect(indicatorFinder, findsOneWidget);

    // ignore: omit_local_variable_types
    CustomMaterialRefreshProgressIndicator indicator =
        tester.widget(indicatorFinder);
    expect(indicator.value, 0.0); // Should be determinate 0.0
    expect(indicator.color, testColor);
    expect(indicator.backgroundColor, testBackgroundColor);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Spacer), findsNWidgets(2));

    // Dragging State
    await pumpBuilder(RefreshIndicatorMode.drag, 50); // Pulled 50%
    indicator = tester.widget(indicatorFinder);
    expect(indicator.value, equals(0.5));

    // Test clamping
    await pumpBuilder(RefreshIndicatorMode.drag, 150);
    indicator = tester.widget(indicatorFinder);
    expect(indicator.value, equals(1.0)); // Clamped to 1.0

    // Armed State
    await pumpBuilder(RefreshIndicatorMode.armed, 100);
    indicator = tester.widget(indicatorFinder);
    expect(indicator.value, isNull);

    // Refresh State
    await pumpBuilder(RefreshIndicatorMode.refresh, 100);
    indicator = tester.widget(indicatorFinder);
    expect(indicator.value, isNull);

    // Done State
    await pumpBuilder(RefreshIndicatorMode.done, 0);
    indicator = tester.widget(indicatorFinder);
    expect(indicator.value, 0.0);
  });
}
