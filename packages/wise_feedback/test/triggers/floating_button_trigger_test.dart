import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';
import '../support/fake_transport.dart';

void main() {
  group('FloatingButtonTrigger', () {
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

    testWidgets(
        'renders and fires when mounted above the app '
        '(no MaterialApp/Directionality ancestor)', (tester) async {
      final controller = FeedbackController(FakeTransport());
      var shown = 0;
      controller.bindShow(() => shown++);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: Builder(
            builder: (context) => const FloatingButtonTrigger()
                .wrap(context, controller, const SizedBox.expand()),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      await tester.tap(find.byKey(const Key('wise_feedback_fab')));
      await tester.pump();
      expect(shown, 1);
    });

    testWidgets('hides the button while the feedback sheet is open',
        (tester) async {
      final controller = FeedbackController(FakeTransport());

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

      expect(find.byKey(const Key('wise_feedback_fab')), findsOneWidget);

      controller.isVisible.value = true;
      await tester.pump();
      expect(find.byKey(const Key('wise_feedback_fab')), findsNothing);

      controller.isVisible.value = false;
      await tester.pump();
      expect(find.byKey(const Key('wise_feedback_fab')), findsOneWidget);
    });
  });
}
