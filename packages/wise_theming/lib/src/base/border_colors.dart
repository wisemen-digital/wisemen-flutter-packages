import 'dart:ui';

import '../colors/colors.dart';
import 'primitive_colors.dart';

/// Default implementation of [BorderColors] for light mode.
///
/// Provides a complete set of border colors based on [PrimitiveColors] gray
/// and brand color scales, optimized for light backgrounds.
class LightBorderColors implements BorderColors {
  @override
  Color get primary => PrimitiveColors.gray[300]!;
  @override
  Color get secondary => PrimitiveColors.gray[200]!;
  @override
  Color get tertiary => PrimitiveColors.gray[100]!;
  @override
  Color get disabled => PrimitiveColors.gray[300]!;
  @override
  Color get disabledSubtle => PrimitiveColors.gray[200]!;
  @override
  Color get brand => PrimitiveColors.brand[500]!;
  @override
  Color get brandAlt => PrimitiveColors.brand[600]!;
  @override
  Color get error => PrimitiveColors.error[500]!;
  @override
  Color get errorSubtle => PrimitiveColors.error[300]!;
}

/// Default implementation of [BorderColors] for dark mode.
///
/// Provides a complete set of border colors based on [PrimitiveColors] dark gray
/// and brand color scales, optimized for dark backgrounds.
class DarkBorderColors implements BorderColors {
  @override
  Color get primary => PrimitiveColors.grayDark[700]!;
  @override
  Color get secondary => PrimitiveColors.grayDark[800]!;
  @override
  Color get tertiary => PrimitiveColors.grayDark[800]!;
  @override
  Color get disabled => PrimitiveColors.grayDark[700]!;
  @override
  Color get disabledSubtle => PrimitiveColors.grayDark[800]!;
  @override
  Color get brand => PrimitiveColors.brand[400]!;
  @override
  Color get brandAlt => PrimitiveColors.grayDark[700]!;
  @override
  Color get error => PrimitiveColors.error[400]!;
  @override
  Color get errorSubtle => PrimitiveColors.error[400]!;
}
