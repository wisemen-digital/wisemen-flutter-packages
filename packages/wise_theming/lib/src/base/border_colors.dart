import '../colors/colors.dart';
import 'primitive_colors.dart';

/// Default implementation of [BorderColors] for light mode.
///
/// Provides a complete set of border colors based on [PrimitiveColors] gray
/// and brand color scales, optimized for light backgrounds.
final lightBorderColors = BorderColors(
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
final darkBorderColors = BorderColors(
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
final highContrastLightBorderColors = BorderColors(
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
final highContrastDarkBorderColors = BorderColors(
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
