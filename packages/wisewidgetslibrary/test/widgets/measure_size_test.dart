import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/widgets/measure_size.dart';

void main() {
  testWidgets('measures initial size of the widget', (tester) async {
    Size? measuredSize;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MeasureSize(
            onChange: (size) {
              measuredSize = size;
            },
            child: const SizedBox(width: 100, height: 100),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(measuredSize, const Size(100, 100));
  });

  testWidgets('detects size changes of the widget', (tester) async {
    Size? measuredSize;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MeasureSize(
            onChange: (size) {
              measuredSize = size;
            },
            child: const SizedBox(width: 100, height: 100),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(measuredSize, const Size(100, 100));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MeasureSize(
            onChange: (size) {
              measuredSize = size;
            },
            child: const SizedBox(width: 200, height: 200),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(measuredSize, const Size(200, 200));
  });
}
