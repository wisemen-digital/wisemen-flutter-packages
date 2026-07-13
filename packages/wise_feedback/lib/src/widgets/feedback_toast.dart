import 'dart:async';

import 'package:flutter/material.dart';

/// A self-contained toast rendered in an overlay above the app.
///
/// The overlay above the app has no [Directionality] or [Material], so both
/// are provided here.
class FeedbackToast extends StatelessWidget {
  /// Creates a toast.
  const FeedbackToast({
    required this.message,
    required this.isError,
    required this.onDismiss,
    super.key,
  });

  /// The text shown in the toast.
  final String message;

  /// Whether to render with the error (vs success) palette.
  final bool isError;

  /// Called when the toast is tapped.
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

/// Shows [FeedbackToast]s in the nearest [Overlay] and auto-dismisses them.
///
/// Owns the overlay entries and their timers so the host widget's `State` does
/// not have to. Call [dispose] to cancel pending timers.
class FeedbackToastPresenter {
  /// Creates a presenter that resolves its overlay host lazily via
  /// [_overlayContext] (the context may not exist yet at construction time).
  FeedbackToastPresenter(this._overlayContext);

  final BuildContext? Function() _overlayContext;
  final Set<Timer> _timers = <Timer>{};

  /// Inserts a toast into the overlay; auto-dismisses after 4 seconds.
  void show(String message, {required bool isError}) {
    final context = _overlayContext();
    if (context == null) {
      return;
    }
    final overlay = Overlay.maybeOf(context);
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
        _timers.remove(timer);
      }
      entry.remove();
    }

    entry = OverlayEntry(
      builder: (context) {
        final bottom = MediaQuery.viewPaddingOf(context).bottom + 24;
        return Positioned(
          left: 16,
          right: 16,
          bottom: bottom,
          child: FeedbackToast(
            message: message,
            isError: isError,
            onDismiss: remove,
          ),
        );
      },
    );
    overlay.insert(entry);
    timer = Timer(const Duration(seconds: 4), remove);
    _timers.add(timer);
  }

  /// Cancels all pending auto-dismiss timers.
  void dispose() {
    for (final timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
  }
}
