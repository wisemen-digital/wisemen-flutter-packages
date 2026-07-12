import 'package:feedback/feedback.dart' hide FeedbackController;
import 'package:flutter/material.dart';

import '../controller/feedback_controller.dart';
import '../models/feedback_report.dart';
import '../models/feedback_status.dart';
import '../transport/feedback_transport.dart';
import '../triggers/feedback_trigger.dart';
import 'feedback_form.dart';
import 'wise_feedback_theme.dart';

/// Mount once near the app root to enable in-app bug reporting.
///
/// Wraps [child] with the screenshot capture layer, mounts [triggers], and
/// files reports through [transport]. Open the flow from anywhere below this
/// widget with `LinearFeedback.of(context).show()`.
class LinearFeedback extends StatefulWidget {
  /// Creates the wrapper.
  const LinearFeedback({
    required this.transport,
    required this.child,
    this.triggers = const [],
    this.theme = const WiseFeedbackTheme(),
    this.onStatusChanged,
    super.key,
  });

  /// Where reports are delivered.
  final FeedbackTransport transport;

  /// The app (or subtree) to wrap.
  final Widget child;

  /// Triggers that can open the feedback flow.
  final List<FeedbackTrigger> triggers;

  /// Visual configuration for the built-in form.
  final WiseFeedbackTheme theme;

  /// Optional callback fired whenever submission status changes (e.g. to show
  /// your own snackbar/toast).
  final void Function(FeedbackStatus status)? onStatusChanged;

  /// Returns the nearest [FeedbackController].
  static FeedbackController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_LinearFeedbackScope>();
    assert(
      scope != null,
      'LinearFeedback.of() called with no LinearFeedback ancestor.',
    );
    return scope!.controller;
  }

  @override
  State<LinearFeedback> createState() => _LinearFeedbackState();
}

class _LinearFeedbackState extends State<LinearFeedback> {
  late final FeedbackController _controller =
      FeedbackController(widget.transport);

  @override
  void initState() {
    super.initState();
    if (widget.onStatusChanged != null) {
      _controller.addListener(() => widget.onStatusChanged!(_controller.value));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleUserFeedback(UserFeedback feedback) async {
    final title = (feedback.extra?['title'] as String?) ?? '';
    await _controller.submit(
      FeedbackReport(
        title: title,
        description: feedback.text,
        screenshotPng: feedback.screenshot,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
      feedbackBuilder: (context, onSubmit, scrollController) => FeedbackForm(
        theme: widget.theme,
        status: _controller,
        onSubmit: (description, {extras}) =>
            onSubmit(description, extras: extras),
      ),
      child: Builder(
        builder: (betterFeedbackContext) {
          // Bind the actual "show" action now that we have a context under
          // BetterFeedback.
          _controller.bindShow(
            () => BetterFeedback.of(betterFeedbackContext)
                .show(_handleUserFeedback),
          );
          var wrapped = widget.child;
          for (final trigger in widget.triggers) {
            wrapped = trigger.wrap(betterFeedbackContext, _controller, wrapped);
          }
          return _LinearFeedbackScope(controller: _controller, child: wrapped);
        },
      ),
    );
  }
}

class _LinearFeedbackScope extends InheritedWidget {
  const _LinearFeedbackScope({required this.controller, required super.child});

  final FeedbackController controller;

  @override
  bool updateShouldNotify(_LinearFeedbackScope oldWidget) =>
      oldWidget.controller != controller;
}
