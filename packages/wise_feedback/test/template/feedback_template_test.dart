import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  group('DefaultFeedbackTemplate', () {
    const template = DefaultFeedbackTemplate();

    test('exposes a single description field', () {
      expect(template.fields, hasLength(1));
      expect(template.fields.single.key, 'description');
    });

    test('renders description plus a context section', () {
      final body = template.buildBody(
        fields: const {'description': 'It broke'},
        metadata: const {
          'appVersion': '1.2.3',
          FeedbackReport.navigationKey: ['/a', '/b'],
        },
        reporter: const FeedbackReporter(email: 'a@b.c'),
        category: 'Bug',
        priority: FeedbackPriority.high,
      );
      expect(body, startsWith('It broke'));
      expect(body, contains('## Context'));
      expect(body, contains('**Reported by:** a@b.c'));
      expect(body, contains('**Category:** Bug'));
      expect(body, contains('**Priority:** High'));
      expect(body, contains('appVersion'));
      expect(body, contains('**Recent screens:** /a → /b'));
    });

    test('omits the breadcrumb line when no trail was recorded', () {
      final body = template.buildBody(
        fields: const {'description': 'It broke'},
        metadata: const {'appVersion': '1.2.3'},
      );
      expect(body, isNot(contains('Recent screens')));
    });
  });

  group('BugReportTemplate', () {
    const template = BugReportTemplate();

    test('exposes current and desired situation fields', () {
      expect(template.fields.map((f) => f.key), [
        'currentSituation',
        'desiredSituation',
      ]);
    });

    test('renders the bug template sections', () {
      final body = template.buildBody(
        fields: const {
          'currentSituation': 'I get an error',
          'desiredSituation': 'It works',
        },
        metadata: const {
          'environment': 'staging',
          FeedbackReport.navigationKey: ['Overview', 'Detail', 'Delete'],
        },
        reporter: const FeedbackReporter(email: 'john.doe@wisemen.digital'),
        createdAt: DateTime(2025, 9, 9, 14),
      );

      expect(body, contains('## Current Situation\nI get an error'));
      expect(body, contains('## Desired Situation\nIt works'));
      expect(body, contains('## Steps to Reproduce'));
      expect(body, contains('1. Overview'));
      expect(body, contains('2. Detail'));
      expect(body, contains('3. Delete'));
      expect(body, contains('Environment or url: staging'));
      expect(body, contains('Account or user: john.doe@wisemen.digital'));
      expect(body, contains('Date & Time: 2025-09-09 14:00'));
    });

    test('renders the timestamp with a custom date pattern', () {
      const custom = BugReportTemplate(datePattern: 'dd/MM/yyyy HH:mm:ss');
      final body = custom.buildBody(
        fields: const {},
        metadata: const {},
        createdAt: DateTime(2025, 9, 9, 14, 5, 30),
      );
      expect(body, contains('Date & Time: 09/09/2025 14:05:30'));
    });

    test('leaves the timestamp empty when createdAt is absent', () {
      final body = template.buildBody(fields: const {}, metadata: const {});
      // buildBody trims the trailing whitespace off the empty value.
      expect(body, endsWith('Date & Time:'));
    });

    test('falls back gracefully when navigation is absent', () {
      final body = template.buildBody(fields: const {}, metadata: const {});
      expect(body, contains('_No navigation recorded._'));
    });

    test('keeps a route name containing the separator as one step', () {
      final body = template.buildBody(
        fields: const {},
        metadata: const {
          FeedbackReport.navigationKey: ['Overview → Detail', 'Delete'],
        },
      );
      expect(body, contains('1. Overview → Detail'));
      expect(body, contains('2. Delete'));
      expect(body, isNot(contains('3.')));
    });
  });
}
