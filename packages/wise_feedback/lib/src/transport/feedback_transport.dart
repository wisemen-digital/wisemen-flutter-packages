import '../models/feedback_exception.dart';
import '../models/feedback_report.dart';
import '../models/feedback_result.dart';

/// Delivers a [FeedbackReport] to a destination (e.g. Linear).
///
/// Implementations must throw a [FeedbackException] on failure.
// ignore: one_member_abstracts
abstract interface class FeedbackTransport {
  /// Sends [report] and returns the created issue's identifiers if available.
  Future<FeedbackResult> send(FeedbackReport report);
}
