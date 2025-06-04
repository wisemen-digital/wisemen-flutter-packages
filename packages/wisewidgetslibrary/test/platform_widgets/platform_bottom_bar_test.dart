import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  testWidgets('createCupertinoWidget creates CupertinoTabBar', (
    WidgetTester tester,
  ) async {
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ];

    await tester.pumpWidget(
      CupertinoApp(
        home: Builder(
          builder: (BuildContext context) {
            return PlatformBottomBar(
              items: items,
              onTap: (index) {},
              currentIndex: 0,
              inActiveColor: CupertinoColors.inactiveGray,
            ).createCupertinoWidget(context);
          },
        ),
      ),
    );

    final cupertinoTabBar = tester.widget<CupertinoTabBar>(
      find.byType(CupertinoTabBar),
    );
    expect(cupertinoTabBar.items.length, 2);
    expect(cupertinoTabBar.currentIndex, 0);
    expect(cupertinoTabBar.inactiveColor, CupertinoColors.inactiveGray);
  });

  testWidgets('createMaterialWidget creates BottomNavigationBar', (
    WidgetTester tester,
  ) async {
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return PlatformBottomBar(
                items: items,
                onTap: (index) {},
                currentIndex: 0,
                inActiveColor: Colors.grey,
                activeColor: Colors.blue,
              ).createMaterialWidget(context);
            },
          ),
        ),
      ),
    );

    final bottomNavigationBar = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(bottomNavigationBar.items.length, 2);
    expect(bottomNavigationBar.currentIndex, 0);
    expect(bottomNavigationBar.unselectedItemColor, Colors.grey);
    expect(bottomNavigationBar.selectedItemColor, Colors.blue);
    expect(bottomNavigationBar.selectedFontSize, 14.0);
    expect(bottomNavigationBar.unselectedFontSize, 12.0);
    expect(bottomNavigationBar.backgroundColor, Colors.white);
  });

  testWidgets('PlatformBottomBar calls onTap when tapped', (
    WidgetTester tester,
  ) async {
    var tappedIndex = -1;
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformBottomBar(
            items: items,
            onTap: (index) {
              tappedIndex = index;
            },
            currentIndex: 0,
            inActiveColor: Colors.grey,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Settings'));
    expect(tappedIndex, 1);
  });
}
