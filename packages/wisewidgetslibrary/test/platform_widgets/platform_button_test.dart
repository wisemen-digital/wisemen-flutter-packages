import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  testWidgets('PlatformButton displays text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton(
            text: 'Press Me',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Press Me'), findsOneWidget);
  });

  testWidgets('PlatformButton calls onPressed when tapped', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton(
            text: 'Press Me',
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

  testWidgets('PlatformButton is disabled when isDisabled is true', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton(
            text: 'Press Me',
            isDisabled: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    final button = tester.widget<PlatformButton>(find.byType(PlatformButton));
    expect(button.isDisabled, isTrue);
  });

  testWidgets('PlatformButton shows loading indicator when isLoading is true', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton(
            text: 'Press Me',
            isLoading: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.byType(PlatformLoadingIndicator), findsOneWidget);
  });

  testWidgets('PlatformButton does not call onPressed when disabled', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformButton(
            text: 'Press Me',
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
}