import 'package:flutter/material.dart';
import 'package:flutter_ultra_playground/flavors.dart';
import 'package:wise_theming/wise_theming.dart';

/// A class that holds the primitive color palette used throughout wise_theming.
///
/// This class provides a comprehensive set of color swatches with multiple shades
/// (25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950) for consistent
/// color usage across the application.
///
/// **This class is not meant to be instantiated.** All colors are provided as
/// static properties.
///
/// The colors are organized into categories:
/// - **Base colors**: [white], [black], [transparent]
/// - **Neutral colors**: [gray] (for light mode), [grayDark] (for dark mode)
/// - **Semantic colors**: [brand], [error], [warning], [success], [yellow]
///
/// Each color swatch uses a scale from 25 (lightest) to 950 (darkest), with
/// 500 typically representing the primary color value.
///
/// Example usage:
/// ```dart
/// // Using gray scale
/// Container(color: PrimitiveColors.gray[300])
///
/// // Using brand colors
/// Container(color: PrimitiveColors.brand[500])
///
/// // Using semantic colors
/// Container(color: PrimitiveColors.success[600])
/// ```
class PrimitiveColors {
  /// Pure white color (#FFFFFF).
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black color (#000000).
  static const Color black = Color(0xFF000000);

  /// Fully transparent color.
  static const Color transparent = Color(0x001F1F1F);

  /// Gray color scale optimized for light mode backgrounds.
  ///
  /// This swatch provides neutral gray tones that work well on light backgrounds.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light grays for subtle backgrounds
  /// - 200-400: Light to medium grays for borders and disabled states
  /// - 500-700: Medium to dark grays for secondary text and icons
  /// - 800-950: Very dark grays for primary text and emphasis
  static final MaterialColor gray = MaterialColor(
    0xFF697586, // 500
    <int, Color>{
      25: HexColor.fromString('#FCFCFD'),
      50: HexColor.fromString('#F8FAFC'),
      100: HexColor.fromString('#EEF2F6'),
      200: HexColor.fromString('#E3E8EF'),
      300: HexColor.fromString('#CDD5DF'),
      400: HexColor.fromString('#9AA4B2'),
      500: HexColor.fromString('#697586'),
      600: HexColor.fromString('#4B5565'),
      700: HexColor.fromString('#364152'),
      800: HexColor.fromString('#202939'),
      900: HexColor.fromString('#121926'),
      950: HexColor.fromString('#0D121C'),
    },
  );

  /// Gray color scale optimized for dark mode backgrounds.
  ///
  /// This swatch provides neutral gray tones that work well on dark backgrounds.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light grays for text and high-contrast elements
  /// - 200-400: Light to medium grays for secondary text and borders
  /// - 500-700: Medium grays for disabled states and subtle elements
  /// - 800-950: Very dark grays for backgrounds and surfaces
  static final MaterialColor grayDark = MaterialColor(
    0xFF9E9E9E, // 500
    <int, Color>{
      25: HexColor.fromString('#FAFAFA'),
      50: HexColor.fromString('#F7F7F7'),
      100: HexColor.fromString('#F0F0F1'),
      200: HexColor.fromString('#ECECED'),
      300: HexColor.fromString('#CECFD2'),
      400: HexColor.fromString('#94979C'),
      500: HexColor.fromString('#85888E'),
      600: HexColor.fromString('#61656C'),
      700: HexColor.fromString('#373A41'),
      800: HexColor.fromString('#22262F'),
      900: HexColor.fromString('#13161B'),
      950: HexColor.fromString('#0C0E12'),
    },
  );

  /// Brand color scale for primary brand identity.
  ///
  /// This swatch contains the primary brand colors for your application.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// The default brand color is blue. Override this by creating your own
  /// color implementations.
  ///
  /// Typical usage:
  /// - 25-100: Very light brand colors for backgrounds and subtle highlights
  /// - 400-600: Primary brand colors for buttons and call-to-action elements
  /// - 700-950: Dark brand colors for hover states and emphasis
  static final ColorSwatch<int> brand = ColorSwatch<int>(
    0xFF0B68FE, // 500
    <int, Color>{
      25: HexColor.fromString('#F5F8FF'),
      50: HexColor.fromString('#F0F5FF'),
      100: HexColor.fromString('#D0E1FF'),
      200: HexColor.fromString('#A9C7FF'),
      300: HexColor.fromString('#7AA9FE'),
      400: HexColor.fromString('#4A89FE'),
      500: HexColor.fromString('#0B68FE'),
      600: HexColor.fromString('#0146C6'),
      700: HexColor.fromString('#01328E'),
      800: HexColor.fromString('#002260'),
      900: HexColor.fromString('#00153D'),
      950: HexColor.fromString('#00071A'),
    },
  );

  /// Error color scale for error states and destructive actions.
  ///
  /// This swatch contains red-toned colors for indicating errors, failures,
  /// and destructive actions.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light reds for error message backgrounds
  /// - 500-600: Primary error colors for text and icons
  /// - 700-950: Dark error colors for emphasis and borders
  static final MaterialColor error = MaterialColor(
    0xFFDD4B50, // 500
    <int, Color>{
      25: HexColor.fromString('#FCEDEE'),
      50: HexColor.fromString('#F8DBDC'),
      100: HexColor.fromString('#F5C9CB'),
      200: HexColor.fromString('#F1B7B9'),
      300: HexColor.fromString('#EB9396'),
      400: HexColor.fromString('#E46F73'),
      500: HexColor.fromString('#DD4B50'),
      600: HexColor.fromString('#B13C40'),
      700: HexColor.fromString('#852D30'),
      800: HexColor.fromString('#581E20'),
      900: HexColor.fromString('#2C0F10'),
      950: HexColor.fromString('#160808'),
    },
  );

  /// Warning color scale for warning states and caution messages.
  ///
  /// This swatch contains orange-toned colors for indicating warnings,
  /// caution states, and important notices.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light oranges for warning message backgrounds
  /// - 500-600: Primary warning colors for text and icons
  /// - 700-950: Dark warning colors for emphasis
  static final MaterialColor warning = MaterialColor(
    0xFFF08C42, // 500
    <int, Color>{
      25: HexColor.fromString('#FEF4EC'),
      50: HexColor.fromString('#FCE8D9'),
      100: HexColor.fromString('#FBDDC6'),
      200: HexColor.fromString('#F9D1B3'),
      300: HexColor.fromString('#F6BA8E'),
      400: HexColor.fromString('#F3A368'),
      500: HexColor.fromString('#F08C42'),
      600: HexColor.fromString('#C47235'),
      700: HexColor.fromString('#985828'),
      800: HexColor.fromString('#6B3D1B'),
      900: HexColor.fromString('#3F230E'),
      950: HexColor.fromString('#291608'),
    },
  );

  /// Success color scale for success states and positive feedback.
  ///
  /// This swatch contains green-toned colors for indicating success,
  /// completion, and positive states.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light greens for success message backgrounds
  /// - 500-600: Primary success colors for text and icons
  /// - 700-950: Dark success colors for emphasis
  static final MaterialColor success = MaterialColor(
    0xFF17B26A, // 500
    <int, Color>{
      25: HexColor.fromString('#F6FEF9'),
      50: HexColor.fromString('#ECFDF3'),
      100: HexColor.fromString('#DCFAE6'),
      200: HexColor.fromString('#A9EFC5'),
      300: HexColor.fromString('#75E0A7'),
      400: HexColor.fromString('#47CD89'),
      500: HexColor.fromString('#17B26A'),
      600: HexColor.fromString('#079455'),
      700: HexColor.fromString('#067647'),
      800: HexColor.fromString('#085D3A'),
      900: HexColor.fromString('#074D31'),
      950: HexColor.fromString('#053321'),
    },
  );

  /// Yellow color scale for highlights and attention-grabbing elements.
  ///
  /// This swatch contains yellow-toned colors for highlighting information,
  /// drawing attention, and special states.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light yellows for subtle highlights
  /// - 400-600: Primary yellow colors for badges and notifications
  /// - 700-950: Dark yellows for text on light backgrounds
  static final MaterialColor yellow = MaterialColor(
    0xFFF6B93B, // 500
    <int, Color>{
      25: HexColor.fromString('#FEFAEE'),
      50: HexColor.fromString('#FDF4DC'),
      100: HexColor.fromString('#FDEFCB'),
      200: HexColor.fromString('#FCE9B9'),
      300: HexColor.fromString('#FADE97'),
      400: HexColor.fromString('#F9D374'),
      500: HexColor.fromString('#F7C851'),
      600: HexColor.fromString('#CCA441'),
      700: HexColor.fromString('#A18131'),
      800: HexColor.fromString('#755D21'),
      900: HexColor.fromString('#4A3A11'),
      950: HexColor.fromString('#352809'),
    },
  );
}

/// Extension on [Color] for parsing hexadecimal color strings.
///
/// This extension provides a utility method to create [Color] objects from
/// hex color strings commonly used in design systems.
extension HexColor on Color {
  /// Creates a [Color] from a hexadecimal string.
  ///
  /// Supports two formats:
  /// - `#RRGGBB` - 6 characters (RGB), alpha defaults to FF (fully opaque)
  /// - `#AARRGGBB` - 8 characters (ARGB), includes alpha channel
  ///
  /// The `#` prefix is optional and will be removed if present.
  ///
  /// Example:
  /// ```dart
  /// final red = HexColor.fromString('#FF0000');
  /// final semiTransparentBlue = HexColor.fromString('#8000FF00');
  /// ```
  static Color fromString(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

/// Default implementation of [BackgroundColors] for light mode.
///
/// Provides a comprehensive set of background colors based on [PrimitiveColors],
/// including surfaces, overlays, and various semantic states (hover, disabled, etc.),
/// all optimized for light mode.
late final lightBackgroundColors = BackgroundColors(
  primary: PrimitiveColors.white,
  primaryAlt: PrimitiveColors.white,
  primaryHover: PrimitiveColors.gray[50]!,
  primarySolid: PrimitiveColors.gray[950]!,
  secondary: PrimitiveColors.gray[50]!,
  secondaryAlt: PrimitiveColors.gray[50]!,
  secondaryHover: PrimitiveColors.gray[100]!,
  secondarySubtle: PrimitiveColors.gray[25]!,
  secondarySolid: PrimitiveColors.gray[600]!,
  tertiary: PrimitiveColors.gray[100]!,
  quaternary: PrimitiveColors.gray[200]!,
  active: PrimitiveColors.gray[50]!,
  disabled: PrimitiveColors.gray[100]!,
  disabledSubtle: PrimitiveColors.gray[50]!,
  overlay: PrimitiveColors.gray[950]!,
  brandPrimary: PrimitiveColors.brand[50]!,
  brandPrimaryAlt: PrimitiveColors.brand[50]!,
  brandSecondary: PrimitiveColors.brand[100]!,
  brandSolid: PrimitiveColors.brand[600]!,
  brandSolidHover: PrimitiveColors.brand[700]!,
  brandSection: PrimitiveColors.brand[800]!,
  brandSectionSubtle: PrimitiveColors.brand[700]!,
  errorPrimary: PrimitiveColors.error[50]!,
  errorSecondary: PrimitiveColors.error[100]!,
  errorSolid: PrimitiveColors.error[600]!,
  warningPrimary: PrimitiveColors.warning[50]!,
  warningSecondary: PrimitiveColors.warning[100]!,
  warningSolid: PrimitiveColors.warning[600]!,
  successPrimary: PrimitiveColors.success[50]!,
  successSecondary: PrimitiveColors.success[100]!,
  successSolid: PrimitiveColors.success[600]!,
);

/// Default implementation of [BackgroundColors] for dark mode.
///
/// Provides a comprehensive set of background colors based on [PrimitiveColors],
/// including surfaces, overlays, and various semantic states (hover, disabled, etc.),
/// all optimized for dark mode.
late final darkBackgroundColors = BackgroundColors(
  primary: PrimitiveColors.grayDark[950]!,
  primaryAlt: PrimitiveColors.grayDark[900]!,
  primaryHover: PrimitiveColors.grayDark[800]!,
  primarySolid: PrimitiveColors.grayDark[900]!,
  secondary: PrimitiveColors.grayDark[900]!,
  secondaryAlt: PrimitiveColors.grayDark[950]!,
  secondaryHover: PrimitiveColors.grayDark[800]!,
  secondarySubtle: PrimitiveColors.grayDark[600]!,
  secondarySolid: PrimitiveColors.grayDark[600]!,
  tertiary: PrimitiveColors.grayDark[800]!,
  quaternary: PrimitiveColors.grayDark[700]!,
  active: PrimitiveColors.grayDark[800]!,
  disabled: PrimitiveColors.grayDark[800]!,
  disabledSubtle: PrimitiveColors.grayDark[900]!,
  overlay: PrimitiveColors.grayDark[800]!,
  brandPrimary: PrimitiveColors.brand[500]!,
  brandPrimaryAlt: PrimitiveColors.grayDark[800]!,
  brandSecondary: PrimitiveColors.brand[600]!,
  brandSolid: PrimitiveColors.brand[600]!,
  brandSolidHover: PrimitiveColors.brand[500]!,
  brandSection: PrimitiveColors.grayDark[800]!,
  brandSectionSubtle: PrimitiveColors.grayDark[950]!,
  errorPrimary: PrimitiveColors.error[500]!,
  errorSecondary: PrimitiveColors.error[600]!,
  errorSolid: PrimitiveColors.error[600]!,
  warningPrimary: PrimitiveColors.warning[500]!,
  warningSecondary: PrimitiveColors.warning[600]!,
  warningSolid: PrimitiveColors.warning[600]!,
  successPrimary: PrimitiveColors.success[500]!,
  successSecondary: PrimitiveColors.success[600]!,
  successSolid: PrimitiveColors.success[600]!,
);

/// High contrast implementation of [BackgroundColors] for light mode.
///
/// Provides enhanced contrast colors for better accessibility, using more
/// distinct background colors based on [PrimitiveColors], with increased
/// contrast ratios between surfaces and text for improved readability.
late final highContrastLightBackgroundColors = BackgroundColors(
  primary: PrimitiveColors.white,
  primaryAlt: PrimitiveColors.white,
  primaryHover: PrimitiveColors.gray[25]!,
  primarySolid: PrimitiveColors.black,
  secondary: PrimitiveColors.gray[25]!,
  secondaryAlt: PrimitiveColors.gray[25]!,
  secondaryHover: PrimitiveColors.gray[50]!,
  secondarySubtle: PrimitiveColors.white,
  secondarySolid: PrimitiveColors.gray[800]!,
  tertiary: PrimitiveColors.gray[50]!,
  quaternary: PrimitiveColors.gray[100]!,
  active: PrimitiveColors.gray[25]!,
  disabled: PrimitiveColors.gray[200]!,
  disabledSubtle: PrimitiveColors.gray[100]!,
  overlay: PrimitiveColors.black,
  brandPrimary: PrimitiveColors.brand[25]!,
  brandPrimaryAlt: PrimitiveColors.brand[25]!,
  brandSecondary: PrimitiveColors.brand[50]!,
  brandSolid: PrimitiveColors.brand[700]!,
  brandSolidHover: PrimitiveColors.brand[800]!,
  brandSection: PrimitiveColors.brand[900]!,
  brandSectionSubtle: PrimitiveColors.brand[800]!,
  errorPrimary: PrimitiveColors.error[25]!,
  errorSecondary: PrimitiveColors.error[50]!,
  errorSolid: PrimitiveColors.error[700]!,
  warningPrimary: PrimitiveColors.warning[25]!,
  warningSecondary: PrimitiveColors.warning[50]!,
  warningSolid: PrimitiveColors.warning[700]!,
  successPrimary: PrimitiveColors.success[25]!,
  successSecondary: PrimitiveColors.success[50]!,
  successSolid: PrimitiveColors.success[700]!,
);

/// High contrast implementation of [BackgroundColors] for dark mode.
///
/// Provides enhanced contrast colors for better accessibility in dark mode,
/// using more distinct background colors based on [PrimitiveColors], with
/// increased contrast ratios and darker backgrounds for improved readability.
late final highContrastDarkBackgroundColors = BackgroundColors(
  primary: PrimitiveColors.black,
  primaryAlt: PrimitiveColors.grayDark[950]!,
  primaryHover: PrimitiveColors.grayDark[900]!,
  primarySolid: PrimitiveColors.white,
  secondary: PrimitiveColors.grayDark[950]!,
  secondaryAlt: PrimitiveColors.black,
  secondaryHover: PrimitiveColors.grayDark[800]!,
  secondarySubtle: PrimitiveColors.grayDark[900]!,
  secondarySolid: PrimitiveColors.grayDark[300]!,
  tertiary: PrimitiveColors.grayDark[900]!,
  quaternary: PrimitiveColors.grayDark[800]!,
  active: PrimitiveColors.grayDark[900]!,
  disabled: PrimitiveColors.grayDark[900]!,
  disabledSubtle: PrimitiveColors.grayDark[950]!,
  overlay: PrimitiveColors.grayDark[700]!,
  brandPrimary: PrimitiveColors.brand[400]!,
  brandPrimaryAlt: PrimitiveColors.grayDark[900]!,
  brandSecondary: PrimitiveColors.brand[500]!,
  brandSolid: PrimitiveColors.brand[500]!,
  brandSolidHover: PrimitiveColors.brand[400]!,
  brandSection: PrimitiveColors.grayDark[900]!,
  brandSectionSubtle: PrimitiveColors.black,
  errorPrimary: PrimitiveColors.error[400]!,
  errorSecondary: PrimitiveColors.error[500]!,
  errorSolid: PrimitiveColors.error[500]!,
  warningPrimary: PrimitiveColors.warning[400]!,
  warningSecondary: PrimitiveColors.warning[500]!,
  warningSolid: PrimitiveColors.warning[500]!,
  successPrimary: PrimitiveColors.success[400]!,
  successSecondary: PrimitiveColors.success[500]!,
  successSolid: PrimitiveColors.success[500]!,
);

/// Default implementation of [BorderColors] for light mode.
///
/// Provides a complete set of border colors based on [PrimitiveColors] gray
/// and brand color scales, optimized for light backgrounds.
late final lightBorderColors = BorderColors(
  primary: PrimitiveColors.gray[300]!,
  secondary: PrimitiveColors.gray[200]!,
  tertiary: PrimitiveColors.gray[100]!,
  disabled: PrimitiveColors.gray[300]!,
  disabledSubtle: PrimitiveColors.gray[200]!,
  brand: PrimitiveColors.brand[500]!,
  brandAlt: PrimitiveColors.brand[600]!,
  error: PrimitiveColors.error[500]!,
  errorSubtle: PrimitiveColors.error[300]!,
);

/// Default implementation of [BorderColors] for dark mode.
///
/// Provides a complete set of border colors based on [PrimitiveColors] dark gray
/// and brand color scales, optimized for dark backgrounds.
late final darkBorderColors = BorderColors(
  primary: PrimitiveColors.grayDark[700]!,
  secondary: PrimitiveColors.grayDark[800]!,
  tertiary: PrimitiveColors.grayDark[800]!,
  disabled: PrimitiveColors.grayDark[700]!,
  disabledSubtle: PrimitiveColors.grayDark[800]!,
  brand: PrimitiveColors.brand[400]!,
  brandAlt: PrimitiveColors.grayDark[700]!,
  error: PrimitiveColors.error[400]!,
  errorSubtle: PrimitiveColors.error[400]!,
);

/// High contrast implementation of [BorderColors] for light mode.
///
/// Provides enhanced contrast border colors for better accessibility,
/// using more distinct border colors for improved visual separation.
late final highContrastLightBorderColors = BorderColors(
  primary: PrimitiveColors.gray[400]!,
  secondary: PrimitiveColors.gray[300]!,
  tertiary: PrimitiveColors.gray[200]!,
  disabled: PrimitiveColors.gray[400]!,
  disabledSubtle: PrimitiveColors.gray[300]!,
  brand: PrimitiveColors.brand[600]!,
  brandAlt: PrimitiveColors.brand[700]!,
  error: PrimitiveColors.error[600]!,
  errorSubtle: PrimitiveColors.error[400]!,
);

/// High contrast implementation of [BorderColors] for dark mode.
///
/// Provides enhanced contrast border colors for better accessibility in dark mode,
/// using brighter border colors for improved visual separation.
late final highContrastDarkBorderColors = BorderColors(
  primary: PrimitiveColors.grayDark[600]!,
  secondary: PrimitiveColors.grayDark[700]!,
  tertiary: PrimitiveColors.grayDark[700]!,
  disabled: PrimitiveColors.grayDark[600]!,
  disabledSubtle: PrimitiveColors.grayDark[700]!,
  brand: PrimitiveColors.brand[300]!,
  brandAlt: PrimitiveColors.grayDark[600]!,
  error: PrimitiveColors.error[300]!,
  errorSubtle: PrimitiveColors.error[300]!,
);

/// Default implementation of [ForegroundColors] for light mode.
///
/// Provides a complete set of foreground colors for icons and UI elements,
/// based on [PrimitiveColors] with various intensity levels (primary through senary)
/// and semantic states, all optimized for light backgrounds.
late final lightForegroundColors = ForegroundColors(
  primary: PrimitiveColors.gray[900]!,
  secondary: PrimitiveColors.gray[700]!,
  secondaryHover: PrimitiveColors.gray[800]!,
  tertiary: PrimitiveColors.gray[600]!,
  tertiaryHover: PrimitiveColors.gray[700]!,
  quaternary: PrimitiveColors.gray[500]!,
  quaternaryHover: PrimitiveColors.gray[600]!,
  quinary: PrimitiveColors.gray[400]!,
  quinaryHover: PrimitiveColors.gray[500]!,
  senary: PrimitiveColors.gray[300]!,
  white: PrimitiveColors.white,
  disabled: PrimitiveColors.gray[400]!,
  disabledSubtle: PrimitiveColors.gray[300]!,
  brandPrimary: HexColor.fromString(F.config?.brandColor ?? '#000000'),
  brandPrimaryAlt: PrimitiveColors.brand[600]!,
  brandSecondary: PrimitiveColors.brand[500]!,
  errorPrimary: PrimitiveColors.error[600]!,
  errorSecondary: PrimitiveColors.error[500]!,
  warningPrimary: PrimitiveColors.warning[600]!,
  warningSecondary: PrimitiveColors.warning[500]!,
  successPrimary: PrimitiveColors.success[600]!,
  successSecondary: PrimitiveColors.success[500]!,
);

/// Default implementation of [ForegroundColors] for dark mode.
///
/// Provides a complete set of foreground colors for icons and UI elements,
/// based on [PrimitiveColors] with various intensity levels (primary through senary)
/// and semantic states, all optimized for dark backgrounds.
late final darkForegroundColors = ForegroundColors(
  primary: PrimitiveColors.white,
  secondary: PrimitiveColors.grayDark[300]!,
  secondaryHover: PrimitiveColors.grayDark[200]!,
  tertiary: PrimitiveColors.grayDark[400]!,
  tertiaryHover: PrimitiveColors.grayDark[300]!,
  quaternary: PrimitiveColors.grayDark[400]!,
  quaternaryHover: PrimitiveColors.grayDark[300]!,
  quinary: PrimitiveColors.grayDark[500]!,
  quinaryHover: PrimitiveColors.grayDark[400]!,
  senary: PrimitiveColors.grayDark[600]!,
  white: PrimitiveColors.white,
  disabled: PrimitiveColors.grayDark[500]!,
  disabledSubtle: PrimitiveColors.grayDark[600]!,
  brandPrimary: HexColor.fromString(F.config?.brandColor ?? '#FFFFFF'),
  brandPrimaryAlt: PrimitiveColors.grayDark[300]!,
  brandSecondary: PrimitiveColors.brand[500]!,
  errorPrimary: PrimitiveColors.error[500]!,
  errorSecondary: PrimitiveColors.error[400]!,
  warningPrimary: PrimitiveColors.warning[500]!,
  warningSecondary: PrimitiveColors.warning[400]!,
  successPrimary: PrimitiveColors.success[500]!,
  successSecondary: PrimitiveColors.success[400]!,
);

/// High contrast implementation of [ForegroundColors] for light mode.
///
/// Provides enhanced contrast foreground colors for icons and UI elements,
/// using higher contrast ratios for improved accessibility and readability.
late final highContrastLightForegroundColors = ForegroundColors(
  primary: PrimitiveColors.black,
  secondary: PrimitiveColors.gray[800]!,
  secondaryHover: PrimitiveColors.black,
  tertiary: PrimitiveColors.gray[700]!,
  tertiaryHover: PrimitiveColors.gray[800]!,
  quaternary: PrimitiveColors.gray[600]!,
  quaternaryHover: PrimitiveColors.gray[700]!,
  quinary: PrimitiveColors.gray[500]!,
  quinaryHover: PrimitiveColors.gray[600]!,
  senary: PrimitiveColors.gray[400]!,
  white: PrimitiveColors.white,
  disabled: PrimitiveColors.gray[500]!,
  disabledSubtle: PrimitiveColors.gray[400]!,
  brandPrimary: HexColor.fromString(F.config?.brandColor ?? '#000000'),
  brandPrimaryAlt: PrimitiveColors.brand[700]!,
  brandSecondary: PrimitiveColors.brand[600]!,
  errorPrimary: PrimitiveColors.error[700]!,
  errorSecondary: PrimitiveColors.error[600]!,
  warningPrimary: PrimitiveColors.warning[700]!,
  warningSecondary: PrimitiveColors.warning[600]!,
  successPrimary: PrimitiveColors.success[700]!,
  successSecondary: PrimitiveColors.success[600]!,
);

/// High contrast implementation of [ForegroundColors] for dark mode.
///
/// Provides enhanced contrast foreground colors for icons and UI elements in dark mode,
/// using brighter colors and higher contrast ratios for improved accessibility.
late final highContrastDarkForegroundColors = ForegroundColors(
  primary: PrimitiveColors.white,
  secondary: PrimitiveColors.grayDark[200]!,
  secondaryHover: PrimitiveColors.white,
  tertiary: PrimitiveColors.grayDark[300]!,
  tertiaryHover: PrimitiveColors.grayDark[200]!,
  quaternary: PrimitiveColors.grayDark[300]!,
  quaternaryHover: PrimitiveColors.grayDark[200]!,
  quinary: PrimitiveColors.grayDark[400]!,
  quinaryHover: PrimitiveColors.grayDark[300]!,
  senary: PrimitiveColors.grayDark[500]!,
  white: PrimitiveColors.white,
  disabled: PrimitiveColors.grayDark[600]!,
  disabledSubtle: PrimitiveColors.grayDark[700]!,
  brandPrimary: HexColor.fromString(F.config?.brandColor ?? '#FFFFFF'),
  brandPrimaryAlt: PrimitiveColors.grayDark[200]!,
  brandSecondary: PrimitiveColors.brand[400]!,
  errorPrimary: PrimitiveColors.error[400]!,
  errorSecondary: PrimitiveColors.error[300]!,
  warningPrimary: PrimitiveColors.warning[400]!,
  warningSecondary: PrimitiveColors.warning[300]!,
  successPrimary: PrimitiveColors.success[400]!,
  successSecondary: PrimitiveColors.success[300]!,
);

/// Default implementation of [TextColors] for light mode.
///
/// Provides a complete set of text colors based on [PrimitiveColors],
/// including various text hierarchies (primary, secondary, tertiary, etc.),
/// brand colors, and semantic states, all optimized for light backgrounds.
late final lightTextColors = TextColors(
  primary: PrimitiveColors.gray[900]!,
  primaryOnBrand: PrimitiveColors.white,
  secondary: PrimitiveColors.gray[700]!,
  secondaryOnBrand: PrimitiveColors.brand[200]!,
  secondaryHover: PrimitiveColors.gray[800]!,
  tertiary: PrimitiveColors.gray[600]!,
  tertiaryHover: PrimitiveColors.gray[700]!,
  tertiaryOnBrand: PrimitiveColors.brand[200]!,
  quaternary: PrimitiveColors.gray[500]!,
  quaternaryOnBrand: PrimitiveColors.brand[300]!,
  white: PrimitiveColors.white,
  disabled: PrimitiveColors.gray[500]!,
  placeholder: PrimitiveColors.gray[500]!,
  placeholderSubtle: PrimitiveColors.gray[300]!,
  brandPrimary: PrimitiveColors.brand[900]!,
  brandSecondary: PrimitiveColors.brand[700]!,
  brandTertiary: PrimitiveColors.brand[600]!,
  brandTertiaryAlt: PrimitiveColors.brand[600]!,
  errorPrimary: PrimitiveColors.error[600]!,
  warningPrimary: PrimitiveColors.warning[600]!,
  successPrimary: PrimitiveColors.success[600]!,
);

/// Default implementation of [TextColors] for dark mode.
///
/// Provides a complete set of text colors based on [PrimitiveColors],
/// including various text hierarchies (primary, secondary, tertiary, etc.),
/// brand colors, and semantic states, all optimized for dark backgrounds.
late final darkTextColors = TextColors(
  primary: PrimitiveColors.grayDark[50]!,
  primaryOnBrand: PrimitiveColors.grayDark[50]!,
  secondary: PrimitiveColors.grayDark[200]!,
  secondaryOnBrand: PrimitiveColors.grayDark[300]!,
  secondaryHover: PrimitiveColors.grayDark[100]!,
  tertiary: PrimitiveColors.grayDark[400]!,
  tertiaryHover: PrimitiveColors.grayDark[300]!,
  tertiaryOnBrand: PrimitiveColors.grayDark[400]!,
  quaternary: PrimitiveColors.grayDark[400]!,
  quaternaryOnBrand: PrimitiveColors.grayDark[400]!,
  white: PrimitiveColors.white,
  disabled: PrimitiveColors.grayDark[500]!,
  placeholder: PrimitiveColors.grayDark[400]!,
  placeholderSubtle: PrimitiveColors.grayDark[700]!,
  brandPrimary: PrimitiveColors.grayDark[50]!,
  brandSecondary: PrimitiveColors.grayDark[300]!,
  brandTertiary: PrimitiveColors.grayDark[400]!,
  brandTertiaryAlt: PrimitiveColors.grayDark[50]!,
  errorPrimary: PrimitiveColors.error[400]!,
  warningPrimary: PrimitiveColors.warning[400]!,
  successPrimary: PrimitiveColors.success[400]!,
);

/// High contrast implementation of [TextColors] for light mode.
///
/// Provides enhanced contrast text colors for better accessibility, using
/// higher contrast ratios between text and backgrounds for improved readability.
late final highContrastLightTextColors = TextColors(
  primary: PrimitiveColors.black,
  primaryOnBrand: PrimitiveColors.white,
  secondary: PrimitiveColors.gray[800]!,
  secondaryOnBrand: PrimitiveColors.brand[100]!,
  secondaryHover: PrimitiveColors.black,
  tertiary: PrimitiveColors.gray[700]!,
  tertiaryHover: PrimitiveColors.gray[800]!,
  tertiaryOnBrand: PrimitiveColors.brand[100]!,
  quaternary: PrimitiveColors.gray[600]!,
  quaternaryOnBrand: PrimitiveColors.brand[200]!,
  white: PrimitiveColors.white,
  disabled: PrimitiveColors.gray[600]!,
  placeholder: PrimitiveColors.gray[600]!,
  placeholderSubtle: PrimitiveColors.gray[400]!,
  brandPrimary: PrimitiveColors.brand[950]!,
  brandSecondary: PrimitiveColors.brand[800]!,
  brandTertiary: PrimitiveColors.brand[700]!,
  brandTertiaryAlt: PrimitiveColors.brand[700]!,
  errorPrimary: PrimitiveColors.error[700]!,
  warningPrimary: PrimitiveColors.warning[700]!,
  successPrimary: PrimitiveColors.success[700]!,
);

/// High contrast implementation of [TextColors] for dark mode.
///
/// Provides enhanced contrast text colors for better accessibility in dark mode,
/// using higher contrast ratios and brighter text colors for improved readability.
late final highContrastDarkTextColors = TextColors(
  primary: PrimitiveColors.white,
  primaryOnBrand: PrimitiveColors.white,
  secondary: PrimitiveColors.grayDark[100]!,
  secondaryOnBrand: PrimitiveColors.grayDark[200]!,
  secondaryHover: PrimitiveColors.white,
  tertiary: PrimitiveColors.grayDark[200]!,
  tertiaryHover: PrimitiveColors.grayDark[100]!,
  tertiaryOnBrand: PrimitiveColors.grayDark[300]!,
  quaternary: PrimitiveColors.grayDark[300]!,
  quaternaryOnBrand: PrimitiveColors.grayDark[300]!,
  white: PrimitiveColors.white,
  disabled: PrimitiveColors.grayDark[600]!,
  placeholder: PrimitiveColors.grayDark[500]!,
  placeholderSubtle: PrimitiveColors.grayDark[700]!,
  brandPrimary: PrimitiveColors.white,
  brandSecondary: PrimitiveColors.grayDark[200]!,
  brandTertiary: PrimitiveColors.grayDark[300]!,
  brandTertiaryAlt: PrimitiveColors.white,
  errorPrimary: PrimitiveColors.error[300]!,
  warningPrimary: PrimitiveColors.warning[300]!,
  successPrimary: PrimitiveColors.success[300]!,
);

/// Default implementation of [UtilityColors] for dark mode.
///
/// Provides a set of vibrant utility colors for special purposes like
/// badges, status indicators, and categorization in dark mode.
const UtilityColors darkUtilityColors = UtilityColors(
  teal: Color(0xFF2ED3B7),
  blue: Color(0xFF4A89FE),
  orange: Color(0xFFF38744),
  pink: Color(0xFFF670C7),
  purple: Color(0xFF9B8AFB),
  green: Color(0xFF4ADE80),
  indigo: Color(0xFF6366F1),
  red: Color(0xFFEF4444),
  yellow: Color(0xFFFBBF24),
);

/// Default implementation of [UtilityColors] for light mode.
///
/// Provides a set of vibrant utility colors for special purposes like
/// badges, status indicators, and categorization in light mode.
const UtilityColors lightUtilityColors = UtilityColors(
  teal: Color(0xFF2ED3B7),
  blue: Color(0xFF4A89FE),
  orange: Color(0xFFF38744),
  pink: Color(0xFFF670C7),
  purple: Color(0xFF9B8AFB),
  green: Color(0xFF4ADE80),
  indigo: Color(0xFF6366F1),
  red: Color(0xFFEF4444),
  yellow: Color(0xFFFBBF24),
);

/// High contrast implementation of [UtilityColors] for light mode.
///
/// Provides enhanced contrast utility colors for better accessibility in light mode,
/// using more vibrant and distinct colors for badges, status indicators, and categorization.
const UtilityColors highContrastLightUtilityColors = UtilityColors(
  teal: Color(0xFF059669),
  blue: Color(0xFF1D4ED8),
  orange: Color(0xFFEA580C),
  pink: Color(0xFFBE185D),
  purple: Color(0xFF7C3AED),
  green: Color(0xFF16A34A),
  indigo: Color(0xFF4338CA),
  red: Color(0xFFDC2626),
  yellow: Color(0xFFCA8A04),
);

/// High contrast implementation of [UtilityColors] for dark mode.
///
/// Provides enhanced contrast utility colors for better accessibility in dark mode,
/// using brighter and more distinct colors for badges, status indicators, and categorization.
const UtilityColors highContrastDarkUtilityColors = UtilityColors(
  teal: Color(0xFF14B8A6),
  blue: Color(0xFF3B82F6),
  orange: Color(0xFFF97316),
  pink: Color(0xFFEC4899),
  purple: Color(0xFF8B5CF6),
  green: Color(0xFF22C55E),
  indigo: Color(0xFF6366F1),
  red: Color(0xFFEF4444),
  yellow: Color(0xFFF59E0B),
);

late final _baseLightTheme = WiseTheme(
  identifier: 'Base theme',
  themeType: WiseThemeType.light,
  textColors: lightTextColors,
  foregroundColors: lightForegroundColors,
  borderColors: lightBorderColors,
  backgroundColors: lightBackgroundColors,
  utilityColors: lightUtilityColors,
);

late final _baseDarkTheme = WiseTheme(
  identifier: 'Base dark theme',
  themeType: WiseThemeType.dark,
  textColors: darkTextColors,
  foregroundColors: darkForegroundColors,
  borderColors: darkBorderColors,
  backgroundColors: darkBackgroundColors,
  utilityColors: darkUtilityColors,
);

late final _highContrastLightTheme = WiseTheme(
  identifier: 'High contrast theme',
  themeType: WiseThemeType.lightContrast,
  textColors: highContrastLightTextColors,
  foregroundColors: highContrastLightForegroundColors,
  borderColors: highContrastLightBorderColors,
  backgroundColors: highContrastLightBackgroundColors,
  utilityColors: highContrastLightUtilityColors,
);

late final _highContrastDarkTheme = WiseTheme(
  identifier: 'High contrast dark theme',
  themeType: WiseThemeType.darkContrast,
  textColors: highContrastDarkTextColors,
  foregroundColors: highContrastDarkForegroundColors,
  borderColors: highContrastDarkBorderColors,
  backgroundColors: highContrastDarkBackgroundColors,
  utilityColors: highContrastDarkUtilityColors,
);

late final List<WiseTheme> brandedThemes = [_baseLightTheme, _baseDarkTheme, _highContrastLightTheme, _highContrastDarkTheme];
