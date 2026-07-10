import 'package:wise_feedback/wise_feedback.dart';

/// A fake transport for testing that records calls and returns configured results.
class FakeTransport implements FeedbackTransport {
  /// Creates a fake transport with an optional configured [result].
  FakeTransport({FeedbackResult? result})
      : _result = result ?? const FeedbackResult();

  final FeedbackResult _result;
  final List<FeedbackReport> _sentReports = [];

  /// Whether [send] was called at least once.
  bool get sendWasCalled => _sentReports.isNotEmpty;

  /// The number of times [send] was called.
  int get sendCallCount => _sentReports.length;

  /// The last report that was sent, or null if [send] was never called.
  FeedbackReport? get lastReport =>
      _sentReports.isNotEmpty ? _sentReports.last : null;

  @override
  Future<FeedbackResult> send(FeedbackReport report) async {
    _sentReports.add(report);
    return _result;
  }
}
