import 'dart:async';
import 'package:wise_feedback/wise_feedback.dart';

class FakeTransport implements FeedbackTransport {
  FakeTransport({
    this.result = const FeedbackResult(issueId: 'FAKE-1'),
    this.throwError,
    this.autoComplete = true,
  });

  final FeedbackResult result;
  final Object? throwError;

  /// When false, [send] returns a future you complete manually via [complete].
  final bool autoComplete;

  final List<FeedbackReport> sent = <FeedbackReport>[];
  Completer<FeedbackResult>? _pending;

  @override
  Future<FeedbackResult> send(FeedbackReport report) {
    sent.add(report);
    if (throwError != null) {
      return Future<FeedbackResult>.error(throwError!);
    }
    if (autoComplete) {
      return Future<FeedbackResult>.value(result);
    }
    return (_pending = Completer<FeedbackResult>()).future;
  }

  /// Completes a pending (non-auto) submission.
  void complete() => _pending?.complete(result);
}
