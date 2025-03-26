import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/widgets/animated_numbers_mapped.dart';

void main() {
  testWidgets('AnimatedNumbersMapped animates to new values',
      (WidgetTester tester) async {
    var animatedValues = <String, double>{'a': 0.0, 'b': 0.0};

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbersMapped(
          numbers: const {'a': 10, 'b': 20},
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.entries
                  .map((entry) => Text('${entry.key}: ${entry.value}'))
                  .toList(),
            );
          },
        ),
      ),
    );

    expect(animatedValues, {'a': 10.0, 'b': 20.0});

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbersMapped(
          numbers: const {'a': 30, 'b': 40},
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.entries
                  .map((entry) => Text('${entry.key}: ${entry.value}'))
                  .toList(),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(animatedValues, {'a': 30.0, 'b': 40.0});
  });

  testWidgets('AnimatedNumbersMapped respects custom duration and curve',
      (WidgetTester tester) async {
    var animatedValues = <String, double>{'a': 0.0, 'b': 0.0};

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbersMapped(
          numbers: const {'a': 10, 'b': 20},
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.entries
                  .map((entry) => Text('${entry.key}: ${entry.value}'))
                  .toList(),
            );
          },
        ),
      ),
    );

    expect(animatedValues, {'a': 10.0, 'b': 20.0});

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbersMapped(
          numbers: const {'a': 30, 'b': 40},
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.entries
                  .map((entry) => Text('${entry.key}: ${entry.value}'))
                  .toList(),
            );
          },
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 250));
    expect(animatedValues['a'], greaterThan(10.0));
    expect(animatedValues['a'], lessThan(30.0));
    expect(animatedValues['b'], greaterThan(20.0));
    expect(animatedValues['b'], lessThan(40.0));

    await tester.pumpAndSettle();
    expect(animatedValues, {'a': 30.0, 'b': 40.0});
  });

  testWidgets('AnimatedNumbersMapped updates widget correctly',
      (WidgetTester tester) async {
    var animatedValues = <String, double>{'a': 0.0, 'b': 0.0};

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbersMapped(
          numbers: const {'a': 10, 'b': 20},
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.entries
                  .map((entry) => Text('${entry.key}: ${entry.value}'))
                  .toList(),
            );
          },
        ),
      ),
    );

    expect(animatedValues, {'a': 10.0, 'b': 20.0});

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedNumbersMapped(
          numbers: const {'a': 15, 'b': 25},
          child: (values) {
            animatedValues = values;
            return Column(
              children: values.entries
                  .map((entry) => Text('${entry.key}: ${entry.value}'))
                  .toList(),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(animatedValues, {'a': 15.0, 'b': 25.0});
  });
}
