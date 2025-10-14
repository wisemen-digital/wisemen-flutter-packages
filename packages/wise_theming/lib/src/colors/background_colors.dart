import 'dart:ui';

/// Abstract base class defining all background colors used throughout the application.
///
/// Implement this class to provide a complete set of background colors for either
/// light or dark mode. Background colors include surfaces, containers, overlays,
/// and various states (hover, disabled, etc.).
///
/// Example implementation:
/// ```dart
/// class MyLightBackgroundColors extends BackgroundColors {
///   @override
///   Color get primary => const Color(0xFFFFFFFF);
///
///   @override
///   Color get secondary => const Color(0xFFF5F5F5);
///
///   // ... implement all other colors
/// }
/// ```
abstract class BackgroundColors {
  /// Primary background color for main surfaces and screens.
  Color get primary;

  /// Alternative primary background color for variation.
  Color get primaryAlt;

  /// Primary background color in hover state.
  Color get primaryHover;

  /// Solid primary background color for high contrast.
  Color get primarySolid;

  /// Secondary background color for cards and containers.
  Color get secondary;

  /// Alternative secondary background color for variation.
  Color get secondaryAlt;

  /// Secondary background color in hover state.
  Color get secondaryHover;

  /// Subtle secondary background color for minimal emphasis.
  Color get secondarySubtle;

  /// Solid secondary background color for high contrast.
  Color get secondarySolid;

  /// Tertiary background color for nested elements.
  Color get tertiary;

  /// Quaternary background color for deeply nested elements.
  Color get quaternary;

  /// Background color for active/selected states.
  Color get active;

  /// Background color for disabled elements.
  Color get disabled;

  /// Subtle background color for disabled elements.
  Color get disabledSubtle;

  /// Background color for overlays and modals.
  Color get overlay;

  /// Primary brand background color.
  Color get brandPrimary;

  /// Alternative primary brand background color.
  Color get brandPrimaryAlt;

  /// Secondary brand background color.
  Color get brandSecondary;

  /// Solid brand background color for buttons and CTAs.
  Color get brandSolid;

  /// Solid brand background color in hover state.
  Color get brandSolidHover;

  /// Brand background color for section headers.
  Color get brandSection;

  /// Subtle brand background color for section headers.
  Color get brandSectionSubtle;

  /// Primary error background color for error states.
  Color get errorPrimary;

  /// Secondary error background color.
  Color get errorSecondary;

  /// Solid error background color for error buttons.
  Color get errorSolid;

  /// Primary warning background color for warning states.
  Color get warningPrimary;

  /// Secondary warning background color.
  Color get warningSecondary;

  /// Solid warning background color for warning buttons.
  Color get warningSolid;

  /// Primary success background color for success states.
  Color get successPrimary;

  /// Secondary success background color.
  Color get successSecondary;

  /// Solid success background color for success buttons.
  Color get successSolid;
}
