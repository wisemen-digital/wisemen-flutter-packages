import 'dart:async';

import 'package:feedback/feedback.dart' hide FeedbackController;
import 'package:flutter/material.dart';

import '../controller/feedback_controller.dart';
import '../models/feedback_exception.dart';
import '../models/feedback_report.dart';
import '../models/feedback_status.dart';
import '../transport/feedback_transport.dart';
import 'feedback_button.dart';
import 'feedback_form.dart';
import 'feedback_toast.dart';
import 'wise_feedback_theme.dart';

/// Mount once near the app root to enable in-app bug reporting.
///
/// Wraps [child] with the screenshot capture layer, overlays a built-in
/// button (unless [showButton] is false), and files reports through
/// [transport].
class LinearFeedback extends StatefulWidget {
  /// Creates the wrapper.
  const LinearFeedback({
    required this.transport,
    required this.child,
    this.theme = const WiseFeedbackTheme(),
    this.onStatusChanged,
    this.showButton = true,
    this.buttonAlignment = Alignment.bottomRight,
    this.buttonBackgroundColor = Colors.black,
    super.key,
  });

  /// Where reports are delivered.
  final FeedbackTransport transport;

  /// The app (or subtree) to wrap.
  final Widget child;

  /// Text/surface configuration for the built-in form.
  final WiseFeedbackTheme theme;

  /// Optional callback fired whenever submission status changes.
  final void Function(FeedbackStatus status)? onStatusChanged;

  /// Whether to overlay the built-in feedback button.
  final bool showButton;

  /// Where the built-in button sits over the app.
  final Alignment buttonAlignment;

  /// Background color of the built-in button.
  final Color buttonBackgroundColor;

  @override
  State<LinearFeedback> createState() => _LinearFeedbackState();
}

class _LinearFeedbackState extends State<LinearFeedback> {
  late final FeedbackController _controller =
      FeedbackController(widget.transport);
  late final FeedbackToastPresenter _toasts =
      FeedbackToastPresenter(() => _overlayContext);

  BuildContext? _overlayContext;
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
          _overlayContext = betterFeedbackContext;
          _bindVisibility(betterFeedbackContext);
          _controller.bindShow(
            () => BetterFeedback.of(betterFeedbackContext)
                .show(_handleUserFeedback),
          );
          if (!widget.showButton) {
            return widget.child;
          }
          return Stack(
            children: [
              widget.child,
              ValueListenableBuilder<bool>(
                valueListenable: _controller.isVisible,
                builder: (context, isVisible, _) => isVisible
                    ? const SizedBox.shrink()
                    : FeedbackButton(
                        alignment: widget.buttonAlignment,
                        backgroundColor: widget.buttonBackgroundColor,
                        onPressed: _controller.show,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
