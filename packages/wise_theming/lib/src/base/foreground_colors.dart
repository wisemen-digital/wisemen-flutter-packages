import '../colors/colors.dart';
import 'primitive_colors.dart';

/// Default implementation of [ForegroundColors] for light mode.
///
/// Provides a complete set of foreground colors for icons and UI elements,
/// based on [PrimitiveColors] with various intensity levels (primary through senary)
/// and semantic states, all optimized for light backgrounds.
final lightForegroundColors = ForegroundColors(
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
  brandPrimary: PrimitiveColors.brand[600]!,
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
final darkForegroundColors = ForegroundColors(
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
  brandPrimary: PrimitiveColors.brand[500]!,
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
final highContrastLightForegroundColors = ForegroundColors(
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
  brandPrimary: PrimitiveColors.brand[700]!,
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
final highContrastDarkForegroundColors = ForegroundColors(
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
  brandPrimary: PrimitiveColors.brand[400]!,
  brandPrimaryAlt: PrimitiveColors.grayDark[200]!,
  brandSecondary: PrimitiveColors.brand[400]!,
  errorPrimary: PrimitiveColors.error[400]!,
  errorSecondary: PrimitiveColors.error[300]!,
  warningPrimary: PrimitiveColors.warning[400]!,
  warningSecondary: PrimitiveColors.warning[300]!,
  successPrimary: PrimitiveColors.success[400]!,
  successSecondary: PrimitiveColors.success[300]!,
);
