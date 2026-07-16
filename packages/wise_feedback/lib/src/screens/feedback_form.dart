import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/feedback_priority.dart';
import '../models/feedback_status.dart';
import '../template/feedback_field.dart';
import '../theme/wise_feedback_theme.dart';

/// Wisemen accent used for the submit button.
const Color _kAccent = Color(0xFF009687);

/// Callback invoked when the user submits the form.
///
/// The extras map carries `title`, `fields` (a `Map<String, String>` of the
/// template field values), and — when shown — `priority` (a [FeedbackPriority]
/// name) and `category`.
///
/// The form reflects the outcome through its `status` listenable rather than
/// this future's result: on [FeedbackSuccess] the sheet is dismissed, on
/// [FeedbackFailure] it stays open and shows the error inline.
typedef FeedbackFormSubmit = Future<void> Function(
  String description, {
  Map<String, dynamic>? extras,
});

/// The built-in feedback form: a title, the template's fields, and optional
/// priority/category selectors.
class FeedbackForm extends StatefulWidget {
  /// Creates the form.
  const FeedbackForm({
    required this.onSubmit,
    required this.theme,
    required this.status,
    required this.fields,
    this.scrollController,
    this.showPriority = false,
    this.categories,
    super.key,
  });

  /// Called with the field values (in extras) on submit.
  final FeedbackFormSubmit onSubmit;

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  /// Submission state used to show progress and disable the button.
  final ValueListenable<FeedbackStatus> status;

  /// The template's editable fields, rendered below the title.
  final List<FeedbackField> fields;

  /// Scroll controller supplied by the surrounding draggable sheet.
  final ScrollController? scrollController;

  /// Whether to show a priority selector.
  final bool showPriority;

  /// Category options to offer, or null to hide the category selector.
  final List<String>? categories;

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _titleController = TextEditingController();
  late final Map<String, TextEditingController> _fieldControllers = {
    for (final field in widget.fields) field.key: TextEditingController(),
  };
  FeedbackPriority _priority = FeedbackPriority.none;
  String? _category;

  @override
  void dispose() {
    _titleController.dispose();
    for (final controller in _fieldControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    // The outcome (success dismisses the sheet, failure shows inline below) is
    // reflected through `status`, so nothing here has to change local state.
    final fieldValues = <String, String>{
      for (final entry in _fieldControllers.entries)
        entry.key: entry.value.text,
    };
    await widget.onSubmit(
      '',
      extras: <String, dynamic>{
        'title': _titleController.text,
        'fields': fieldValues,
        if (widget.showPriority) 'priority': _priority.name,
        if (_category != null) 'category': _category,
      },
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
                for (final field in widget.fields)
                  TextField(
                    key: Key('wise_feedback_field_${field.key}'),
                    controller: _fieldControllers[field.key],
                    textCapitalization: TextCapitalization.sentences,
                    minLines: field.minLines,
                    maxLines: field.maxLines,
                    decoration: InputDecoration(
                      labelText: field.label,
                      border: const OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                if (widget.showPriority)
                  DropdownButtonFormField<FeedbackPriority>(
                    key: const Key('wise_feedback_priority'),
                    initialValue: _priority,
                    decoration: InputDecoration(
                      labelText: theme.priorityLabel,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      for (final priority in FeedbackPriority.values)
                        DropdownMenuItem(
                          value: priority,
                          child: Text(priority.label),
                        ),
                    ],
                    onChanged: (value) => setState(
                      () => _priority = value ?? FeedbackPriority.none,
                    ),
                  ),
                if (widget.categories case final List<String> categories)
                  DropdownButtonFormField<String>(
                    key: const Key('wise_feedback_category'),
                    initialValue: _category,
                    decoration: InputDecoration(
                      labelText: theme.categoryLabel,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      for (final category in categories)
                        DropdownMenuItem(value: category, child: Text(category)),
                    ],
                    onChanged: (value) => setState(() => _category = value),
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
