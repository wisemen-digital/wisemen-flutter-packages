import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_nav_bar/src/native/platform_sliver_appbar.dart';
import 'package:wise_nav_bar/src/utils/platform_widget_helper.dart';

class TestPlatformService implements PlatformService {
  TestPlatformService({
    this.android = false,
    this.ios = false,
    this.web = false,
    this.macos = false,
    this.linux = false,
    this.fuchsia = false,
    this.windows = false,
  });
  final bool android;
  final bool ios;
  final bool web;
  final bool macos;
  final bool linux;
  final bool fuchsia;
  final bool windows;

  @override
  bool get isAndroid => android;

  @override
  bool get isIOS => ios;

  @override
  bool get isWeb => web;

  @override
  bool get isMacOS => macos;

  @override
  bool get isLinux => linux;

  @override
  bool get isFuchsia => fuchsia;

  @override
  bool get isWindows => windows;
}

void main() {
  group('PlatformSliverAppBar', () {
    testWidgets('creates Material SliverAppBar on Android',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(android: true),
                title: const Text('Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(SliverAppBar), findsOneWidget);
    });

    testWidgets('creates CupertinoSliverNavigationBar on iOS',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(CupertinoSliverNavigationBar), findsOneWidget);
    });

    testWidgets('creates Material SliverAppBar on Web',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(web: true),
                title: const Text('Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(SliverAppBar), findsOneWidget);
    });

    testWidgets('creates CupertinoSliverNavigationBar on macOS',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(macos: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(CupertinoSliverNavigationBar), findsOneWidget);
    });

    testWidgets('creates CupertinoSliverNavigationBar on Linux',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(linux: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(CupertinoSliverNavigationBar), findsOneWidget);
    });

    testWidgets('creates Material SliverAppBar on Fuchsia',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(fuchsia: true),
                title: const Text('Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(SliverAppBar), findsOneWidget);
    });

    testWidgets('creates Material SliverAppBar on Windows',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(windows: true),
                title: const Text('Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(SliverAppBar), findsOneWidget);
    });

    testWidgets('creates Material SliverAppBar with actions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(android: true),
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
    });

    testWidgets('creates CupertinoSliverNavigationBar on iOS',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
              ),
            ],
          ),
        ),
      );
      expect(find.byType(CupertinoSliverNavigationBar), findsOneWidget);
    });

    testWidgets('creates Material SliverAppBar with backgroundColor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(android: true),
                title: const Text('Title'),
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
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
          find.byType(CupertinoSliverNavigationBar),);
      expect(navBar.backgroundColor, Colors.red);
    });

    testWidgets('creates Material SliverAppBar with brightness',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(android: true),
                title: const Text('Title'),
                brightness: Brightness.dark,
              ),
            ],
          ),
        ),
      );
      final sliverAppBar =
          tester.widget<SliverAppBar>(find.byType(SliverAppBar));
      expect(sliverAppBar.systemOverlayStyle?.statusBarBrightness,
          Brightness.dark,);
    });

    testWidgets('creates CupertinoSliverNavigationBar with brightness',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
                brightness: Brightness.dark,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
          find.byType(CupertinoSliverNavigationBar),);
      expect(navBar.brightness, Brightness.dark);
    });

    testWidgets('creates Material SliverAppBar with bottom widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(android: true),
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
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
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
          find.byType(CupertinoSliverNavigationBar),);
      expect(navBar.bottom?.preferredSize.height, 50.0);
    });

    testWidgets('creates Material SliverAppBar with border',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(android: true),
                title: const Text('Title'),
                border: const Border(bottom: BorderSide()),
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
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
                border: const Border(bottom: BorderSide()),
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
          find.byType(CupertinoSliverNavigationBar),);
      expect(navBar.border, const Border(bottom: BorderSide()));
    });

    testWidgets(
        'creates CupertinoSliverNavigationBar with automaticBackgroundVisibility',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
                automaticBackgroundVisibility: false,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
          find.byType(CupertinoSliverNavigationBar),);
      expect(navBar.automaticBackgroundVisibility, false);
    });

    testWidgets(
        'creates CupertinoSliverNavigationBar with enableBackgroundFilterBlur',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
                enableBackgroundFilterBlur: false,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
          find.byType(CupertinoSliverNavigationBar),);
      expect(navBar.enableBackgroundFilterBlur, false);
    });

    testWidgets(
        'creates CupertinoSliverNavigationBar with transitionBetweenRoutes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: CustomScrollView(
            slivers: [
              PlatformSliverAppBar(
                platformService: TestPlatformService(ios: true),
                title: const Text('Title'),
                largeTitle: const Text('Large Title'),
                transitionBetweenRoutes: false,
              ),
            ],
          ),
        ),
      );
      final navBar = tester.widget<CupertinoSliverNavigationBar>(
          find.byType(CupertinoSliverNavigationBar),);
      expect(navBar.transitionBetweenRoutes, false);
    });
  });
}
