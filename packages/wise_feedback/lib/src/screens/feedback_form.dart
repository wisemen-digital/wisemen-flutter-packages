import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/feedback_priority.dart';
import '../models/feedback_status.dart';
import '../template/feedback_field.dart';
import '../theme/wise_feedback_theme.dart';
import 'widgets/widgets.dart';

/// Callback invoked when the user submits the form.
///
/// [values] carries `title`, `fields` (a `Map<String, String>` of the template
/// field values), and — when shown — `priority` (a [FeedbackPriority] name) and
/// `category`. Every field the form collects travels in here; the body text
/// itself is assembled later by the feedback template.
///
/// The form reflects the outcome through its `status` listenable rather than
/// this future's result: on [FeedbackSuccess] the sheet is dismissed, on
/// [FeedbackFailure] it stays open and shows the error inline.
typedef FeedbackFormSubmit = Future<void> Function(Map<String, dynamic> values);

/// The built-in feedback form: a header with close/submit actions, the
/// template's labelled fields, and optional priority/category selectors.
class FeedbackForm extends StatefulWidget {
  /// Creates the form.
  const FeedbackForm({
    required this.onSubmit,
    required this.theme,
    required this.status,
    required this.fields,
    this.onClose,
    this.scrollController,
    this.showPriority = false,
    this.categories,
    super.key,
  });

  /// Called with the field values (in extras) on submit.
  final FeedbackFormSubmit onSubmit;

  /// Dismisses the sheet without submitting (the header close button).
  final VoidCallback? onClose;

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
    await widget.onSubmit(<String, dynamic>{
      'title': _titleController.text,
      'fields': fieldValues,
      if (widget.showPriority) 'priority': _priority.name,
      if (_category != null) 'category': _category,
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return ColoredBox(
      color: theme.backgroundColor,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 16 + bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FeedbackSheetGrabber(),
            FeedbackFormHeader(
              theme: theme,
              status: widget.status,
              onClose: widget.onClose,
              onSubmit: _submit,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FeedbackLabeledField(
                    theme: theme,
                    label: theme.titleHint,
                    child: FeedbackTextInput(
                      theme: theme,
                      controller: _titleController,
                      fieldKey: const Key('wise_feedback_title'),
                    ),
                  ),
                  for (final field in widget.fields) ...[
                    const SizedBox(height: 16),
                    FeedbackLabeledField(
                      theme: theme,
                      label: field.label,
                      child: FeedbackTextInput(
                        theme: theme,
                        controller: _fieldControllers[field.key]!,
                        minLines: field.minLines,
                        maxLines: field.maxLines,
                        fieldKey: Key('wise_feedback_field_${field.key}'),
                      ),
                    ),
                  ],
                  if (widget.showPriority) ...[
                    const SizedBox(height: 16),
                    FeedbackLabeledField(
                      theme: theme,
                      label: theme.priorityLabel,
                      child: FeedbackDropdown<FeedbackPriority>(
                        theme: theme,
                        value: _priority,
                        fieldKey: const Key('wise_feedback_priority'),
                        items: {
                          for (final priority in FeedbackPriority.values)
                            priority: priority.label,
                        },
                        onChanged: (value) => setState(
                          () => _priority = value ?? FeedbackPriority.none,
                        ),
                      ),
                    ),
                  ],
                  if (widget.categories case final List<String> categories) ...[
                    const SizedBox(height: 16),
                    FeedbackLabeledField(
                      theme: theme,
                      label: theme.categoryLabel,
                      child: FeedbackDropdown<String>(
                        theme: theme,
                        value: _category,
                        fieldKey: const Key('wise_feedback_category'),
                        hint: theme.categoryLabel,
                        items: {for (final c in categories) c: c},
                        onChanged: (value) => setState(() => _category = value),
                      ),
                    ),
                  ],
                  ValueListenableBuilder<FeedbackStatus>(
                    valueListenable: widget.status,
                    builder: (context, status, _) => status is FeedbackFailure
                        ? FeedbackErrorMessage(
                            message: theme.messageForError(status.error),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
