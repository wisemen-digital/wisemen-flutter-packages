import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/widgets/true_center_column.dart';

void main() {
  testWidgets('renders both children', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TrueCenterColumn(
            firstChild: Text('First Child'),
            secondChild: Text('Second Child'),
          ),
        ),
      ),
    );

    expect(find.text('First Child'), findsOneWidget);
    expect(find.text('Second Child'), findsOneWidget);
  });

  testWidgets('layout when lockedTop is true', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TrueCenterColumn(
            firstChild: Container(height: 100, color: Colors.red),
            secondChild: Container(height: 200, color: Colors.blue),
            lockedTop: true,
          ),
        ),
      ),
    );

    final firstChild = tester.getTopLeft(find.byType(Container).at(0));
    final secondChild = tester.getTopLeft(find.byType(Container).at(1));

    expect(firstChild.dy, 0);
    expect(secondChild.dy, greaterThan(firstChild.dy));
  });

  testWidgets('layout when lockedTop is false', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TrueCenterColumn(
            firstChild: Container(height: 100, color: Colors.red),
            secondChild: Container(height: 200, color: Colors.blue),
            lockedTop: false,
          ),
        ),
      ),
    );

    final firstChild = tester.getTopLeft(find.byType(Container).at(0));
    final secondChild = tester.getTopLeft(find.byType(Container).at(1));

    expect(firstChild.dy, 0);
    expect(secondChild.dy, greaterThan(firstChild.dy));
  });
}