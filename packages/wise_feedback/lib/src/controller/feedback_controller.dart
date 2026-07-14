import 'package:flutter/foundation.dart';

import '../models/feedback_report.dart';
import '../models/feedback_status.dart';
import '../transport/feedback_transport.dart';

/// Owns the submission state of the feedback flow.
///
/// Exposes state as a [ValueListenable] of [FeedbackStatus]; no state
/// management framework is required by consumers.
class FeedbackController extends ValueNotifier<FeedbackStatus> {
  /// Creates a controller that submits through the given `transport`.
  FeedbackController(this._transport) : super(const FeedbackIdle());

  final FeedbackTransport _transport;

  /// Whether the feedback UI is currently open.
  ///
  /// Maintained by `WiseFeedback`, which hides the built-in button while
  /// the sheet is open.
  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  /// Returns to [FeedbackIdle].
  ///
  /// Called before the form opens so a failure from a previous session does
  /// not surface as a stale error.
  void reset() {
    value = const FeedbackIdle();
  }

  /// Submits [report]. Updates [value] through submitting → success/failure.
  /// Never throws; failures are reported via [value].
  Future<void> submit(FeedbackReport report) async {
    value = const FeedbackSubmitting();
    try {
      value = FeedbackSuccess(await _transport.send(report));
    } catch (e) {
      value = FeedbackFailure(e);
    }
  }

  @override
  void dispose() {
    isVisible.dispose();
    super.dispose();
  }
}
