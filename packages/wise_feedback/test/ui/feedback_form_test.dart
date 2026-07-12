import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  group('FeedbackForm', () {
    testWidgets('submitting the form forwards title and description',
        (tester) async {
      String? gotDescription;
      Map<String, dynamic>? gotExtras;
      final status = ValueNotifier<FeedbackStatus>(const FeedbackStatus.idle());

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
      final status =
          ValueNotifier<FeedbackStatus>(const FeedbackStatus.submitting());
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
  });
}
