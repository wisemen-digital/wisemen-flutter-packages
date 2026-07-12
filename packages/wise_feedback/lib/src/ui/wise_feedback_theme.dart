import 'package:flutter/material.dart';

/// Visual configuration for the built-in feedback form.
class WiseFeedbackTheme {
  /// Creates a theme. All parameters have sensible defaults.
  const WiseFeedbackTheme({
    this.primaryColor = const Color(0xFF009687),
    this.backgroundColor = Colors.white,
    this.titleHint = 'Title',
    this.descriptionHint = 'Description',
    this.submitLabel = 'Report bug',
    this.successMessage = 'Bug reported. Thanks!',
    this.genericErrorMessage = 'Something went wrong. Please try again.',
  });

  /// Accent color for the submit button and focused fields.
  final Color primaryColor;

  /// Background color of the form surface.
  final Color backgroundColor;

  /// Placeholder/label for the title field.
  final String titleHint;

  /// Placeholder/label for the description field.
  final String descriptionHint;

  /// Text on the submit button.
  final String submitLabel;

  /// Confirmation shown after a report is filed successfully.
  final String successMessage;

  /// Fallback message shown when submission fails without a specific reason.
  final String genericErrorMessage;
}
