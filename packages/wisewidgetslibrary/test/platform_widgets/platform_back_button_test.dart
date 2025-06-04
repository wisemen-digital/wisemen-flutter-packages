import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  testWidgets(
    'createCupertinoWidget creates CupertinoNavigationBarBackButton',
    (WidgetTester tester) async {
      const backButton = PlatformBackButton(
        previousPageTitle: 'Custom',
        color: Colors.red,
      );

      await tester.pumpWidget(
        CupertinoApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return backButton.createCupertinoWidget(context);
              },
            ),
          ),
        ),
      );

      final cupertinoWidget = tester.widget<CupertinoNavigationBarBackButton>(
        find.byType(CupertinoNavigationBarBackButton),
      );
      expect(cupertinoWidget.previousPageTitle, 'Custom');
      expect(cupertinoWidget.color, Colors.red);
    },
  );

  testWidgets('createMaterialWidget creates correct IconButton', (
    WidgetTester tester,
  ) async {
    const backButton = PlatformBackButton(
      color: Colors.red,
      iconSize: 30,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return backButton.createMaterialWidget(context);
            },
          ),
        ),
      ),
    );

    final iconButtons = find.byType(IconButton);
    expect(iconButtons, findsOneWidget);

    final iconButton = tester.widget<IconButton>(iconButtons);
    expect(iconButton.icon, isA<Icon>());
    final icon = iconButton.icon as Icon;
    expect(icon.icon, Icons.arrow_back_rounded);
    expect(icon.color, Colors.red);
    expect(icon.size, 30);
  });

  testWidgets('PlatformBackButton calls onPressed when tapped', (
    WidgetTester tester,
  ) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformBackButton(
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PlatformBackButton));
    expect(pressed, isTrue);
  });

  testWidgets('PlatformBackButton uses default onPressed when not provided', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlatformBackButton(),
        ),
      ),
    );

    await tester.tap(find.byType(PlatformBackButton));
    // No assertion here, just ensuring no exceptions are thrown
  });
}
