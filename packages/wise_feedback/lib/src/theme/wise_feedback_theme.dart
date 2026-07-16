import 'package:flutter/material.dart';

import '../models/feedback_exception.dart';

/// Text and surface configuration for the built-in feedback form.
///
/// Defaults follow a modern, Crispy-style design: labelled inputs with a soft
/// border and 16px corners, and an indigo brand accent.
class WiseFeedbackTheme {
  /// Creates a theme. All parameters have sensible defaults.
  const WiseFeedbackTheme({
    this.primaryColor = const Color(0xFF4F46E5),
    this.backgroundColor = Colors.white,
    this.fieldFillColor = Colors.white,
    this.fieldBorderColor = const Color(0xFFE3E8EF),
    this.labelColor = const Color(0xFF364152),
    this.textColor = const Color(0xFF121926),
    this.hintColor = const Color(0xFF9AA4B2),
    this.iconButtonColor = const Color(0xFFEEF2F6),
    this.fieldRadius = 16,
    this.sheetTitle = 'Report a bug',
    this.titleHint = 'Title',
    this.descriptionHint = 'Description',
    this.submitLabel = 'Report bug',
    this.priorityLabel = 'Priority',
    this.categoryLabel = 'Category',
    this.successMessage = 'Bug reported. Thanks!',
    this.genericErrorMessage = 'Something went wrong. Please try again.',
  });

  /// Accent color: submit button, focused field cursor.
  final Color primaryColor;

  /// Background color of the form surface.
  final Color backgroundColor;

  /// Fill color of input boxes.
  final Color fieldFillColor;

  /// Border color of input boxes.
  final Color fieldBorderColor;

  /// Color of field labels.
  final Color labelColor;

  /// Color of entered text.
  final Color textColor;

  /// Color of placeholder/hint text.
  final Color hintColor;

  /// Background of the circular close (and neutral icon) buttons.
  final Color iconButtonColor;

  /// Corner radius of input boxes.
  final double fieldRadius;

  /// Title shown in the sheet header.
  final String sheetTitle;

  /// Placeholder/label for the title field.
  final String titleHint;

  /// Placeholder/label for the description field.
  final String descriptionHint;

  /// Text on the submit button.
  final String submitLabel;

  /// Label for the priority selector.
  final String priorityLabel;

  /// Label for the category selector.
  final String categoryLabel;

  /// Confirmation shown after a report is filed successfully.
  final String successMessage;

  /// Fallback message shown when submission fails without a specific reason.
  final String genericErrorMessage;

  /// The user-facing message for a failed submission: the [FeedbackException]'s
  /// own message when available, otherwise [genericErrorMessage].
  String messageForError(Object error) =>
      error is FeedbackException ? error.message : genericErrorMessage;
}
