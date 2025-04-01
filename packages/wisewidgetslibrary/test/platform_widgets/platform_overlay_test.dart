import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_overlay.dart';

void main() {
  testWidgets('displays children widgets', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomOverlay(
          close: () {},
          children: const [
            Text('Child 1'),
            Text('Child 2'),
          ],
        ),
      ),
    );

    expect(find.text('Child 1'), findsOneWidget);
    expect(find.text('Child 2'), findsOneWidget);
  });

  testWidgets('calls close callback when tapped', (tester) async {
    var isClosed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CustomOverlay(
          close: () {
            isClosed = true;
          },
          children: const [
            Text('Child 1'),
            Text('Child 2'),
          ],
        ),
      ),
    );

    await tester.tap(find.byType(BackdropFilter));
    await tester.pumpAndSettle();

    expect(isClosed, isTrue);
  });
}
