import 'package:flutter/foundation.dart';

import '../models/feedback_report.dart';
import '../models/feedback_status.dart';
import '../transport/feedback_transport.dart';

/// Owns submission state and the "open feedback UI" action.
///
/// Exposes state as a [ValueListenable] of [FeedbackStatus]; no state
/// management framework is required by consumers.
class FeedbackController extends ValueNotifier<FeedbackStatus> {
  /// Creates a controller that submits through `transport`.
  FeedbackController(this._transport) : super(const FeedbackStatus.idle());

  final FeedbackTransport _transport;
  void Function()? _showHandler;

  /// Wires the action that opens the feedback UI. Called by `LinearFeedback`.
  // ignore: use_setters_to_change_properties
  void bindShow(void Function() handler) => _showHandler = handler;

  /// Opens the feedback UI, if a handler has been bound.
  void show() => _showHandler?.call();

  /// Submits [report]. Updates [value] through submitting → success/failure.
  /// Never throws; failures are reported via [value].
  Future<void> submit(FeedbackReport report) async {
    value = const FeedbackStatus.submitting();
    try {
      final result = await _transport.send(report);
      value = FeedbackStatus.success(result);
    } on Object catch (e) {
      value = FeedbackStatus.failure(e);
    }
  }
}
