import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';
import '../support/fake_transport.dart';

void main() {
  group('LinearFeedback', () {
    testWidgets('of(context) returns the controller and show opens the form',
        (tester) async {
      // BetterFeedback's default sheet is draggable and opens at 25% of the
      // screen height. The default 800x600 test surface is too short for our
      // two-field form to fit without dragging, so use a taller surface.
      tester.view.physicalSize = const Size(1200, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final transport =
          FakeTransport(result: const FeedbackResult(issueId: 'E2E-1'));

      await tester.pumpWidget(
        LinearFeedback(
          transport: transport,
          triggers: const [FloatingButtonTrigger()],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  key: const Key('open'),
                  onPressed: () => LinearFeedback.of(context).show(),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );

      // Programmatic open via of(context).show()
      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();

      // The built-in form fields are visible.
      expect(find.byKey(const Key('wise_feedback_title')), findsOneWidget);
      expect(
        find.byKey(const Key('wise_feedback_description')),
        findsOneWidget,
      );

      // Fill and submit.
      await tester.enterText(
        find.byKey(const Key('wise_feedback_title')),
        'E2E title',
      );
      await tester.enterText(
        find.byKey(const Key('wise_feedback_description')),
        'E2E desc',
      );
      await tester.tap(find.byKey(const Key('wise_feedback_submit')));
      // `feedback`'s screenshot capture uses RenderRepaintBoundary.toImage(),
      // which completes on a real engine callback rather than a fake timer, so
      // pumpAndSettle() alone never observes it. Drive real pumps inside
      // runAsync() until the submission's Future resolves.
      await tester.runAsync(() async {
        for (var i = 0; i < 20; i++) {
          await tester.pump(const Duration(milliseconds: 100));
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
      });

      // The transport received a mapped report.
      expect(transport.sent, hasLength(1));
      expect(transport.sent.single.title, 'E2E title');
      expect(transport.sent.single.description, 'E2E desc');
      expect(transport.sent.single.screenshotPng, isNotEmpty);
    });

    testWidgets('keeps the sheet open and shows the error when submit fails',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final transport = FakeTransport(
        throwError: const FeedbackException('Could not authenticate.'),
      );

      await tester.pumpWidget(
        LinearFeedback(
          transport: transport,
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  key: const Key('open'),
                  onPressed: () => LinearFeedback.of(context).show(),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('wise_feedback_description')),
        'broken',
      );
      await tester.tap(find.byKey(const Key('wise_feedback_submit')));
      await tester.runAsync(() async {
        for (var i = 0; i < 20; i++) {
          await tester.pump(const Duration(milliseconds: 100));
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
      });
      await tester.pump();

      // Submission was attempted, but the sheet stayed open and shows the error.
      expect(transport.sent, hasLength(1));
      expect(find.byKey(const Key('wise_feedback_submit')), findsOneWidget);
      expect(find.byKey(const Key('wise_feedback_error')), findsOneWidget);
      expect(find.text('Could not authenticate.'), findsWidgets);
    });
  });
}
