import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/widgets/animated_numbers.dart';

void main() {
  testWidgets('AnimatedNumbers animates to new values',
      (WidgetTester tester) async {
    var animatedValues = <double>[0, 0];

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbers(
          numbers: const [10.0, 20.0],
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.map((value) => Text(value.toString())).toList(),
            );
          },
        ),
      ),
    );

    expect(animatedValues, [10.0, 20.0]);

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbers(
          numbers: const [30.0, 40.0],
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.map((value) => Text(value.toString())).toList(),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(animatedValues, [30.0, 40.0]);
  });

  testWidgets('AnimatedNumbers respects custom duration and curve',
      (WidgetTester tester) async {
    var animatedValues = <double>[0, 0];

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbers(
          numbers: const [10.0, 20.0],
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.map((value) => Text(value.toString())).toList(),
            );
          },
        ),
      ),
    );

    expect(animatedValues, [10.0, 20.0]);

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbers(
          numbers: const [30.0, 40.0],
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.map((value) => Text(value.toString())).toList(),
            );
          },
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 250));
    expect(animatedValues[0], greaterThan(10.0));
    expect(animatedValues[0], lessThan(30.0));
    expect(animatedValues[1], greaterThan(20.0));
    expect(animatedValues[1], lessThan(40.0));

    await tester.pumpAndSettle();
    expect(animatedValues, [30.0, 40.0]);
  });

  testWidgets('AnimatedNumbers updates widget correctly',
      (WidgetTester tester) async {
    var animatedValues = <double>[0, 0];

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbers(
          numbers: const [10.0, 20.0],
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.map((value) => Text(value.toString())).toList(),
            );
          },
        ),
      ),
    );

    expect(animatedValues, [10.0, 20.0]);

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbers(
          numbers: const [15.0, 25.0],
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.map((value) => Text(value.toString())).toList(),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(animatedValues, [15.0, 25.0]);
  });
}
