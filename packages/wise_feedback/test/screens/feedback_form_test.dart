import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  group('FeedbackForm', () {
    testWidgets('submitting the form forwards title and description',
        (tester) async {
      String? gotDescription;
      Map<String, dynamic>? gotExtras;
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.idle);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              onSubmit: (description, {extras}) async {
                gotDescription = description;
                gotExtras = extras;
              },
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('wise_feedback_title')),
        'My title',
      );
      await tester.enterText(
        find.byKey(const Key('wise_feedback_description')),
        'My description',
      );
      await tester.tap(find.byKey(const Key('wise_feedback_submit')));
      await tester.pump();

      expect(gotDescription, 'My description');
      expect(gotExtras?['title'], 'My title');
    });

    testWidgets('shows a progress indicator while submitting', (tester) async {
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.submitting);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              onSubmit: (description, {extras}) async {},
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows the error inline when the status is a failure',
        (tester) async {
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.idle);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              onSubmit: (description, {extras}) async {},
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('wise_feedback_error')), findsNothing);

      status.value =
          const FeedbackStatus.failure(FeedbackException('Could not send it.'));
      await tester.pump();

      expect(find.byKey(const Key('wise_feedback_error')), findsOneWidget);
      expect(find.text('Could not send it.'), findsOneWidget);
      expect(find.byKey(const Key('wise_feedback_submit')), findsOneWidget);
    });

    testWidgets('forwards selected priority and category in extras',
        (tester) async {
      Map<String, dynamic>? gotExtras;
      final status = ValueNotifier<FeedbackStatus>(const FeedbackStatus.idle());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              showPriority: true,
              categories: const ['Bug', 'Idea'],
              onSubmit: (description, {extras}) async {
                gotExtras = extras;
                return null;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('wise_feedback_priority')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('High').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('wise_feedback_category')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Idea').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('wise_feedback_submit')));
      await tester.pump();

      expect(gotExtras?['priority'], 'high');
      expect(gotExtras?['category'], 'Idea');
    });

    testWidgets('hides priority and category by default', (tester) async {
      final status = ValueNotifier<FeedbackStatus>(const FeedbackStatus.idle());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              onSubmit: (description, {extras}) async => null,
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('wise_feedback_priority')), findsNothing);
      expect(find.byKey(const Key('wise_feedback_category')), findsNothing);
    });

    testWidgets('does not overflow in a short sheet with the keyboard open',
        (tester) async {
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.idle);
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              viewInsets: EdgeInsets.only(bottom: 300),
            ),
            child: Scaffold(
              body: SizedBox(
                height: 220,
                child: FeedbackForm(
                  theme: const WiseFeedbackTheme(),
                  status: status,
                  onSubmit: (description, {extras}) async {},
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
