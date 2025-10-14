import 'dart:ui';

/// Abstract base class defining all border colors used throughout the application.
///
/// Implement this class to provide a complete set of border colors for either
/// light or dark mode. Border colors are used for outlines, dividers, and
/// container boundaries.
///
/// Example implementation:
/// ```dart
/// class MyLightBorderColors extends BorderColors {
///   @override
///   Color get primary => const Color(0xFFE0E0E0);
///
///   @override
///   Color get secondary => const Color(0xFFF0F0F0);
///
///   // ... implement all other colors
/// }
/// ```
abstract class BorderColors {
  /// Primary border color for main dividers and outlines.
  Color get primary;

  /// Secondary border color for subtle separators.
  Color get secondary;

  /// Tertiary border color for minimal emphasis borders.
  Color get tertiary;

  /// Border color for disabled elements.
  Color get disabled;

  /// Subtle border color for disabled elements.
  Color get disabledSubtle;

  /// Brand border color for branded elements.
  Color get brand;

  /// Alternative brand border color for variation.
  Color get brandAlt;

  /// Border color for error states and validation.
  Color get error;

  /// Subtle border color for error states.
  Color get errorSubtle;
}
