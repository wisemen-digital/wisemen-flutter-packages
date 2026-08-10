import 'package:flutter/material.dart';

/// Visual configuration for the built-in feedback form.
///
/// Defaults follow a modern, Crispy-style design: labelled inputs with a soft
/// border and 16px corners, and an indigo brand accent. All user-facing text is
/// localized via the package's localizations, not configured here.
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
    this.errorColor = const Color(0xFFD32F2F),
    this.successColor = const Color(0xFF2E7D32),
    this.grabberColor = const Color(0x33000000),
    this.onAccentColor = Colors.white,
    this.fieldRadius = 16,
  });

  /// Accent color for the submit button and focused fields.
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

  /// Fill for failure surfaces: the inline submission error and the error toast.
  final Color errorColor;

  /// Fill for the success toast.
  final Color successColor;

  /// Fill of the pill at the top of the sheet that signals it can be dragged.
  final Color grabberColor;

  /// Icons and text drawn on top of a [primaryColor], [errorColor] or
  /// [successColor] fill.
  final Color onAccentColor;

  /// Corner radius of input boxes.
  final double fieldRadius;
}
