import 'dart:ui';

/// [BorderColors] that holds colors used for borders throughout the app.
/// Use border color variables to manage all stroke colors in your designs across light and dark modes.
class BorderColors {
  /// Creates an instance of [BorderColors].
  const BorderColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.disabled,
    required this.disabledSubtle,
    required this.brand,
    required this.brandAlt,
    required this.error,
    required this.errorSubtle,
  });

  /// High contrast border color for prominent elements.
  /// Used for components such as input fields, button groups, and checkboxes that need clear definition.
  final Color primary;

  /// Medium contrast border color for standard elements.
  /// This is the most commonly used border color and is the default for most components
  /// such as file uploaders, cards like tables, and content dividers.
  final Color secondary;

  /// Low contrast border color for subtle elements.
  /// Useful for very subtle dividers and borders such as line and bar chart axis dividers.
  final Color tertiary;

  /// Default disabled border color for inactive elements.
  /// Used for disabled states in components such as input fields and checkboxes.
  final Color disabled;

  /// Subtle disabled border color with reduced emphasis.
  /// A more subtle (lower contrast) alternative for disabled borders such as disabled buttons.
  final Color disabledSubtle;

  /// Default brand border color for branded elements.
  /// Useful for active states in components such as input fields with brand focus states.
  final Color brand;

  /// Alternative brand border color that adapts to theme.
  /// A brand border color that switches to gray when in dark mode.
  /// Useful for components such as brand-style variants of banners and footers.
  final Color brandAlt;

  /// Default error semantic border color for error states.
  /// Used for error states in components such as input fields and file uploaders.
  final Color error;

  /// Subtle error border color with reduced emphasis.
  /// A more subtle (lower contrast) alternative for error state semantic borders
  /// such as error state input fields.
  final Color errorSubtle;

  /// Linearly interpolates between two [BorderColors] themes.
  static BorderColors lerp(BorderColors a, BorderColors b, double t) {
    return BorderColors(
      primary: Color.lerp(a.primary, b.primary, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      tertiary: Color.lerp(a.tertiary, b.tertiary, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
      disabledSubtle: Color.lerp(a.disabledSubtle, b.disabledSubtle, t)!,
      brand: Color.lerp(a.brand, b.brand, t)!,
      brandAlt: Color.lerp(a.brandAlt, b.brandAlt, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      errorSubtle: Color.lerp(a.errorSubtle, b.errorSubtle, t)!,
    );
  }
}
