import 'package:flutter/material.dart';

/// Provides a collection of predefined text styles used throughout the application.
///
/// These base text styles define font families, sizes, and weights but do not
/// include colors. Colors should be applied separately using the theme system.
/// Loosely based on iOS (SwiftUI) text styles for consistency.
///
/// Example:
/// ```dart
/// Text('Hello', style: AppStyles.title.copyWith(color: Colors.black))
///
/// Text('Hello', style: context.body)
/// ```
class AppStyles {
  /// Typically used for page titles and major headings.
  static const TextStyle largeTitle =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 33, height: 0);

  /// Used for page titles and major headings.
  static const TextStyle title =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 24, height: 0);

  /// Headline text style at 14px with medium weight.
  ///
  /// Used for form labels, captions, and secondary headings.
  static const TextStyle headline =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 14, height: 0);

  /// SubHeadline text style at 11px with regular weight.
  ///
  /// Used for secondary headings and supporting text.
  static const TextStyle subHeadline =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 11, height: 0);

  /// Body text style at 14px with regular weight.
  ///
  /// The default text style for most content.
  static const TextStyle body =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 0);

  /// Title text style at 14px with semi-bold weight.
  ///
  /// Used for text inputs (height 0 in text inputs messes with padding).
  static const TextStyle input =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
}
