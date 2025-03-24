import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_nav_bar/src/native/platform_appbar.dart';
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
  group('PlatformAppBar', () {
    testWidgets('creates Material AppBar on Android', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: PlatformAppBar(
            platformService: TestPlatformService(android: true),
            title: const Text('Title'),
          ),
        ),
      ),);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('creates CupertinoNavigationBar on iOS', (WidgetTester tester) async {
      await tester.pumpWidget(CupertinoApp(
        home: CupertinoPageScaffold(
          navigationBar: PlatformAppBar(
            platformService: TestPlatformService(ios: true),
            title: const Text('Title'),
          ),
          child: Container(),
        ),
      ),);
      expect(find.byType(CupertinoNavigationBar), findsOneWidget);
    });

    testWidgets('creates Material AppBar on Web', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: PlatformAppBar(
            platformService: TestPlatformService(web: true),
            title: const Text('Title'),
          ),
        ),
      ),);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('creates CupertinoNavigationBar on macOS', (WidgetTester tester) async {
      await tester.pumpWidget(CupertinoApp(
        home: CupertinoPageScaffold(
          navigationBar: PlatformAppBar(
            platformService: TestPlatformService(macos: true),
            title: const Text('Title'),
          ),
          child: Container(),
        ),
      ),);
      expect(find.byType(CupertinoNavigationBar), findsOneWidget);
    });

    testWidgets('creates CupertinoNavigationBar on Linux', (WidgetTester tester) async {
      await tester.pumpWidget(CupertinoApp(
        home: CupertinoPageScaffold(
          navigationBar: PlatformAppBar(
            platformService: TestPlatformService(linux: true),
            title: const Text('Title'),
          ),
          child: Container(),
        ),
      ),);
      expect(find.byType(CupertinoNavigationBar), findsOneWidget);
    });

    testWidgets('creates Material AppBar on Fuchsia', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: PlatformAppBar(
            platformService: TestPlatformService(fuchsia: true),
            title: const Text('Title'),
          ),
        ),
      ),);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('creates Material AppBar on Windows', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: PlatformAppBar(
            platformService: TestPlatformService(windows: true),
            title: const Text('Title'),
          ),
        ),
      ),);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('creates Material AppBar with actions', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: PlatformAppBar(
            platformService: TestPlatformService(android: true),
            title: const Text('Title'),
            actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
          ),
        ),
      ),);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('creates CupertinoNavigationBar with actions', (WidgetTester tester) async {
      await tester.pumpWidget(CupertinoApp(
        home: CupertinoPageScaffold(
          navigationBar: PlatformAppBar(
            platformService: TestPlatformService(ios: true),
            title: const Text('Title'),
            actions: [CupertinoButton(child: const Text('Action'), onPressed: () {})],
          ),
          child: Container(),
        ),
      ),);
      expect(find.byType(CupertinoButton), findsOneWidget);
    });

    testWidgets('creates Material AppBar with backgroundColor', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: PlatformAppBar(
            platformService: TestPlatformService(android: true),
            title: const Text('Title'),
            backgroundColor: Colors.red,
          ),
        ),
      ),);
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Colors.red);
    });

    testWidgets('creates CupertinoNavigationBar with backgroundColor', (WidgetTester tester) async {
      await tester.pumpWidget(CupertinoApp(
        home: CupertinoPageScaffold(
          navigationBar: PlatformAppBar(
            platformService: TestPlatformService(ios: true),
            title: const Text('Title'),
            backgroundColor: Colors.red,
          ),
          child: Container(),
        ),
      ),);
      final navBar = tester.widget<CupertinoNavigationBar>(find.byType(CupertinoNavigationBar));
      expect(navBar.backgroundColor, Colors.red);
    });

    testWidgets('creates Material AppBar with brightness', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: PlatformAppBar(
            platformService: TestPlatformService(android: true),
            title: const Text('Title'),
            brightness: Brightness.dark,
          ),
        ),
      ),);
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.systemOverlayStyle?.statusBarBrightness, Brightness.dark);
    });

    testWidgets('creates CupertinoNavigationBar with brightness', (WidgetTester tester) async {
      await tester.pumpWidget(CupertinoApp(
        home: CupertinoPageScaffold(
          navigationBar: PlatformAppBar(
            platformService: TestPlatformService(ios: true),
            title: const Text('Title'),
            brightness: Brightness.dark,
          ),
          child: Container(),
        ),
      ),);
      final navBar = tester.widget<CupertinoNavigationBar>(find.byType(CupertinoNavigationBar));
      expect(navBar.brightness, Brightness.dark);
    });

    testWidgets('creates Material AppBar with bottom widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: PlatformAppBar(
            platformService: TestPlatformService(android: true),
            title: const Text('Title'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(height: 50),
            ),
          ),
        ),
      ),);
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.bottom?.preferredSize.height, 50.0);
    });

    testWidgets('creates CupertinoNavigationBar with bottom widget', (WidgetTester tester) async {
      await tester.pumpWidget(CupertinoApp(
        home: CupertinoPageScaffold(
          navigationBar: PlatformAppBar(
            platformService: TestPlatformService(ios: true),
            title: const Text('Title'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(height: 50),
            ),
          ),
          child: Container(),
        ),
      ),);
      final navBar = tester.widget<CupertinoNavigationBar>(find.byType(CupertinoNavigationBar));
      expect(navBar.bottom?.preferredSize.height, 50.0);
    });
  });
}
