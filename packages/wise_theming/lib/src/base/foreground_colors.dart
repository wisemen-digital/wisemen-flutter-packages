import 'dart:ui';

import '../colors/colors.dart';
import 'primitive_colors.dart';

/// Default implementation of [ForegroundColors] for light mode.
///
/// Provides a complete set of foreground colors for icons and UI elements,
/// based on [PrimitiveColors] with various intensity levels (primary through senary)
/// and semantic states, all optimized for light backgrounds.
class LightForegroundColors implements ForegroundColors {
  @override
  Color get primary => PrimitiveColors.gray[900]!;
  @override
  Color get secondary => PrimitiveColors.gray[700]!;
  @override
  Color get secondaryHover => PrimitiveColors.gray[800]!;
  @override
  Color get tertiary => PrimitiveColors.gray[600]!;
  @override
  Color get tertiaryHover => PrimitiveColors.gray[700]!;
  @override
  Color get quaternary => PrimitiveColors.gray[500]!;
  @override
  Color get quaternaryHover => PrimitiveColors.gray[600]!;
  @override
  Color get quinary => PrimitiveColors.gray[400]!;
  @override
  Color get quinaryHover => PrimitiveColors.gray[500]!;
  @override
  Color get senary => PrimitiveColors.gray[300]!;
  @override
  Color get white => PrimitiveColors.white;
  @override
  Color get disabled => PrimitiveColors.gray[400]!;
  @override
  Color get disabledSubtle => PrimitiveColors.gray[300]!;
  @override
  Color get brandPrimary => PrimitiveColors.brand[600]!;
  @override
  Color get brandPrimaryAlt => PrimitiveColors.brand[600]!;
  @override
  Color get brandSecondary => PrimitiveColors.brand[500]!;
  @override
  Color get errorPrimary => PrimitiveColors.error[600]!;
  @override
  Color get errorSecondary => PrimitiveColors.error[500]!;
  @override
  Color get warningPrimary => PrimitiveColors.warning[600]!;
  @override
  Color get warningSecondary => PrimitiveColors.warning[500]!;
  @override
  Color get successPrimary => PrimitiveColors.success[600]!;
  @override
  Color get successSecondary => PrimitiveColors.success[500]!;
}

/// Default implementation of [ForegroundColors] for dark mode.
///
/// Provides a complete set of foreground colors for icons and UI elements,
/// based on [PrimitiveColors] with various intensity levels (primary through senary)
/// and semantic states, all optimized for dark backgrounds.
class DarkForegroundColors implements ForegroundColors {
  @override
  Color get primary => PrimitiveColors.white;
  @override
  Color get secondary => PrimitiveColors.grayDark[300]!;
  @override
  Color get secondaryHover => PrimitiveColors.grayDark[200]!;
  @override
  Color get tertiary => PrimitiveColors.grayDark[400]!;
  @override
  Color get tertiaryHover => PrimitiveColors.grayDark[300]!;
  @override
  Color get quaternary => PrimitiveColors.grayDark[400]!;
  @override
  Color get quaternaryHover => PrimitiveColors.grayDark[300]!;
  @override
  Color get quinary => PrimitiveColors.grayDark[500]!;
  @override
  Color get quinaryHover => PrimitiveColors.grayDark[400]!;
  @override
  Color get senary => PrimitiveColors.grayDark[600]!;
  @override
  Color get white => PrimitiveColors.white;
  @override
  Color get disabled => PrimitiveColors.grayDark[500]!;
  @override
  Color get disabledSubtle => PrimitiveColors.grayDark[600]!;
  @override
  Color get brandPrimary => PrimitiveColors.brand[500]!;
  @override
  Color get brandPrimaryAlt => PrimitiveColors.grayDark[300]!;
  @override
  Color get brandSecondary => PrimitiveColors.brand[500]!;
  @override
  Color get errorPrimary => PrimitiveColors.error[500]!;
  @override
  Color get errorSecondary => PrimitiveColors.error[400]!;
  @override
  Color get warningPrimary => PrimitiveColors.warning[500]!;
  @override
  Color get warningSecondary => PrimitiveColors.warning[400]!;
  @override
  Color get successPrimary => PrimitiveColors.success[500]!;
  @override
  Color get successSecondary => PrimitiveColors.success[400]!;
}
