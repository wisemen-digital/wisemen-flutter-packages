import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  testWidgets('PlatformAnimatedButton shows child when not loading', (WidgetTester tester) async {
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

  testWidgets('PlatformAnimatedButton shows loading indicator when loading', (WidgetTester tester) async {
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

  testWidgets('PlatformAnimatedButton is disabled when isDisabled is true', (WidgetTester tester) async {
    bool pressed = false;
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

  testWidgets('PlatformAnimatedButton calls onPressed when tapped', (WidgetTester tester) async {
    bool pressed = false;
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

  testWidgets('PlatformAnimatedButton expands to full width when expand is true', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlatformAnimatedButton(
            expand: true,
          ),
        ),
      ),
    );

    final button = tester.widget<PlatformAnimatedButton>(find.byType(PlatformAnimatedButton));
    expect(button.expand, isTrue);
  });
}