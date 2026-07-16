import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

const _fields = [FeedbackField(key: 'description', label: 'Description')];

void main() {
  group('FeedbackForm', () {
    testWidgets('submitting forwards the title and field values',
        (tester) async {
      Map<String, dynamic>? gotExtras;
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.idle);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              fields: _fields,
              onSubmit: (description, {extras}) async {
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
        find.byKey(const Key('wise_feedback_field_description')),
        'My description',
      );
      await tester.tap(find.byKey(const Key('wise_feedback_submit')));
      await tester.pump();

      expect(gotExtras?['title'], 'My title');
      final fields = gotExtras?['fields'] as Map<String, String>;
      expect(fields['description'], 'My description');
    });

    testWidgets('shows a progress indicator while submitting', (tester) async {
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.submitting);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              fields: _fields,
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
              fields: _fields,
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

    testWidgets('renders a field per template field', (tester) async {
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.idle);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              fields: const [
                FeedbackField(key: 'currentSituation', label: 'Current'),
                FeedbackField(key: 'desiredSituation', label: 'Desired'),
              ],
              onSubmit: (description, {extras}) async {},
            ),
          ),
        ),
      );
      expect(
        find.byKey(const Key('wise_feedback_field_currentSituation')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('wise_feedback_field_desiredSituation')),
        findsOneWidget,
      );
    });

    testWidgets('forwards selected priority and category in extras',
        (tester) async {
      Map<String, dynamic>? gotExtras;
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.idle);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              fields: _fields,
              showPriority: true,
              categories: const ['Bug', 'Idea'],
              onSubmit: (description, {extras}) async {
                gotExtras = extras;
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
      final status = ValueNotifier<FeedbackStatus>(FeedbackStatus.idle);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(
              theme: const WiseFeedbackTheme(),
              status: status,
              fields: _fields,
              onSubmit: (description, {extras}) async {},
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
                  fields: _fields,
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
