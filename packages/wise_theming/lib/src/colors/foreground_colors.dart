import 'dart:ui';

/// Abstract base class defining all foreground colors used throughout the application.
///
/// Implement this class to provide a complete set of foreground colors for either
/// light or dark mode. Foreground colors are typically used for icons, interactive
/// elements, and decorative UI components.
///
/// Example implementation:
/// ```dart
/// class MyLightForegroundColors extends ForegroundColors {
///   @override
///   Color get primary => const Color(0xFF000000);
///
///   @override
///   Color get secondary => const Color(0xFF888888);
///
///   // ... implement all other colors
/// }
/// ```
abstract class ForegroundColors {
  /// Primary foreground color for icons and main UI elements.
  Color get primary;

  /// Secondary foreground color for less prominent icons and elements.
  Color get secondary;

  /// Secondary foreground color in hover state.
  Color get secondaryHover;

  /// Tertiary foreground color for subtle UI elements.
  Color get tertiary;

  /// Tertiary foreground color in hover state.
  Color get tertiaryHover;

  /// Quaternary foreground color for de-emphasized elements.
  Color get quaternary;

  /// Quaternary foreground color in hover state.
  Color get quaternaryHover;

  /// Quinary foreground color for minimal emphasis.
  Color get quinary;

  /// Quinary foreground color in hover state.
  Color get quinaryHover;

  /// Senary foreground color for extremely subtle elements.
  Color get senary;

  /// White foreground color for use on dark backgrounds.
  Color get white;

  /// Foreground color for disabled elements.
  Color get disabled;

  /// Subtle foreground color for disabled elements.
  Color get disabledSubtle;

  /// Primary brand foreground color.
  Color get brandPrimary;

  /// Alternative primary brand foreground color.
  Color get brandPrimaryAlt;

  /// Secondary brand foreground color.
  Color get brandSecondary;

  /// Primary error foreground color for error icons.
  Color get errorPrimary;

  /// Secondary error foreground color.
  Color get errorSecondary;

  /// Primary warning foreground color for warning icons.
  Color get warningPrimary;

  /// Secondary warning foreground color.
  Color get warningSecondary;

  /// Primary success foreground color for success icons.
  Color get successPrimary;

  /// Secondary success foreground color.
  Color get successSecondary;
}
