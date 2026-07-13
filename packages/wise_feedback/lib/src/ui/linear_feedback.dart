import 'dart:async';

import 'package:feedback/feedback.dart' hide FeedbackController;
import 'package:flutter/material.dart';

import '../controller/feedback_controller.dart';
import '../models/feedback_exception.dart';
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

  /// Pending auto-dismiss timers for visible toasts, cancelled on dispose.
  final Set<Timer> _toastTimers = <Timer>{};

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
    for (final timer in _toastTimers) {
      timer.cancel();
    }
    _toastTimers.clear();
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
      _showToast(widget.theme.successMessage, isError: false);
      return null;
    } catch (error) {
      final message = error is FeedbackException
          ? error.message
          : widget.theme.genericErrorMessage;
      _showToast(message, isError: true);
      return message;
    }
  }

  void _showToast(String message, {required bool isError}) {
    final overlayContext = _overlayContext;
    if (overlayContext == null) {
      return;
    }
    final overlay = Overlay.maybeOf(overlayContext);
    if (overlay == null) {
      return;
    }
    late final OverlayEntry entry;
    Timer? timer;
    var removed = false;
    void remove() {
      if (removed) {
        return;
      }
      removed = true;
      if (timer != null) {
        timer.cancel();
        _toastTimers.remove(timer);
      }
      entry.remove();
    }

    entry = OverlayEntry(
      builder: (context) {
        final bottom = MediaQuery.of(context).viewPadding.bottom + 24;
        return Positioned(
          left: 16,
          right: 16,
          bottom: bottom,
          child: _FeedbackToast(
            message: message,
            isError: isError,
            onDismiss: remove,
          ),
        );
      },
    );
    overlay.insert(entry);
    timer = Timer(const Duration(seconds: 4), remove);
    _toastTimers.add(timer);
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

/// A self-contained toast rendered in the feedback overlay.
///
/// The overlay above the app has no [Directionality] or [Material], so both
/// are provided here.
class _FeedbackToast extends StatelessWidget {
  const _FeedbackToast({
    required this.message,
    required this.isError,
    required this.onDismiss,
  });

  final String message;
  final bool isError;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onDismiss,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color:
                  isError ? const Color(0xFFD32F2F) : const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isError ? Icons.error_outline : Icons.check_circle_outline,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
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
