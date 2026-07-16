import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/feedback_status.dart';
import '../theme/wise_feedback_theme.dart';

/// Wisemen accent used for the submit button.
const Color _kAccent = Color(0xFF009687);

/// Callback invoked when the user submits the form.
///
/// Matches the `feedback` package's submit signature: [description] is the
/// primary text and [extras] carries the title under key `title`.
///
/// The form reflects the outcome through its `status` listenable rather than
/// this future's result: on [FeedbackSuccess] the sheet is dismissed, on
/// [FeedbackFailure] it stays open and shows the error inline.
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // The outcome (success dismisses the sheet, failure shows inline below) is
    // reflected through `status`, so nothing here has to change local state.
    await widget.onSubmit(
      _descriptionController.text,
      extras: {'title': _titleController.text},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom +
        MediaQuery.viewPaddingOf(context).bottom;
    return ColoredBox(
      color: theme.backgroundColor,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(16).copyWith(bottom: 16 + bottomInset),
        child: ValueListenableBuilder<FeedbackStatus>(
          valueListenable: widget.status,
          builder: (context, status, _) {
            final errorText = status is FeedbackFailure
                ? theme.messageForError(status.error)
                : null;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
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
                if (errorText != null)
                  Row(
                    key: const Key('wise_feedback_error'),
                    spacing: 8,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Color(0xFFD32F2F),
                        size: 18,
                      ),
                      Expanded(
                        child: Text(
                          errorText,
                          style: const TextStyle(color: Color(0xFFD32F2F)),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: FilledButton(
                    key: const Key('wise_feedback_submit'),
                    style: FilledButton.styleFrom(
                      backgroundColor: _kAccent,
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
