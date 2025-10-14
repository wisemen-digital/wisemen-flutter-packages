import 'package:flutter/material.dart';

/// Provides a collection of predefined text styles used throughout the application.
///
/// These base text styles define font families, sizes, and weights but do not
/// include colors. Colors should be applied separately using the theme system.
///
/// Example:
/// ```dart
/// // Direct usage with color
/// Text('Hello', style: AppStyles.title.copyWith(color: Colors.black))
///
/// // Or use the context extension for automatic color application (preferred)
/// Text('Hello', style: context.title)
/// ```
class AppStyles {
  /// Large title text style using Albert Sans font at 24px.
  ///
  /// Typically used for page titles and major headings.
  static const TextStyle title = TextStyle(fontWeight: FontWeight.w600, fontSize: 24, height: 0);

  /// Normal body text style at 14px with regular weight.
  ///
  /// The default text style for most content.
  static const TextStyle normal = TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 0);

  /// Label text style at 14px with medium weight.
  ///
  /// Used for form labels, captions, and secondary headings.
  static const TextStyle label = TextStyle(fontWeight: FontWeight.w500, fontSize: 14, height: 0);

  /// Hint text style at 16px with regular weight.
  ///
  /// Used for placeholder text and input hints.
  static const TextStyle hint = TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 0);

  /// Button text style at 16px with semi-bold weight.
  ///
  /// Used for button labels and call-to-action text.
  static const TextStyle button = TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 0);
}
