import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_nav_bar/src/native/platform_sliver_appbar.dart';

void main() {
  group('PlatformSliverAppBar', () {
    testWidgets('createMaterialWidget returns SliverAppBar',
        (WidgetTester tester) async {
      const platformSliverAppBar = PlatformSliverAppBar(
        title: Text('Title'),
      );

      final materialWidget = platformSliverAppBar
          .createMaterialWidget(tester.element(find.byType(Container)));

      expect(materialWidget, isA<SliverAppBar>());
    });

    testWidgets('createCupertinoWidget returns CupertinoSliverNavigationBar',
        (WidgetTester tester) async {
      const platformSliverAppBar = PlatformSliverAppBar(
        title: Text('Title'),
      );

      final cupertinoWidget = platformSliverAppBar
          .createCupertinoWidget(tester.element(find.byType(Container)));

      expect(cupertinoWidget, isA<CupertinoSliverNavigationBar>());
    });

    testWidgets('creates Material SliverAppBar with actions',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: const Text('Title'),
                actions: [
                  IconButton(icon: const Icon(Icons.add), onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      );
      expect(find.byType(IconButton), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('creates CupertinoSliverNavigationBar on iOS',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        const CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                largeTitle: Text('Large Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(CupertinoSliverNavigationBar), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('creates Material SliverAppBar with backgroundColor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      );
      final sliverAppBar =
          tester.widget<SliverAppBar>(find.byType(SliverAppBar));
      expect(sliverAppBar.backgroundColor, Colors.red);
    });

    testWidgets('creates CupertinoSliverNavigationBar with backgroundColor',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        const CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                largeTitle: Text('Large Title'),
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
        find.byType(CupertinoSliverNavigationBar),
      );
      expect(navBar.backgroundColor, Colors.red);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('creates Material SliverAppBar with brightness',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                brightness: Brightness.dark,
              ),
            ],
          ),
        ),
      );
      final sliverAppBar =
          tester.widget<SliverAppBar>(find.byType(SliverAppBar));
      expect(
        sliverAppBar.systemOverlayStyle?.statusBarBrightness,
        Brightness.dark,
      );
    });

    testWidgets('creates CupertinoSliverNavigationBar with brightness',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        const CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                largeTitle: Text('Large Title'),
                brightness: Brightness.dark,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
        find.byType(CupertinoSliverNavigationBar),
      );
      expect(navBar.brightness, Brightness.dark);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('creates Material SliverAppBar with bottom widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: const Text('Title'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(height: 50),
                ),
              ),
            ],
          ),
        ),
      );
      final sliverAppBar =
          tester.widget<SliverAppBar>(find.byType(SliverAppBar));
      expect(sliverAppBar.bottom?.preferredSize.height, 50.0);
    });

    testWidgets('creates CupertinoSliverNavigationBar with bottom widget',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(height: 50),
                ),
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
        find.byType(CupertinoSliverNavigationBar),
      );
      expect(navBar.bottom?.preferredSize.height, 50.0);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('creates Material SliverAppBar with border',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                border: Border(bottom: BorderSide()),
              ),
            ],
          ),
        ),
      );
      final sliverAppBar =
          tester.widget<SliverAppBar>(find.byType(SliverAppBar));
      expect(sliverAppBar.shape, const Border(bottom: BorderSide()));
    });

    testWidgets('creates CupertinoSliverNavigationBar with border',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        const CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                largeTitle: Text('Large Title'),
                border: Border(bottom: BorderSide()),
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
        find.byType(CupertinoSliverNavigationBar),
      );
      expect(navBar.border, const Border(bottom: BorderSide()));

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'creates CupertinoSliverNavigationBar with automaticBackgroundVisibility',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        const CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                largeTitle: Text('Large Title'),
                automaticBackgroundVisibility: false,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
        find.byType(CupertinoSliverNavigationBar),
      );
      expect(navBar.automaticBackgroundVisibility, false);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'creates CupertinoSliverNavigationBar with enableBackgroundFilterBlur',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        const CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                largeTitle: Text('Large Title'),
                enableBackgroundFilterBlur: false,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
        find.byType(CupertinoSliverNavigationBar),
      );
      expect(navBar.enableBackgroundFilterBlur, false);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'creates CupertinoSliverNavigationBar with transitionBetweenRoutes',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      await tester.pumpWidget(
        const CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                title: Text('Title'),
                largeTitle: Text('Large Title'),
                transitionBetweenRoutes: false,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
        find.byType(CupertinoSliverNavigationBar),
      );
      expect(navBar.transitionBetweenRoutes, false);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'PlatformSliverAppBar.text constructor returns the correct text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar.text(
                title: 'Large Title',
              ),
            ],
          ),
        ),
      );

      expect(find.text('Large Title'), findsAtLeast(1));
    });
  });
}
