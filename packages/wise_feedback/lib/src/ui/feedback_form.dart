import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/feedback_status.dart';
import 'wise_feedback_theme.dart';

/// Callback invoked when the user submits the form.
///
/// Matches the `feedback` package's submit signature: [description] is the
/// primary text and [extras] carries the title under key `title`.
///
/// Returns `null` when the report was filed successfully (the form is then
/// dismissed), or a human-readable error message when it failed — in which
/// case the form stays open and shows the message so the user can retry.
typedef FeedbackFormSubmit = Future<String?> Function(
  String description, {
  Map<String, dynamic>? extras,
});

/// The built-in title + description form shown over the screenshot.
class FeedbackForm extends StatefulWidget {
  /// Creates the form.
  const FeedbackForm({
    required this.onSubmit,
    required this.theme,
    required this.status,
    this.scrollController,
    super.key,
  });

  /// Called with the description and `{'title': ...}` extras on submit.
  final FeedbackFormSubmit onSubmit;

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  /// Submission state used to show progress and disable the button.
  final ValueListenable<FeedbackStatus> status;

  /// Scroll controller supplied by the surrounding draggable sheet.
  ///
  /// Wiring it into the scroll view keeps the sheet's drag-to-resize gesture
  /// working and lets the content scroll instead of overflowing when the sheet
  /// is short or the keyboard is open.
  final ScrollController? scrollController;

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_errorText != null) {
      setState(() => _errorText = null);
    }
    final error = await widget.onSubmit(
      _descriptionController.text,
      extras: {'title': _titleController.text},
    );
    // On success the sheet closes and this widget is unmounted; only surface
    // an error, and only while still mounted.
    if (error != null && mounted) {
      setState(() => _errorText = error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final mediaQuery = MediaQuery.of(context);
    final bottomInset =
        mediaQuery.viewInsets.bottom + mediaQuery.viewPadding.bottom;
    return ColoredBox(
      color: theme.backgroundColor,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const Key('wise_feedback_title'),
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: theme.titleHint,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('wise_feedback_description'),
              controller: _descriptionController,
              textCapitalization: TextCapitalization.sentences,
              minLines: 2,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: theme.descriptionHint,
                border: const OutlineInputBorder(),
              ),
            ),
            if (_errorText case final String error) ...[
              const SizedBox(height: 12),
              Row(
                key: const Key('wise_feedback_error'),
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Color(0xFFD32F2F),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      error,
                      style: const TextStyle(color: Color(0xFFD32F2F)),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            ValueListenableBuilder<FeedbackStatus>(
              valueListenable: widget.status,
              builder: (context, status, _) {
                return FilledButton(
                  key: const Key('wise_feedback_submit'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                  ),
                  onPressed: status.isSubmitting ? null : _submit,
                  child: status.isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(theme.submitLabel),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
