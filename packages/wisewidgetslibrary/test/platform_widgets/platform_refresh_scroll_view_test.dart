import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_refresh_scroll_view.dart';

void main() {
  testWidgets(
      'createMaterialWidget creates MaterialRefreshIndicator with correct properties',
      (tester) async {
    final refreshIndicator = PlatformCustomScrollRefreshIndicator(
      onRefresh: () async {},
      slivers: const [
        SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ), // Example sliver content
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const CupertinoSliverNavigationBar(
                  largeTitle: Text('test'),
                ),
              ),
            ],
            body: Builder(
              builder: refreshIndicator.createMaterialWidget,
            ),
          ),
        ),
      ),
    );

    final materialRefreshIndicator =
        tester.widget<RefreshIndicator>(find.byType(RefreshIndicator));
    expect(materialRefreshIndicator.onRefresh, isNotNull);
  });

  testWidgets(
      'createCupertinoWidget correctly builds CupertinoSliverRefreshControl with builder function',
      (tester) async {
    final refreshIndicator = PlatformCustomScrollRefreshIndicator(
      onRefresh: () async {},
      slivers: const [
        SliverToBoxAdapter(child: SizedBox(height: 1000)),
      ],
    );

    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const CupertinoSliverNavigationBar(
                  largeTitle: Text('test'),
                ),
              ),
            ],
            body: Builder(
              builder: refreshIndicator.createCupertinoWidget,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final customScrollView =
        tester.widget<CustomScrollView>(find.byType(CustomScrollView));

    final cupertinoRefreshControl = customScrollView.slivers
        .whereType<CupertinoSliverRefreshControl>()
        .first;

    expect(cupertinoRefreshControl, isNotNull);
    expect(cupertinoRefreshControl.onRefresh, isNotNull);

    // Trigger the builder function by simulating a pull-to-refresh gesture**
    final gesture = await tester.startGesture(const Offset(100, 200));
    await gesture.moveBy(const Offset(0, 200));
    await tester.pump();

    final cupertinoActivityIndicator =
        tester.widget<CupertinoActivityIndicator>(
      find.byType(CupertinoActivityIndicator),
    );

    expect(cupertinoActivityIndicator, isNotNull);

    // Complete the refresh action
    await gesture.up();
    await tester.pumpAndSettle();
  });
}
