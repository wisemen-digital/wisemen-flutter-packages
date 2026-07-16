import 'package:flutter/foundation.dart';

import '../models/feedback_report.dart';
import '../models/feedback_status.dart';
import '../transport/feedback_transport.dart';

/// Owns submission state and the "open feedback UI" action.
///
/// Exposes state as a [ValueListenable] of [FeedbackStatus]; no state
/// management framework is required by consumers.
class FeedbackController extends ValueNotifier<FeedbackStatus> {
  /// Creates a controller that submits through the given `transport`.
  FeedbackController(this._transport) : super(FeedbackStatus.idle);

  final FeedbackTransport _transport;
  VoidCallback? _showHandler;

  /// Whether the feedback UI is currently open.
  ///
  /// Maintained by `LinearFeedback`, which hides the built-in button while
  /// the sheet is open.
  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  /// Wires the action that opens the feedback UI. Called internally by
  /// `LinearFeedback`.
  // ignore: use_setters_to_change_properties
  void bindShow(VoidCallback handler) {
    _showHandler = handler;
  }

  /// Opens the feedback UI, if a handler has been bound.
  ///
  /// Resets to [FeedbackStatus.idle] first so a failure from a previous
  /// session does not surface as a stale error when the form reopens.
  void show() {
    value = FeedbackStatus.idle;
    _showHandler?.call();
  }

  /// Submits [report]. Updates [value] through submitting → success/failure.
  /// Never throws; failures are reported via [value].
  Future<void> submit(FeedbackReport report) async {
    value = FeedbackStatus.submitting;
    try {
      value = FeedbackStatus.success(await _transport.send(report));
    } catch (e) {
      value = FeedbackStatus.failure(e);
    }
  }

  @override
  void dispose() {
    isVisible.dispose();
    super.dispose();
  }
}
