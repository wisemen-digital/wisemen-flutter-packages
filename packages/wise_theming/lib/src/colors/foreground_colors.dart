import 'dart:ui';

/// [ForegroundColors] that holds colors used for non-text foreground elements throughout the app.
/// Use foreground color variables to manage all non-text foreground elements in your designs across light and dark modes.
class ForegroundColors {
  /// Creates an instance of [ForegroundColors].
  const ForegroundColors({
    required this.primary,
    required this.secondary,
    required this.secondaryHover,
    required this.tertiary,
    required this.tertiaryHover,
    required this.quaternary,
    required this.quaternaryHover,
    required this.quinary,
    required this.quinaryHover,
    required this.senary,
    required this.white,
    required this.disabled,
    required this.disabledSubtle,
    required this.brandPrimary,
    required this.brandPrimaryAlt,
    required this.brandSecondary,
    required this.errorPrimary,
    required this.errorSecondary,
    required this.warningPrimary,
    required this.warningSecondary,
    required this.successPrimary,
    required this.successSecondary,
  });

  /// Highest contrast non-text foreground color for prominent elements.
  /// Used for the most important non-text foreground elements such as icons that need maximum visibility.
  final Color primary;

  /// High contrast non-text foreground color for secondary elements.
  /// Used for important non-text foreground elements such as icons that need strong visibility.
  final Color secondary;

  /// Secondary foreground color on hover state.
  /// Applied when interactive secondary foreground elements are hovered over.
  final Color secondaryHover;

  /// Medium contrast non-text foreground color for tertiary elements.
  /// Used for supporting non-text foreground elements such as icons with moderate emphasis.
  final Color tertiary;

  /// Tertiary foreground color on hover state.
  /// Applied when interactive tertiary foreground elements are hovered over.
  final Color tertiaryHover;

  /// Medium-low contrast non-text foreground color for quaternary elements.
  /// Used for less prominent non-text foreground elements such as icons with reduced emphasis.
  final Color quaternary;

  /// Quaternary foreground color on hover state.
  /// Applied when interactive quaternary foreground elements are hovered over.
  final Color quaternaryHover;

  /// Low contrast non-text foreground color for quinary elements.
  /// Used for subtle non-text foreground elements such as help icons that need minimal emphasis.
  final Color quinary;

  /// Quinary foreground color on hover state.
  /// Applied when interactive quinary foreground elements like help icons are hovered over.
  final Color quinaryHover;

  /// Lowest contrast non-text foreground color for senary elements.
  /// Used very sparingly for the most subtle non-text foreground elements such as breadcrumb divider icons and vector map elements.
  final Color senary;

  /// Pure white foreground color for elements that are always white.
  /// Used for foreground elements that remain white regardless of the current theme mode.
  final Color white;

  /// Default disabled foreground color for inactive elements.
  /// Used for non-text foreground elements such as icons in disabled button group buttons and input dropdown menu items.
  final Color disabled;

  /// Subtle disabled foreground color with reduced emphasis.
  /// A more subtle (lower contrast) alternative for non-text disabled foreground elements such as disabled active checkboxes and tag checkboxes.
  final Color disabledSubtle;

  /// Primary brand foreground color for brand elements.
  /// Used for primary brand color non-text foreground elements such as featured icons and progress bars.
  final Color brandPrimary;

  /// Alternative brand foreground color that adapts to theme.
  /// An alternative for primary brand color non-text foreground elements that switches to gray when in dark mode such as active horizontal tabs.
  final Color brandPrimaryAlt;

  /// Secondary brand foreground color for supporting brand elements.
  /// Used for secondary brand color non-text foreground elements such as accents and arrows in marketing site sections like hero header sections.
  final Color brandSecondary;

  /// Primary error semantic foreground color for error states.
  /// Used for primary error state color for non-text foreground elements such as featured icons.
  final Color errorPrimary;

  /// Secondary error semantic foreground color for supporting error states.
  /// Used for secondary error state color for non-text foreground elements such as icons in error state input fields and negative metrics item charts and icons.
  final Color errorSecondary;

  /// Primary warning semantic foreground color for warning states.
  /// Used for primary warning state color for non-text foreground elements such as featured icons.
  final Color warningPrimary;

  /// Secondary warning semantic foreground color for supporting warning states.
  /// Used for secondary warning state color for non-text foreground elements.
  final Color warningSecondary;

  /// Primary success semantic foreground color for success states.
  /// Used for primary success state color for non-text foreground elements such as featured icons.
  final Color successPrimary;

  /// Secondary success semantic foreground color for supporting success states.
  /// Used for secondary success state color for non-text foreground elements such as button dots, avatar online indicator dots, and positive metrics item charts and icons.
  final Color successSecondary;

  /// Linearly interpolates between two [ForegroundColors] themes.
  static ForegroundColors lerp(
      ForegroundColors a, ForegroundColors b, double t) {
    return ForegroundColors(
      primary: Color.lerp(a.primary, b.primary, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      secondaryHover: Color.lerp(a.secondaryHover, b.secondaryHover, t)!,
      tertiary: Color.lerp(a.tertiary, b.tertiary, t)!,
      tertiaryHover: Color.lerp(a.tertiaryHover, b.tertiaryHover, t)!,
      quaternary: Color.lerp(a.quaternary, b.quaternary, t)!,
      quaternaryHover: Color.lerp(a.quaternaryHover, b.quaternaryHover, t)!,
      quinary: Color.lerp(a.quinary, b.quinary, t)!,
      quinaryHover: Color.lerp(a.quinaryHover, b.quinaryHover, t)!,
      senary: Color.lerp(a.senary, b.senary, t)!,
      white: Color.lerp(a.white, b.white, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
      disabledSubtle: Color.lerp(a.disabledSubtle, b.disabledSubtle, t)!,
      brandPrimary: Color.lerp(a.brandPrimary, b.brandPrimary, t)!,
      brandPrimaryAlt: Color.lerp(a.brandPrimaryAlt, b.brandPrimaryAlt, t)!,
      brandSecondary: Color.lerp(a.brandSecondary, b.brandSecondary, t)!,
      errorPrimary: Color.lerp(a.errorPrimary, b.errorPrimary, t)!,
      errorSecondary: Color.lerp(a.errorSecondary, b.errorSecondary, t)!,
      warningPrimary: Color.lerp(a.warningPrimary, b.warningPrimary, t)!,
      warningSecondary: Color.lerp(a.warningSecondary, b.warningSecondary, t)!,
      successPrimary: Color.lerp(a.successPrimary, b.successPrimary, t)!,
      successSecondary: Color.lerp(a.successSecondary, b.successSecondary, t)!,
    );
  }
}
