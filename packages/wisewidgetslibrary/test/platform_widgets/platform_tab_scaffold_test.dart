import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

// Fake BuildContext for mocktail
class FakeBuildContext extends Fake implements BuildContext {}

// Mock PlatformBottomBar using mocktail
class MockPlatformBottomBar extends Mock implements PlatformBottomBar {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockPlatformBottomBar';
  }
}

void main() {
  late MockPlatformBottomBar mockBottomBar;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    mockBottomBar = MockPlatformBottomBar();
    when(() => mockBottomBar.createCupertinoWidget(any())).thenReturn(
      CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  });

  testWidgets('createCupertinoWidget returns CupertinoTabScaffold',
      (tester) async {
    final widget = PlatformTabScaffold(
      index: 0,
      body: const Text('Body'),
      bottomBar: mockBottomBar,
      tabBuilder: (context, index) => Text('Tab $index'),
    );

    final cupertinoWidget = widget.createCupertinoWidget(FakeBuildContext());

    expect(cupertinoWidget, isA<CupertinoTabScaffold>());
    expect(cupertinoWidget.tabBar, isA<CupertinoTabBar>());
    expect(cupertinoWidget.tabBar.items.length, 2);
    expect(cupertinoWidget.tabBar.items[0].label, 'Home');
  });

  testWidgets('createMaterialWidget returns Scaffold', (tester) async {
    final widget = PlatformTabScaffold(
      index: 0,
      body: const Text('Material Body'),
      bottomBar: mockBottomBar,
      tabBuilder: (context, index) => Text('Tab $index'),
    );

    final materialWidget = widget.createMaterialWidget(FakeBuildContext());

    expect(materialWidget, isA<Scaffold>());
    expect(materialWidget.body, isA<Text>());
    expect((materialWidget.body! as Text).data, 'Material Body');
    expect(materialWidget.bottomNavigationBar, mockBottomBar);
  });
}
