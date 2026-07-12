import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  group('FeedbackStatus', () {
    test('idle is not submitting', () {
      expect(const FeedbackStatus.idle().isSubmitting, isFalse);
    });

    test('submitting reports isSubmitting', () {
      expect(const FeedbackStatus.submitting().isSubmitting, isTrue);
    });

    test('success carries a result', () {
      const status = FeedbackStatus.success(
        FeedbackResult(issueId: 'ABC-1'),
      );
      expect(status.state, FeedbackSubmissionState.success);
      expect(status.result?.issueId, 'ABC-1');
    });

    test('failure carries the error', () {
      const status = FeedbackStatus.failure(FeedbackException('boom'));
      expect(status.state, FeedbackSubmissionState.failure);
      expect(status.error, isA<FeedbackException>());
    });
  });
}
