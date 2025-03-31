import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_refresh_scroll_view.dart';

void main() {
  testWidgets('createMaterialWidget creates MaterialRefreshIndicator with correct properties', (tester) async {
    final refreshIndicator = PlatformCustomScrollRefreshIndicator(
      onRefresh: () async {},
      slivers: const [
        SliverToBoxAdapter(child: SizedBox(height: 100)), // Example sliver content
      ],
      injectOverlap: true, // Ensure this matches your widget logic
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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

    final materialRefreshIndicator = tester.widget<RefreshIndicator>(find.byType(RefreshIndicator));
    expect(materialRefreshIndicator.onRefresh, isNotNull);
  });

  testWidgets('create cupertino widget creates CupertinoRefreshControl with correct properties', (tester) async {
    final refreshIndicator = PlatformCustomScrollRefreshIndicator(
      onRefresh: () async {},
      slivers: [],
      injectOverlap: true, // Ensure this matches your widget logic
    );

    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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

    final customScrollView = tester.widgetList(find.byType(CustomScrollView)).toList();
    final widget = customScrollView.first as CustomScrollView;
    final cupertinoRefreshControl = widget.slivers.whereType<CupertinoSliverRefreshControl>();

    expect(cupertinoRefreshControl, isNotEmpty);
    expect(cupertinoRefreshControl.first.onRefresh, isNotNull);
  });
}
