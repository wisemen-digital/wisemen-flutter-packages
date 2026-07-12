import 'package:flutter/foundation.dart';

import 'feedback_result.dart';

/// Lifecycle state of a feedback submission.
enum FeedbackSubmissionState {
  /// No submission in progress.
  idle,

  /// A submission is in flight.
  submitting,

  /// The last submission succeeded.
  success,

  /// The last submission failed.
  failure,
}

/// Immutable snapshot of submission state, exposed via a [ValueListenable].
class FeedbackStatus {
  const FeedbackStatus._(this.state, {this.result, this.error});

  /// Nothing happening.
  const FeedbackStatus.idle() : this._(FeedbackSubmissionState.idle);

  /// Submission started.
  const FeedbackStatus.submitting()
      : this._(FeedbackSubmissionState.submitting);

  /// Submission succeeded with [result].
  const FeedbackStatus.success(FeedbackResult result)
      : this._(FeedbackSubmissionState.success, result: result);

  /// Submission failed with [error].
  const FeedbackStatus.failure(Object error)
      : this._(FeedbackSubmissionState.failure, error: error);

  /// The current lifecycle state.
  final FeedbackSubmissionState state;

  /// Set when [state] is [FeedbackSubmissionState.success].
  final FeedbackResult? result;

  /// Set when [state] is [FeedbackSubmissionState.failure].
  final Object? error;

  /// Whether a submission is currently in flight.
  bool get isSubmitting => state == FeedbackSubmissionState.submitting;
}
