import '../colors/colors.dart';
import 'primitive_colors.dart';

/// Default implementation of [TextColors] for light mode.
///
/// Provides a complete set of text colors based on [PrimitiveColors],
/// including various text hierarchies (primary, secondary, tertiary, etc.),
/// brand colors, and semantic states, all optimized for light backgrounds.
final lightTextColors = TextColors(
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
final darkTextColors = TextColors(
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
final highContrastLightTextColors = TextColors(
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
final highContrastDarkTextColors = TextColors(
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
