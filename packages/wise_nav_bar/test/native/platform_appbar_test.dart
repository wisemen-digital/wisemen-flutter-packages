import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_nav_bar/src/native/platform_appbar.dart';
import 'package:wise_nav_bar/src/utils/platform_widget_helper.dart';

class MockIsWebService implements IsWebService {
  const MockIsWebService();

  @override
  bool getIsWeb() => true;
}

// Mock platform widget implementation for testing
class PlatformWidgetMock
    extends PlatformWidget<CupertinoPageScaffold, Material> {
  const PlatformWidgetMock({super.key, super.isWebService});

  @override
  CupertinoPageScaffold createCupertinoWidget(BuildContext context) {
    return CupertinoPageScaffold(child: Container());
  }

  @override
  Material createMaterialWidget(BuildContext context) {
    return Material(child: Container());
  }
}

void main() {
  group('PlatformAppBar', () {
    testWidgets('createMaterialWidget returns AppBar',
        (WidgetTester tester) async {
      const platformAppBar = PlatformAppBar(
        title: Text('Title'),
      );

      final materialWidget = platformAppBar
          .createMaterialWidget(tester.element(find.byType(Container)));

      expect(materialWidget, isA<AppBar>());
    });

    testWidgets('createCupertinoWidget returns CupertinoNavigationBar',
        (WidgetTester tester) async {
      const platformAppBar = PlatformAppBar(
        title: Text('Title'),
      );

      final cupertinoWidget = platformAppBar
          .createCupertinoWidget(tester.element(find.byType(Container)));

      expect(cupertinoWidget, isA<CupertinoNavigationBar>());
    });

    testWidgets('creates Material AppBar with actions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: PlatformAppBar(
              title: const Text('Title'),
              actions: [
                IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('creates CupertinoNavigationBar with actions',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        CupertinoApp(
          home: CupertinoPageScaffold(
            navigationBar: PlatformAppBar(
              title: const Text('Title'),
              actions: [
                CupertinoButton(child: const Text('Action'), onPressed: () {}),
              ],
            ),
            child: Container(),
          ),
        ),
      );
      expect(find.byType(CupertinoButton), findsOneWidget);
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('creates Material AppBar with backgroundColor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PlatformAppBar(
              title: Text('Title'),
              backgroundColor: Colors.red,
            ),
          ),
        ),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Colors.red);
    });

    testWidgets('creates CupertinoNavigationBar with backgroundColor',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        CupertinoApp(
          home: CupertinoPageScaffold(
            navigationBar: const PlatformAppBar(
              title: Text('Title'),
              backgroundColor: Colors.red,
            ),
            child: Container(),
          ),
        ),
      );
      final navBar = tester
          .widget<CupertinoNavigationBar>(find.byType(CupertinoNavigationBar));
      expect(navBar.backgroundColor, Colors.red);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('creates Material AppBar with brightness',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PlatformAppBar(
              title: Text('Title'),
              brightness: Brightness.dark,
            ),
          ),
        ),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.systemOverlayStyle?.statusBarBrightness, Brightness.dark);
    });

    testWidgets('creates CupertinoNavigationBar with brightness',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        CupertinoApp(
          home: CupertinoPageScaffold(
            navigationBar: const PlatformAppBar(
              title: Text('Title'),
              brightness: Brightness.dark,
            ),
            child: Container(),
          ),
        ),
      );
      final navBar = tester
          .widget<CupertinoNavigationBar>(find.byType(CupertinoNavigationBar));
      expect(navBar.brightness, Brightness.dark);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('creates Material AppBar with bottom widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: PlatformAppBar(
              title: const Text('Title'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(height: 50),
              ),
            ),
          ),
        ),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.bottom?.preferredSize.height, 50.0);
    });

    testWidgets('creates CupertinoNavigationBar with bottom widget',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        CupertinoApp(
          home: CupertinoPageScaffold(
            navigationBar: PlatformAppBar(
              title: const Text('Title'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(height: 50),
              ),
            ),
            child: Container(),
          ),
        ),
      );
      final navBar = tester
          .widget<CupertinoNavigationBar>(find.byType(CupertinoNavigationBar));
      expect(navBar.bottom?.preferredSize.height, 50.0);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}
