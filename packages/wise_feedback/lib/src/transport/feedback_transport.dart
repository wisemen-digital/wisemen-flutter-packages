import '../models/feedback_report.dart';
import '../models/feedback_result.dart';

/// Transports a feedback report to an external service.
// ignore: one_member_abstracts
abstract interface class FeedbackTransport {
  /// Sends a feedback report and returns the result.
  Future<FeedbackResult> send(FeedbackReport report);
}
