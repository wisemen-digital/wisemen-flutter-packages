import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/feedback_status.dart';
import 'wise_feedback_theme.dart';

/// Callback invoked when the user submits the form.
///
/// Matches the `feedback` package's submit signature: the [description] is the
/// primary text and [extras] carries the title under key `title`.
typedef FeedbackFormSubmit = Future<void> Function(
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
    super.key,
  });

  /// Called with the description and `{'title': ...}` extras on submit.
  final FeedbackFormSubmit onSubmit;

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  /// Submission state used to show progress and disable the button.
  final ValueListenable<FeedbackStatus> status;

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    return ColoredBox(
      color: theme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: 16),
            ValueListenableBuilder<FeedbackStatus>(
              valueListenable: widget.status,
              builder: (context, status, _) {
                return SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    key: const Key('wise_feedback_submit'),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: status.isSubmitting
                        ? null
                        : () => widget.onSubmit(
                              _descriptionController.text,
                              extras: {'title': _titleController.text},
                            ),
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
