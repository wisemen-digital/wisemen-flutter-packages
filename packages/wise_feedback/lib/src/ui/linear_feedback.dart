import 'package:feedback/feedback.dart' hide FeedbackController;
import 'package:flutter/material.dart';

import '../controller/feedback_controller.dart';
import '../models/feedback_exception.dart';
import '../models/feedback_report.dart';
import '../models/feedback_status.dart';
import '../transport/feedback_transport.dart';
import '../triggers/feedback_trigger.dart';
import 'feedback_form.dart';
import 'feedback_toast.dart';
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

  /// Optional callback fired whenever submission status changes.
  ///
  /// The package already shows a built-in success/error toast; use this to add
  /// your own handling (analytics, a custom snackbar, navigation, ...).
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

  /// A context above the feedback sheet, used to host toast overlays that must
  /// outlive the sheet (e.g. the success toast shown as the sheet closes).
  BuildContext? _overlayContext;

  /// Shows and auto-dismisses the built-in success/error toasts.
  late final FeedbackToastPresenter _toasts =
      FeedbackToastPresenter(() => _overlayContext);

  /// The feedback sheet's controller, whose visibility we mirror onto
  /// [_controller] so triggers can react (e.g. hide the floating button).
  Listenable? _feedbackNotifier;

  @override
  void initState() {
    super.initState();
    if (widget.onStatusChanged != null) {
      _controller.addListener(() => widget.onStatusChanged!(_controller.value));
    }
  }

  @override
  void dispose() {
    _feedbackNotifier?.removeListener(_syncVisibility);
    _toasts.dispose();
    _controller.dispose();
    super.dispose();
  }

  /// Starts mirroring the feedback sheet's visibility onto the controller.
  void _bindVisibility(BuildContext context) {
    final notifier = BetterFeedback.of(context);
    if (identical(_feedbackNotifier, notifier)) {
      return;
    }
    _feedbackNotifier?.removeListener(_syncVisibility);
    _feedbackNotifier = notifier;
    notifier.addListener(_syncVisibility);
  }

  void _syncVisibility() {
    final context = _overlayContext;
    if (!mounted || context == null) {
      return;
    }
    _controller.isVisible.value = BetterFeedback.of(context).isVisible;
  }

  /// Maps the captured [feedback] to a [FeedbackReport] and submits it.
  ///
  /// On failure this rethrows so the `feedback` package skips its automatic
  /// `hide()` and the sheet stays open for the user to retry. The submit
  /// wrapper in [build] catches the error.
  Future<void> _handleUserFeedback(UserFeedback feedback) async {
    final title = (feedback.extra?['title'] as String?) ?? '';
    await _controller.submit(
      FeedbackReport(
        title: title,
        description: feedback.text,
        screenshotPng: feedback.screenshot,
      ),
    );
    final status = _controller.value;
    if (status.state == FeedbackSubmissionState.failure) {
      final error = status.error;
      if (error is FeedbackException) {
        throw error;
      }
      throw FeedbackException('Failed to send the report.', cause: error);
    }
  }

  /// Drives one submission: triggers capture + send via [packageOnSubmit],
  /// shows a toast, and returns `null` on success or an error message on
  /// failure (which the form renders inline while staying open).
  Future<String?> _submit(
    OnSubmit packageOnSubmit,
    String description,
    Map<String, dynamic>? extras,
  ) async {
    try {
      await packageOnSubmit(description, extras: extras);
      _toasts.show(widget.theme.successMessage, isError: false);
      return null;
    } catch (error) {
      final message = error is FeedbackException
          ? error.message
          : widget.theme.genericErrorMessage;
      _toasts.show(message, isError: true);
      return message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
      feedbackBuilder: (context, onSubmit, scrollController) => FeedbackForm(
        theme: widget.theme,
        status: _controller,
        scrollController: scrollController,
        onSubmit: (description, {extras}) =>
            _submit(onSubmit, description, extras),
      ),
      child: Builder(
        builder: (betterFeedbackContext) {
          // Bind the "show" action and capture a stable context above the
          // sheet for toasts, now that we're under BetterFeedback.
          _overlayContext = betterFeedbackContext;
          _bindVisibility(betterFeedbackContext);
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
