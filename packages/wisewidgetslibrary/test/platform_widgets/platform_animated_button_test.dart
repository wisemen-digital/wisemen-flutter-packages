import 'package:fake_async/fake_async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  testWidgets('PlatformAnimatedButton shows child when not loading', (
    WidgetTester tester,
  ) async {
    const child = Text('Button');
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlatformAnimatedButton(
            child: child,
          ),
        ),
      ),
    );

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Button'), findsOneWidget);
  });

  testWidgets('PlatformAnimatedButton shows loading indicator when loading', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlatformAnimatedButton(
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('PlatformAnimatedButton is disabled when isDisabled is true', (
    WidgetTester tester,
  ) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformAnimatedButton(
            isDisabled: true,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PlatformAnimatedButton));
    expect(pressed, isFalse);
  });

  testWidgets('PlatformAnimatedButton calls onPressed when tapped', (
    WidgetTester tester,
  ) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformAnimatedButton(
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    fakeAsync((async) {
      tester.tap(find.byType(PlatformAnimatedButton));
      async.elapse(const Duration(milliseconds: 10));
      expect(pressed, isTrue);
    });
  });

  testWidgets(
    'PlatformAnimatedButton expands to full width when expand is true',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlatformAnimatedButton(),
          ),
        ),
      );

      final button = tester.widget<PlatformAnimatedButton>(
        find.byType(PlatformAnimatedButton),
      );
      expect(button.expand, isTrue);
    },
  );

  testWidgets(
    'PlatformAnimatedButton shows child when not loading (Cupertino)',
    (WidgetTester tester) async {
      const child = Text('Button');
      await tester.pumpWidget(
        const CupertinoApp(
          home: Scaffold(
            body: PlatformAnimatedButton(
              child: child,
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Button'), findsOneWidget);
    },
  );

  testWidgets(
    'PlatformAnimatedButton is disabled when isDisabled is true (Cupertino)',
    (WidgetTester tester) async {
      var pressed = false;
      final animatedButton = PlatformAnimatedButton(
        isDisabled: true,
        onPressed: () {
          pressed = true;
        },
      );
      await tester.pumpWidget(
        CupertinoApp(
          home: Scaffold(
            body: Builder(
              builder: animatedButton.createCupertinoWidget,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CupertinoButton));
      expect(pressed, isFalse);
    },
  );

  testWidgets(
    'PlatformAnimatedButton calls onPressed when tapped (Cupertino)',
    (WidgetTester tester) async {
      var pressed = false;
      final animatedButton = PlatformAnimatedButton(
        onPressed: () {
          pressed = true;
        },
      );

      await tester.pumpWidget(
        CupertinoApp(
          home: Scaffold(
            body: Builder(
              builder: animatedButton.createCupertinoWidget,
            ),
          ),
        ),
      );

      fakeAsync((async) {
        tester.tap(find.byType(CupertinoButton));
        async.elapse(const Duration(milliseconds: 10));
        expect(pressed, isTrue);
      });
    },
  );

  testWidgets(
    'PlatformAnimatedButton displays loading indicator when loading (cupertino)',
    (WidgetTester tester) async {
      const animatedButton = PlatformAnimatedButton(isLoading: true);

      await tester.pumpWidget(
        CupertinoApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return animatedButton.createCupertinoWidget(context);
              },
            ),
          ),
        ),
      );

      final cupertinoWidget = tester.widget<CupertinoButton>(
        find.byType(CupertinoButton),
      );
      expect(cupertinoWidget, isA<CupertinoButton>());
      expect(find.byType(PlatformLoadingIndicator), findsOneWidget);
    },
  );

  testWidgets('PlatformAnimatedButton calls onpressed (cupertino)', (
    WidgetTester tester,
  ) async {
    const animatedButton = PlatformAnimatedButton(isLoading: true);

    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return animatedButton.createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    final cupertinoWidget = tester.widget<CupertinoButton>(
      find.byType(CupertinoButton),
    );
    expect(cupertinoWidget, isA<CupertinoButton>());
    expect(find.byType(PlatformLoadingIndicator), findsOneWidget);
  });
}
