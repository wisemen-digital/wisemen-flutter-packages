import 'dart:ui';

/// [TextColors] that holds colors used for all text throughout the app.
/// Use text color variables to manage all text fill colors in your designs across light and dark modes.
class TextColors {
  /// Creates an instance of [TextColors].
  const TextColors({
    required this.primary,
    required this.primaryOnBrand,
    required this.secondary,
    required this.secondaryHover,
    required this.secondaryOnBrand,
    required this.tertiary,
    required this.tertiaryHover,
    required this.tertiaryOnBrand,
    required this.quaternary,
    required this.quaternaryOnBrand,
    required this.white,
    required this.disabled,
    required this.placeholder,
    required this.placeholderSubtle,
    required this.brandPrimary,
    required this.brandSecondary,
    required this.brandTertiary,
    required this.brandTertiaryAlt,
    required this.errorPrimary,
    required this.warningPrimary,
    required this.successPrimary,
  });

  /// Primary text color for most important content.
  /// Used for page headings, main titles, and high-priority text that needs maximum emphasis and readability.
  final Color primary;

  /// Primary text color when used on solid brand color backgrounds.
  /// Commonly used for brand theme website sections like CTA sections and hero areas with brand backgrounds.
  final Color primaryOnBrand;

  /// Secondary text color for supporting content.
  /// Used for labels, section headings, and text that requires good readability but less emphasis than primary text.
  final Color secondary;

  /// Secondary text color in hover state.
  /// Applied when interactive secondary text elements are hovered over to provide visual feedback.
  final Color secondaryHover;

  /// Secondary text color when used on solid brand color backgrounds.
  /// Commonly used for brand theme website sections like CTA sections where secondary text appears on brand surfaces.
  final Color secondaryOnBrand;

  /// Tertiary text color for supporting information.
  /// Used for supporting text, paragraph text, and content that provides additional context with moderate emphasis.
  final Color tertiary;

  /// Tertiary text color in hover state.
  /// Applied when interactive tertiary text elements are hovered over to indicate interactivity.
  final Color tertiaryHover;

  /// Tertiary text color when used on solid brand color backgrounds.
  /// Commonly used for brand theme website sections like CTA sections where tertiary text appears on brand surfaces.
  final Color tertiaryOnBrand;

  /// Quaternary text color for subtle and low-contrast content.
  /// Used for footer column headings, captions, and text that requires minimal visual impact while maintaining readability.
  final Color quaternary;

  /// Quaternary text color when used on solid brand color backgrounds.
  /// Commonly used for brand theme website sections like footers where subtle text appears on brand surfaces.
  final Color quaternaryOnBrand;

  /// Text color that is always white, regardless of the theme mode.
  /// Used for text that must remain white in both light and dark modes, typically on dark or colored backgrounds.
  final Color white;

  /// Text color for disabled interactive elements.
  /// Used for disabled input fields, buttons, and other interactive elements that are currently unavailable.
  /// Provides sufficient contrast while clearly indicating the disabled state.
  final Color disabled;

  /// Text color for placeholder content in form fields.
  /// Used for input field placeholders and hint text that guides users on expected input.
  /// Offers good accessibility with higher contrast than subtle alternatives.
  final Color placeholder;

  /// More subtle placeholder text color with lower contrast.
  /// Used for components like verification code input fields where a lighter placeholder treatment is appropriate.
  final Color placeholderSubtle;

  /// Primary brand text color for key brand messaging.
  /// Used for headings in cards, pricing page headers, and other prominent brand-focused text elements.
  final Color brandPrimary;

  /// Secondary brand text color for accented content.
  /// Used for accented text, highlights, subheadings in blog post cards, and supporting brand messaging.
  final Color brandSecondary;

  /// Tertiary brand text color for lighter brand accents.
  /// Used for lighter accented text, highlights, and numbers in metric cards where brand presence is desired.
  final Color brandTertiary;

  /// Alternative tertiary brand text color.
  /// An alternative to tertiary brand text that provides different contrast in dark mode for metric cards and similar components.
  final Color brandTertiaryAlt;

  /// Primary error text color for error states and messaging.
  /// Used for input field error states, error messages, and other critical error communication.
  final Color errorPrimary;

  /// Primary warning text color for warning states and messaging.
  /// Used for warning messages, caution indicators, and attention-grabbing alert text.
  final Color warningPrimary;

  /// Primary success text color for success states and messaging.
  /// Used for success messages, confirmation text, and positive status indicators.
  final Color successPrimary;

  /// Linearly interpolates between two [TextColors] themes.
  static TextColors lerp(TextColors a, TextColors b, double t) {
    return TextColors(
      primary: Color.lerp(a.primary, b.primary, t)!,
      primaryOnBrand: Color.lerp(a.primaryOnBrand, b.primaryOnBrand, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      secondaryHover: Color.lerp(a.secondaryHover, b.secondaryHover, t)!,
      secondaryOnBrand: Color.lerp(a.secondaryOnBrand, b.secondaryOnBrand, t)!,
      tertiary: Color.lerp(a.tertiary, b.tertiary, t)!,
      tertiaryHover: Color.lerp(a.tertiaryHover, b.tertiaryHover, t)!,
      tertiaryOnBrand: Color.lerp(a.tertiaryOnBrand, b.tertiaryOnBrand, t)!,
      quaternary: Color.lerp(a.quaternary, b.quaternary, t)!,
      quaternaryOnBrand:
          Color.lerp(a.quaternaryOnBrand, b.quaternaryOnBrand, t)!,
      white: Color.lerp(a.white, b.white, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
      placeholder: Color.lerp(a.placeholder, b.placeholder, t)!,
      placeholderSubtle:
          Color.lerp(a.placeholderSubtle, b.placeholderSubtle, t)!,
      brandPrimary: Color.lerp(a.brandPrimary, b.brandPrimary, t)!,
      brandSecondary: Color.lerp(a.brandSecondary, b.brandSecondary, t)!,
      brandTertiary: Color.lerp(a.brandTertiary, b.brandTertiary, t)!,
      brandTertiaryAlt: Color.lerp(a.brandTertiaryAlt, b.brandTertiaryAlt, t)!,
      errorPrimary: Color.lerp(a.errorPrimary, b.errorPrimary, t)!,
      warningPrimary: Color.lerp(a.warningPrimary, b.warningPrimary, t)!,
      successPrimary: Color.lerp(a.successPrimary, b.successPrimary, t)!,
    );
  }
}
