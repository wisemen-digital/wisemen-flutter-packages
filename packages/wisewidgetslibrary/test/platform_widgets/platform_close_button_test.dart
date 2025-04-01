import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  testWidgets('PlatformCloseButton displays custom title on iOS',
      (WidgetTester tester) async {
    const closeButton = PlatformCloseButton(
      title: 'Custom',
    );

    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return closeButton.createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    final cupertinoWidget =
        tester.widget<CupertinoButton>(find.byType(CupertinoButton));
    expect(cupertinoWidget, isA<CupertinoButton>());
    expect(find.text('Custom'), findsOneWidget);
    expect(cupertinoWidget.color, Colors.transparent);
  });

  testWidgets('PlatformCloseButton displays icon on Android',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlatformCloseButton(),
        ),
      ),
    );

    expect(find.byIcon(Icons.close_rounded), findsOneWidget);
  });

  testWidgets('PlatformCloseButton calls onPressed when tapped on iOS',
      (WidgetTester tester) async {
    var pressed = false;

    final closeButton = PlatformCloseButton(
      onPressed: () {
        pressed = true;
      },
    );

    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: closeButton.createCupertinoWidget,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Close'));
    expect(pressed, isTrue);
  });

  testWidgets('PlatformCloseButton calls onPressed when tapped on Android',
      (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformCloseButton(
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.close_rounded));
    expect(pressed, isTrue);
  });

  testWidgets(
      'PlatformCloseButton uses default onPressed when not provided on iOS',
      (WidgetTester tester) async {
    const closeButton = PlatformCloseButton();

    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return closeButton.createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    expect(find.text('Close'), findsOneWidget);
  });

  testWidgets(
      'PlatformCloseButton stays transparent even if color is provided for iOS',
      (WidgetTester tester) async {
    const closeButton = PlatformCloseButton(
      color: Colors.red,
    );

    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return closeButton.createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    final cupertinoWidget =
        tester.widget<CupertinoButton>(find.byType(CupertinoButton));
    expect(cupertinoWidget.color, Colors.transparent);
  });

  testWidgets(
      'PlatformCloseButton uses default onPressed when not provided on Android',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlatformCloseButton(),
        ),
      ),
    );

    expect(find.byIcon(Icons.close_rounded), findsOneWidget);
  });
}
