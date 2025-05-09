import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  //* Material
  testWidgets('PlatformButton2 displays text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton2.text(
            text: 'Press Me',
            textStyle: const TextStyle(),
            color: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Press Me'), findsOneWidget);
  });

  testWidgets('PlatformButton2 calls onPressed when tapped',
      (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton2.text(
            text: 'Press Me',
            textStyle: const TextStyle(),
            color: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Press Me'));
    expect(pressed, isTrue);
  });

  testWidgets('PlatformButton2 is disabled when isDisabled is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton2.text(
            text: 'Press Me',
            textStyle: const TextStyle(),
            color: Colors.blue,
            foregroundColor: Colors.white,
            isDisabled: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    final button = tester.widget<PlatformButton2>(find.byType(PlatformButton2));
    expect(button.isDisabled, isTrue);
  });

  testWidgets('PlatformButton2 shows loading indicator when isLoading is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton2.text(
            text: 'Press Me',
            textStyle: const TextStyle(),
            color: Colors.blue,
            foregroundColor: Colors.white,
            isLoading: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('PlatformButton2 does not call onPressed when disabled',
      (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton2.text(
            text: 'Press Me',
            textStyle: const TextStyle(),
            color: Colors.blue,
            foregroundColor: Colors.white,
            isDisabled: true,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Press Me'));
    expect(pressed, isFalse);
  });

  //* Cupertino
  testWidgets('PlatformButton2 displays text on ios',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return PlatformButton2.text(
                text: 'Press Me',
                textStyle: const TextStyle(),
                color: Colors.blue,
                foregroundColor: Colors.white,
                onPressed: () {},
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    expect(find.text('Press Me'), findsOneWidget);
  });

  testWidgets('PlatformButton2 calls onPressed when tapped on ios',
      (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return PlatformButton2(
                color: Colors.blue,
                foregroundColor: Colors.white,
                onPressed: () {
                  pressed = true;
                },
                child: const Text('Press Me'),
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Press Me'));
    expect(pressed, isTrue);
  });

  testWidgets('PlatformButton2 is disabled when isDisabled is true on ios',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return PlatformButton2.text(
                text: 'Press Me',
                textStyle: const TextStyle(),
                color: Colors.blue,
                foregroundColor: Colors.white,
                onPressed: () {},
                isDisabled: true,
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    final button = tester.widget<CupertinoButton>(find.byType(CupertinoButton));
    expect(button.onPressed, isNull);
  });

  testWidgets(
      'PlatformButton2 shows loading indicator when isLoading is true on ios',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return PlatformButton2.text(
                text: 'Press Me',
                textStyle: const TextStyle(),
                color: Colors.blue,
                foregroundColor: Colors.white,
                onPressed: () {},
                isLoading: true,
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });

  testWidgets('PlatformButton2 does not call onPressed when disabled on ios',
      (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return PlatformButton2.text(
                text: 'Press Me',
                textStyle: const TextStyle(),
                color: Colors.blue,
                foregroundColor: Colors.white,
                onPressed: () {
                  pressed = true;
                },
                isDisabled: true,
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Press Me'));
    expect(pressed, isFalse);
  });
}
