import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  group('FeedbackStatus', () {
    test('idle is not submitting', () {
      expect(const FeedbackIdle().isSubmitting, isFalse);
    });

    test('submitting reports isSubmitting', () {
      expect(const FeedbackSubmitting().isSubmitting, isTrue);
    });

    test('success carries a result', () {
      const FeedbackStatus status = FeedbackSuccess(
        FeedbackResult(issueId: 'ABC-1'),
      );
      expect(status, isA<FeedbackSuccess>());
      expect((status as FeedbackSuccess).result.issueId, 'ABC-1');
    });

    test('failure carries the error', () {
      const FeedbackStatus status = FeedbackFailure(FeedbackException('boom'));
      expect(status, isA<FeedbackFailure>());
      expect((status as FeedbackFailure).error, isA<FeedbackException>());
    });
  });
}
