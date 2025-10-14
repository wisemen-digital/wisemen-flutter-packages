import 'dart:ui';

/// Abstract base class defining all text colors used throughout the application.
///
/// Implement this class to provide a complete set of text colors for either
/// light or dark mode. The colors are organized by usage context (primary,
/// secondary, brand, status, etc.) to ensure consistency across the UI.
///
/// Example implementation:
/// ```dart
/// class MyLightTextColors extends TextColors {
///   @override
///   Color get primary => const Color(0xFF000000);
///
///   @override
///   Color get secondary => const Color(0xFF666666);
///
///   // ... implement all other colors
/// }
/// ```
abstract class TextColors {
  /// Primary text color for main content and headings.
  Color get primary;

  /// Primary text color when displayed on brand-colored backgrounds.
  Color get primaryOnBrand;

  /// Secondary text color for supporting content and labels.
  Color get secondary;

  /// Secondary text color when displayed on brand-colored backgrounds.
  Color get secondaryOnBrand;

  /// Tertiary text color for less prominent information.
  Color get tertiary;

  /// Tertiary text color in hover state.
  Color get tertiaryHover;

  /// Tertiary text color when displayed on brand-colored backgrounds.
  Color get tertiaryOnBrand;

  /// Quaternary text color for subtle or de-emphasized text.
  Color get quaternary;

  /// Quaternary text color when displayed on brand-colored backgrounds.
  Color get quaternaryOnBrand;

  /// White text color for use on dark backgrounds.
  Color get white;

  /// Text color for disabled states.
  Color get disabled;

  /// Text color for input placeholders.
  Color get placeholder;

  /// Subtle text color for secondary placeholders.
  Color get placeholderSubtle;

  /// Primary brand text color.
  Color get brandPrimary;

  /// Secondary brand text color.
  Color get brandSecondary;

  /// Tertiary brand text color.
  Color get brandTertiary;

  /// Alternative tertiary brand text color.
  Color get brandTertiaryAlt;

  /// Text color for error messages and states.
  Color get errorPrimary;

  /// Text color for warning messages and states.
  Color get warningPrimary;

  /// Text color for success messages and states.
  Color get successPrimary;
}
