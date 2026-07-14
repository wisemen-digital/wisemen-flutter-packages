import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';
import '../support/fake_transport.dart';

class _FakeCollector implements MetadataCollector {
  @override
  Future<Map<String, String>> collect() async =>
      {'platform': 'test', 'appVersion': '9.9'};
}

Route<void> _route(String name) => PageRouteBuilder<void>(
      settings: RouteSettings(name: name),
      pageBuilder: (_, __, ___) => const SizedBox(),
    );

void main() {
  group('WiseFeedback', () {
    testWidgets('the built-in button opens the form and submits',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final transport =
          FakeTransport(result: const FeedbackResult(issueId: 'E2E-1'));

      await tester.pumpWidget(
        WiseFeedback(
          transport: transport,
          child: const MaterialApp(home: Scaffold(body: SizedBox.expand())),
        ),
      );

      await tester.tap(find.byKey(const Key('wise_feedback_fab')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('wise_feedback_title')), findsOneWidget);
      expect(
        find.byKey(const Key('wise_feedback_field_description')),
        findsOneWidget,
      );

      await tester.enterText(
        find.byKey(const Key('wise_feedback_title')),
        'E2E title',
      );
      await tester.enterText(
        find.byKey(const Key('wise_feedback_field_description')),
        'E2E desc',
      );
      await tester.tap(find.byKey(const Key('wise_feedback_submit')));
      await tester.runAsync(() async {
        for (var i = 0; i < 20; i++) {
          await tester.pump(const Duration(milliseconds: 100));
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
      });

      expect(transport.sent, hasLength(1));
      expect(transport.sent.single.title, 'E2E title');
      expect(transport.sent.single.fields['description'], 'E2E desc');
      expect(transport.sent.single.description, contains('E2E desc'));
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
        WiseFeedback(
          transport: transport,
          child: const MaterialApp(home: Scaffold(body: SizedBox.expand())),
        ),
      );

      await tester.tap(find.byKey(const Key('wise_feedback_fab')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('wise_feedback_field_description')),
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

      expect(transport.sent, hasLength(1));
      expect(find.byKey(const Key('wise_feedback_submit')), findsOneWidget);
      expect(find.byKey(const Key('wise_feedback_error')), findsOneWidget);
      expect(find.text('Could not authenticate.'), findsWidgets);
    });

    testWidgets('hides the built-in button while the sheet is open',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        WiseFeedback(
          transport: FakeTransport(),
          child: const MaterialApp(home: Scaffold(body: SizedBox.expand())),
        ),
      );

      expect(find.byKey(const Key('wise_feedback_fab')), findsOneWidget);
      await tester.tap(find.byKey(const Key('wise_feedback_fab')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('wise_feedback_fab')), findsNothing);
    });

    testWidgets('shows the built-in button only when showButton is true',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        WiseFeedback(
          transport: FakeTransport(),
          child: const MaterialApp(home: Scaffold(body: SizedBox.expand())),
        ),
      );
      expect(find.byKey(const Key('wise_feedback_fab')), findsOneWidget);

      await tester.pumpWidget(
        WiseFeedback(
          showButton: false,
          transport: FakeTransport(),
          child: const MaterialApp(home: Scaffold(body: SizedBox.expand())),
        ),
      );
      expect(find.byKey(const Key('wise_feedback_fab')), findsNothing);
    });

    testWidgets('shows the success toast after a successful submit',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final transport =
          FakeTransport(result: const FeedbackResult(issueId: 'E2E-1'));

      await tester.pumpWidget(
        WiseFeedback(
          transport: transport,
          child: const MaterialApp(home: Scaffold(body: SizedBox.expand())),
        ),
      );

      await tester.tap(find.byKey(const Key('wise_feedback_fab')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('wise_feedback_field_description')),
        'E2E desc',
      );
      await tester.tap(find.byKey(const Key('wise_feedback_submit')));
      await tester.runAsync(() async {
        for (var i = 0; i < 20; i++) {
          await tester.pump(const Duration(milliseconds: 100));
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
      });

      expect(transport.sent, hasLength(1));
      expect(find.text('Bug reported. Thanks!'), findsWidgets);
    });

    testWidgets('attaches metadata, navigation and reporter to the report',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final transport = FakeTransport();
      final observer = WiseFeedbackNavigatorObserver()
        ..didPush(_route('/home'), null)
        ..didPush(_route('/settings'), null);

      await tester.pumpWidget(
        WiseFeedback(
          transport: transport,
          metadataCollector: _FakeCollector(),
          navigatorObserver: observer,
          reporter: () => const FeedbackReporter(email: 'me@x.com'),
          child: const MaterialApp(home: Scaffold(body: SizedBox.expand())),
        ),
      );

      await tester.tap(find.byKey(const Key('wise_feedback_fab')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('wise_feedback_field_description')),
        'ctx',
      );
      await tester.tap(find.byKey(const Key('wise_feedback_submit')));
      await tester.runAsync(() async {
        for (var i = 0; i < 20; i++) {
          await tester.pump(const Duration(milliseconds: 100));
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
      });

      final report = transport.sent.single;
      expect(report.metadata['platform'], 'test');
      expect(report.metadata['appVersion'], '9.9');
      expect(report.metadata['navigation'], '/home → /settings');
      expect(report.reporter?.email, 'me@x.com');
    });
  });
}
