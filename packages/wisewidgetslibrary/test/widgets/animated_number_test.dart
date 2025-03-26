import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/widgets/animated_number.dart';

void main() {
  testWidgets('AnimatedNumber animates to new value',
      (WidgetTester tester) async {
    var animatedValue = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumber(
          number: 10,
          child: (value) {
            animatedValue = value;
            return Text(value.toString());
          },
        ),
      ),
    );

    expect(animatedValue, 10.0);

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumber(
          number: 20,
          child: (value) {
            animatedValue = value;
            return Text(value.toString());
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(animatedValue, 20.0);
  });

  testWidgets('AnimatedNumber respects custom duration and curve',
      (WidgetTester tester) async {
    var animatedValue = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumber(
          number: 10,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: (value) {
            animatedValue = value;
            return Text(value.toString());
          },
        ),
      ),
    );

    expect(animatedValue, 10.0);

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumber(
          number: 20,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: (value) {
            animatedValue = value;
            return Text(value.toString());
          },
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 250));
    expect(animatedValue, greaterThan(10.0));
    expect(animatedValue, lessThan(20.0));

    await tester.pumpAndSettle();
    expect(animatedValue, 20.0);
  });

  testWidgets('AnimatedNumber updates widget correctly',
      (WidgetTester tester) async {
    var animatedValue = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumber(
          number: 10,
          child: (value) {
            animatedValue = value;
            return Text(value.toString());
          },
        ),
      ),
    );

    expect(animatedValue, 10.0);

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumber(
          number: 15,
          child: (value) {
            animatedValue = value;
            return Text(value.toString());
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(animatedValue, 15.0);
  });
}
