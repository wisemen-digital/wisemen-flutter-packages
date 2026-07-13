import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

FeedbackReport _report({
  Map<String, String> fields = const {},
  Map<String, Object?> metadata = const {},
  FeedbackReporter? reporter,
  FeedbackPriority priority = FeedbackPriority.none,
  String? category,
  DateTime? createdAt,
}) =>
    FeedbackReport(
      title: 't',
      description: '',
      screenshotPng: Uint8List(0),
      fields: fields,
      metadata: metadata,
      reporter: reporter,
      priority: priority,
      category: category,
      createdAt: createdAt,
    );

void main() {
  group('DefaultFeedbackTemplate', () {
    const template = DefaultFeedbackTemplate();

    test('exposes a single description field', () {
      expect(template.fields, hasLength(1));
      expect(template.fields.single.key, 'description');
    });

    test('renders description plus a context section', () {
      final body = template.buildBody(
        _report(
          fields: const {'description': 'It broke'},
          reporter: const FeedbackReporter(email: 'a@b.c'),
          category: 'Bug',
          priority: FeedbackPriority.high,
          metadata: const {'appVersion': '1.2.3', 'navigation': '/a → /b'},
        ),
      );
      expect(body, startsWith('It broke'));
      expect(body, contains('## Context'));
      expect(body, contains('**Reported by:** a@b.c'));
      expect(body, contains('**Category:** Bug'));
      expect(body, contains('**Priority:** High'));
      expect(body, contains('appVersion'));
      expect(body, contains('**Recent screens:** /a → /b'));
    });
  });

  group('BugReportTemplate', () {
    const template = BugReportTemplate();

    test('exposes current and desired situation fields', () {
      expect(
        template.fields.map((f) => f.key),
        ['currentSituation', 'desiredSituation'],
      );
    });

    test('renders the bug template sections', () {
      final body = template.buildBody(
        _report(
          fields: const {
            'currentSituation': 'I get an error',
            'desiredSituation': 'It works',
          },
          reporter: const FeedbackReporter(email: 'john.doe@wisemen.digital'),
          metadata: const {
            'environment': 'staging',
            'navigation': 'Overview → Detail → Delete',
          },
          createdAt: DateTime(2025, 9, 9, 14),
        ),
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

    test('falls back gracefully when navigation is absent', () {
      final body = template.buildBody(_report());
      expect(body, contains('_No navigation recorded._'));
    });
  });
}
