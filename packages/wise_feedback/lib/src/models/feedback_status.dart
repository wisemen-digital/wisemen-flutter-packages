import 'feedback_result.dart';

/// Lifecycle state of a feedback submission, exposed via a `ValueListenable`.
///
/// A sealed hierarchy so consumers can exhaustively `switch` over the cases and
/// read case-specific data ([FeedbackSuccess.result], [FeedbackFailure.error])
/// without null-checks on fields that only apply to one state.
sealed class FeedbackStatus {
  const FeedbackStatus();

  /// Submission succeeded with [result].
  const factory FeedbackStatus.success(FeedbackResult result) = FeedbackSuccess;

  /// Submission failed with [error].
  const factory FeedbackStatus.failure(Object error) = FeedbackFailure;

  /// Nothing happening.
  static const FeedbackStatus idle = FeedbackIdle();

  /// A submission is in flight.
  static const FeedbackStatus submitting = FeedbackSubmitting();

  /// Whether a submission is currently in flight.
  bool get isSubmitting => this is FeedbackSubmitting;
}

/// No submission in progress.
class FeedbackIdle extends FeedbackStatus {
  /// Creates the idle state.
  const FeedbackIdle();
}

/// A submission is in flight.
class FeedbackSubmitting extends FeedbackStatus {
  /// Creates the submitting state.
  const FeedbackSubmitting();
}

/// The last submission succeeded.
class FeedbackSuccess extends FeedbackStatus {
  /// Creates the success state carrying the created issue [result].
  const FeedbackSuccess(this.result);

  /// The outcome of the successful submission.
  final FeedbackResult result;
}

/// The last submission failed.
class FeedbackFailure extends FeedbackStatus {
  /// Creates the failure state carrying the underlying [error].
  const FeedbackFailure(this.error);

  /// The error that caused the failure.
  final Object error;
}
