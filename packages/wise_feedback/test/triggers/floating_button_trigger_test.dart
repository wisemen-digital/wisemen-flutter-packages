import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';
import '../support/fake_transport.dart';

void main() {
  testWidgets('tapping the floating button calls controller.show',
      (tester) async {
    final controller = FeedbackController(FakeTransport());
    var shown = 0;
    controller.bindShow(() => shown++);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => const FloatingButtonTrigger()
                .wrap(context, controller, const Placeholder()),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('wise_feedback_fab')));
    await tester.pump();
    expect(shown, 1);
  });
}
