import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/feedback_priority.dart';
import '../models/feedback_status.dart';
import '../template/feedback_field.dart';
import '../theme/wise_feedback_theme.dart';

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
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return ColoredBox(
      color: theme.backgroundColor,
      child: Column(
        children: [
          _Header(
            theme: theme,
            status: widget.status,
            onClose: widget.onClose,
            onSubmit: _submit,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              padding: EdgeInsets.fromLTRB(16, 4, 16, 16 + bottomInset),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _LabeledField(
                    theme: theme,
                    label: theme.titleHint,
                    child: _input(
                      theme,
                      _titleController,
                      fieldKey: const Key('wise_feedback_title'),
                    ),
                  ),
                  for (final field in widget.fields) ...[
                    const SizedBox(height: 16),
                    _LabeledField(
                      theme: theme,
                      label: field.label,
                      child: _input(
                        theme,
                        _fieldControllers[field.key]!,
                        minLines: field.minLines,
                        maxLines: field.maxLines,
                        fieldKey: Key('wise_feedback_field_${field.key}'),
                      ),
                    ),
                  ],
                  if (widget.showPriority) ...[
                    const SizedBox(height: 16),
                    _LabeledField(
                      theme: theme,
                      label: theme.priorityLabel,
                      child: _dropdown<FeedbackPriority>(
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
                    _LabeledField(
                      theme: theme,
                      label: theme.categoryLabel,
                      child: _dropdown<String>(
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
                    builder: (context, status, _) {
                      if (status is! FeedbackFailure) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
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
                                theme.messageForError(status.error),
                                style: const TextStyle(color: Color(0xFFD32F2F)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(
    WiseFeedbackTheme theme,
    TextEditingController controller, {
    int minLines = 1,
    int maxLines = 1,
    Key? fieldKey,
  }) {
    return TextField(
      key: fieldKey,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: theme.primaryColor,
      style: TextStyle(
        fontSize: 17,
        letterSpacing: -0.43,
        color: theme.textColor,
      ),
      decoration: InputDecoration(
        isCollapsed: true,
        border: InputBorder.none,
        hintStyle: TextStyle(color: theme.hintColor, fontSize: 17),
      ),
    );
  }

  Widget _dropdown<T>({
    required WiseFeedbackTheme theme,
    required T? value,
    required Map<T, String> items,
    required ValueChanged<T?> onChanged,
    required Key fieldKey,
    String? hint,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        key: fieldKey,
        value: value,
        isExpanded: true,
        isDense: true,
        hint: hint == null
            ? null
            : Text(
                hint,
                style: TextStyle(color: theme.hintColor, fontSize: 17),
              ),
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.hintColor),
        style: TextStyle(fontSize: 17, color: theme.textColor),
        onChanged: onChanged,
        items: [
          for (final entry in items.entries)
            DropdownMenuItem<T>(value: entry.key, child: Text(entry.value)),
        ],
      ),
    );
  }
}

/// The sticky header: close button, centered title, brand submit button.
class _Header extends StatelessWidget {
  const _Header({
    required this.theme,
    required this.status,
    required this.onClose,
    required this.onSubmit,
  });

  final WiseFeedbackTheme theme;
  final ValueListenable<FeedbackStatus> status;
  final VoidCallback? onClose;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          _CircleButton(
            buttonKey: const Key('wise_feedback_close'),
            background: theme.iconButtonColor,
            icon: Icons.close_rounded,
            iconColor: theme.labelColor,
            onTap: onClose,
          ),
          Expanded(
            child: Text(
              theme.sheetTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: theme.textColor,
              ),
            ),
          ),
          ValueListenableBuilder<FeedbackStatus>(
            valueListenable: status,
            builder: (context, status, _) => _CircleButton(
              buttonKey: const Key('wise_feedback_submit'),
              background: theme.primaryColor,
              icon: Icons.check_rounded,
              iconColor: Colors.white,
              loading: status.isSubmitting,
              onTap: status.isSubmitting ? null : onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.buttonKey,
    required this.background,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.loading = false,
  });

  final Key buttonKey;
  final Color background;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 44,
      child: Material(
        key: buttonKey,
        color: background,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: loading
                ? SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: iconColor,
                    ),
                  )
                : Icon(icon, size: 20, color: iconColor),
          ),
        ),
      ),
    );
  }
}

/// A label above a bordered, rounded input box.
class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.theme,
    required this.label,
    required this.child,
  });

  final WiseFeedbackTheme theme;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          child: Text(
            label,
            style: TextStyle(fontSize: 15, color: theme.labelColor),
          ),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 52),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: theme.fieldFillColor,
            borderRadius: BorderRadius.circular(theme.fieldRadius),
            border: Border.all(color: theme.fieldBorderColor),
          ),
          child: child,
        ),
      ],
    );
  }
}
