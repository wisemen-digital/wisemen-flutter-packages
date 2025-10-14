import 'dart:ui';

/// [BackgroundColors] that holds colors used for backgrounds throughout the app.
/// Use background color variables to manage all fill colors for elements in your designs.
class BackgroundColors {
  /// Creates an instance of [BackgroundColors].
  const BackgroundColors({
    required this.primary,
    required this.primaryAlt,
    required this.primaryHover,
    required this.primarySolid,
    required this.secondary,
    required this.secondaryAlt,
    required this.secondaryHover,
    required this.secondarySubtle,
    required this.secondarySolid,
    required this.tertiary,
    required this.quaternary,
    required this.active,
    required this.disabled,
    required this.disabledSubtle,
    required this.overlay,
    required this.brandPrimary,
    required this.brandPrimaryAlt,
    required this.brandSecondary,
    required this.brandSolid,
    required this.brandSolidHover,
    required this.brandSection,
    required this.brandSectionSubtle,
    required this.errorPrimary,
    required this.errorSecondary,
    required this.errorSolid,
    required this.warningPrimary,
    required this.warningSecondary,
    required this.warningSolid,
    required this.successPrimary,
    required this.successSecondary,
    required this.successSolid,
  });

  /// Primary background color for most UI surfaces and containers.
  /// Used as the main background color for cards, modals, and primary content areas.
  final Color primary;

  /// Alternative primary background color for subtle variations.
  /// Used for secondary surfaces that need slight differentiation from primary.
  final Color primaryAlt;

  /// Primary background color on hover state.
  /// Applied when interactive primary surfaces are hovered over.
  final Color primaryHover;

  /// Solid primary background color for prominent elements.
  /// Used for elevated surfaces that need more visual weight than standard primary.
  final Color primarySolid;

  /// Secondary background color for supporting content areas.
  /// Used for sidebars, navigation panels, and secondary content containers.
  final Color secondary;

  /// Alternative secondary background color for subtle contrast.
  /// Used when multiple secondary surfaces need visual hierarchy.
  final Color secondaryAlt;

  /// Secondary background color on hover state.
  /// Applied when interactive secondary surfaces are hovered over.
  final Color secondaryHover;

  /// Subtle secondary background color for minimal emphasis.
  /// Used for very light background variations and subtle surface differentiation.
  final Color secondarySubtle;

  /// Solid secondary background color for defined sections.
  /// Used for well-defined secondary content areas that need clear boundaries.
  final Color secondarySolid;

  /// Tertiary background color for low-emphasis content.
  /// Used for supporting information areas and minimal visual impact surfaces.
  final Color tertiary;

  /// Quaternary background color for the most subtle backgrounds.
  /// Used for barely perceptible surface variations and ultra-low emphasis areas.
  final Color quaternary;

  /// Background color for active/selected states.
  /// Applied to indicate currently active or selected items in lists, tabs, or navigation.
  final Color active;

  /// Background color for disabled elements.
  /// Used for form fields, buttons, and other interactive elements in disabled state.
  final Color disabled;

  /// Subtle background color for disabled elements with reduced opacity.
  /// Used when disabled elements need less visual prominence.
  final Color disabledSubtle;

  /// Semi-transparent background color for overlays.
  /// Used for modal backdrops, tooltips, and other overlay surfaces.
  final Color overlay;

  /// Primary brand background color.
  /// Used for key brand surfaces and primary call-to-action elements.
  final Color brandPrimary;

  /// Alternative primary brand background color.
  /// Used for brand surfaces that need variation from the main brand primary.
  final Color brandPrimaryAlt;

  /// Secondary brand background color.
  /// Used for supporting brand elements and secondary brand surfaces.
  final Color brandSecondary;

  /// Solid brand background color for prominent brand elements.
  /// Used for high-impact brand surfaces like hero sections or key messaging areas.
  final Color brandSolid;

  /// Solid brand background color on hover state.
  /// Applied when interactive brand surfaces are hovered over.
  final Color brandSolidHover;

  /// Brand background color for sectional content.
  /// Used for brand-themed content sections and feature highlights.
  final Color brandSection;

  /// Subtle brand background color for minimal brand presence.
  /// Used for light brand touches and subtle brand-themed surfaces.
  final Color brandSectionSubtle;

  /// Primary error background color.
  /// Used for error messages, destructive actions, and critical alerts.
  final Color errorPrimary;

  /// Secondary error background color.
  /// Used for less critical error states and supporting error information.
  final Color errorSecondary;

  /// Solid error background color for prominent error states.
  /// Used for critical error banners and high-priority error surfaces.
  final Color errorSolid;

  /// Primary warning background color.
  /// Used for warning messages, caution states, and attention-grabbing alerts.
  final Color warningPrimary;

  /// Secondary warning background color.
  /// Used for less critical warning states and supporting warning information.
  final Color warningSecondary;

  /// Solid warning background color for prominent warning states.
  /// Used for important warning banners and high-priority warning surfaces.
  final Color warningSolid;

  /// Primary success background color.
  /// Used for success messages, completed actions, and positive confirmations.
  final Color successPrimary;

  /// Secondary success background color.
  /// Used for less prominent success states and supporting success information.
  final Color successSecondary;

  /// Solid success background color for prominent success states.
  /// Used for important success banners and high-priority success surfaces.
  final Color successSolid;

  /// Linearly interpolates between two [BackgroundColors] themes.
  static BackgroundColors lerp(
      BackgroundColors a, BackgroundColors b, double t) {
    return BackgroundColors(
      primary: Color.lerp(a.primary, b.primary, t)!,
      primaryAlt: Color.lerp(a.primaryAlt, b.primaryAlt, t)!,
      primaryHover: Color.lerp(a.primaryHover, b.primaryHover, t)!,
      primarySolid: Color.lerp(a.primarySolid, b.primarySolid, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      secondaryAlt: Color.lerp(a.secondaryAlt, b.secondaryAlt, t)!,
      secondaryHover: Color.lerp(a.secondaryHover, b.secondaryHover, t)!,
      secondarySubtle: Color.lerp(a.secondarySubtle, b.secondarySubtle, t)!,
      secondarySolid: Color.lerp(a.secondarySolid, b.secondarySolid, t)!,
      tertiary: Color.lerp(a.tertiary, b.tertiary, t)!,
      quaternary: Color.lerp(a.quaternary, b.quaternary, t)!,
      active: Color.lerp(a.active, b.active, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
      disabledSubtle: Color.lerp(a.disabledSubtle, b.disabledSubtle, t)!,
      overlay: Color.lerp(a.overlay, b.overlay, t)!,
      brandPrimary: Color.lerp(a.brandPrimary, b.brandPrimary, t)!,
      brandPrimaryAlt: Color.lerp(a.brandPrimaryAlt, b.brandPrimaryAlt, t)!,
      brandSecondary: Color.lerp(a.brandSecondary, b.brandSecondary, t)!,
      brandSolid: Color.lerp(a.brandSolid, b.brandSolid, t)!,
      brandSolidHover: Color.lerp(a.brandSolidHover, b.brandSolidHover, t)!,
      brandSection: Color.lerp(a.brandSection, b.brandSection, t)!,
      brandSectionSubtle:
          Color.lerp(a.brandSectionSubtle, b.brandSectionSubtle, t)!,
      errorPrimary: Color.lerp(a.errorPrimary, b.errorPrimary, t)!,
      errorSecondary: Color.lerp(a.errorSecondary, b.errorSecondary, t)!,
      errorSolid: Color.lerp(a.errorSolid, b.errorSolid, t)!,
      warningPrimary: Color.lerp(a.warningPrimary, b.warningPrimary, t)!,
      warningSecondary: Color.lerp(a.warningSecondary, b.warningSecondary, t)!,
      warningSolid: Color.lerp(a.warningSolid, b.warningSolid, t)!,
      successPrimary: Color.lerp(a.successPrimary, b.successPrimary, t)!,
      successSecondary: Color.lerp(a.successSecondary, b.successSecondary, t)!,
      successSolid: Color.lerp(a.successSolid, b.successSolid, t)!,
    );
  }
}
