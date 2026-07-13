import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  group('FeedbackButton', () {
    testWidgets('tapping calls onPressed', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackButton(onPressed: () => taps++),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('wise_feedback_fab')));
      await tester.pump();
      expect(taps, 1);
    });

    testWidgets('renders with no MaterialApp/Directionality ancestor',
        (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: FeedbackButton(onPressed: () => taps++),
        ),
      );
      expect(tester.takeException(), isNull);
      await tester.tap(find.byKey(const Key('wise_feedback_fab')));
      await tester.pump();
      expect(taps, 1);
    });
  });
}
