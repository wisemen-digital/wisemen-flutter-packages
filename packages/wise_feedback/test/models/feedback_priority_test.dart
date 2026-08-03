import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  group('FeedbackPriority', () {
    test('maps to the Linear priority scale', () {
      expect(FeedbackPriority.none.linearValue, 0);
      expect(FeedbackPriority.urgent.linearValue, 1);
      expect(FeedbackPriority.high.linearValue, 2);
      expect(FeedbackPriority.medium.linearValue, 3);
      expect(FeedbackPriority.low.linearValue, 4);
    });

    test('exposes a human-readable label', () {
      expect(FeedbackPriority.high.label, 'High');
    });
  });

  group('FeedbackReporter', () {
    test('isEmpty reflects whether any field is set', () {
      expect(const FeedbackReporter().isEmpty, isTrue);
      expect(const FeedbackReporter(email: 'a@b.c').isEmpty, isFalse);
      expect(const FeedbackReporter(name: 'Ann').isEmpty, isFalse);
    });
  });
}
