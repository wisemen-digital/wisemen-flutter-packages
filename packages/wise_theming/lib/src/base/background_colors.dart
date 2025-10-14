import 'dart:ui';

import '../colors/colors.dart';
import 'primitive_colors.dart';

/// Default implementation of [BackgroundColors] for light mode.
///
/// Provides a comprehensive set of background colors based on [PrimitiveColors],
/// including surfaces, overlays, and various semantic states (hover, disabled, etc.),
/// all optimized for light mode.
class LightBackgroundColors implements BackgroundColors {
  @override
  Color get primary => PrimitiveColors.white;
  @override
  Color get primaryAlt => PrimitiveColors.white;
  @override
  Color get primaryHover => PrimitiveColors.gray[50]!;
  @override
  Color get primarySolid => PrimitiveColors.gray[950]!;
  @override
  Color get secondary => PrimitiveColors.gray[50]!;
  @override
  Color get secondaryAlt => PrimitiveColors.gray[50]!;
  @override
  Color get secondaryHover => PrimitiveColors.gray[100]!;
  @override
  Color get secondarySubtle => PrimitiveColors.gray[25]!;
  @override
  Color get secondarySolid => PrimitiveColors.gray[600]!;
  @override
  Color get tertiary => PrimitiveColors.gray[100]!;
  @override
  Color get quaternary => PrimitiveColors.gray[200]!;
  @override
  Color get active => PrimitiveColors.gray[50]!;
  @override
  Color get disabled => PrimitiveColors.gray[100]!;
  @override
  Color get disabledSubtle => PrimitiveColors.gray[50]!;
  @override
  Color get overlay => PrimitiveColors.gray[950]!;
  @override
  Color get brandPrimary => PrimitiveColors.brand[50]!;
  @override
  Color get brandPrimaryAlt => PrimitiveColors.brand[50]!;
  @override
  Color get brandSecondary => PrimitiveColors.brand[100]!;
  @override
  Color get brandSolid => PrimitiveColors.brand[600]!;
  @override
  Color get brandSolidHover => PrimitiveColors.brand[700]!;
  @override
  Color get brandSection => PrimitiveColors.brand[800]!;
  @override
  Color get brandSectionSubtle => PrimitiveColors.brand[700]!;
  @override
  Color get errorPrimary => PrimitiveColors.error[50]!;
  @override
  Color get errorSecondary => PrimitiveColors.error[100]!;
  @override
  Color get errorSolid => PrimitiveColors.error[600]!;
  @override
  Color get warningPrimary => PrimitiveColors.warning[50]!;
  @override
  Color get warningSecondary => PrimitiveColors.warning[100]!;
  @override
  Color get warningSolid => PrimitiveColors.warning[600]!;
  @override
  Color get successPrimary => PrimitiveColors.success[50]!;
  @override
  Color get successSecondary => PrimitiveColors.success[100]!;
  @override
  Color get successSolid => PrimitiveColors.success[600]!;
}

/// Default implementation of [BackgroundColors] for dark mode.
///
/// Provides a comprehensive set of background colors based on [PrimitiveColors],
/// including surfaces, overlays, and various semantic states (hover, disabled, etc.),
/// all optimized for dark mode.
class DarkBackgroundColors implements BackgroundColors {
  @override
  Color get primary => PrimitiveColors.grayDark[950]!;
  @override
  Color get primaryAlt => PrimitiveColors.grayDark[900]!;
  @override
  Color get primaryHover => PrimitiveColors.grayDark[800]!;
  @override
  Color get primarySolid => PrimitiveColors.grayDark[900]!;
  @override
  Color get secondary => PrimitiveColors.grayDark[900]!;
  @override
  Color get secondaryAlt => PrimitiveColors.grayDark[950]!;
  @override
  Color get secondaryHover => PrimitiveColors.grayDark[800]!;
  @override
  Color get secondarySubtle => PrimitiveColors.grayDark[600]!;
  @override
  Color get secondarySolid => PrimitiveColors.grayDark[600]!;
  @override
  Color get tertiary => PrimitiveColors.grayDark[800]!;
  @override
  Color get quaternary => PrimitiveColors.grayDark[700]!;
  @override
  Color get active => PrimitiveColors.grayDark[800]!;
  @override
  Color get disabled => PrimitiveColors.grayDark[800]!;
  @override
  Color get disabledSubtle => PrimitiveColors.grayDark[900]!;
  @override
  Color get overlay => PrimitiveColors.grayDark[800]!;
  @override
  Color get brandPrimary => PrimitiveColors.brand[500]!;
  @override
  Color get brandPrimaryAlt => PrimitiveColors.grayDark[800]!;
  @override
  Color get brandSecondary => PrimitiveColors.brand[600]!;
  @override
  Color get brandSolid => PrimitiveColors.brand[600]!;
  @override
  Color get brandSolidHover => PrimitiveColors.brand[500]!;
  @override
  Color get brandSection => PrimitiveColors.grayDark[800]!;
  @override
  Color get brandSectionSubtle => PrimitiveColors.grayDark[950]!;
  @override
  Color get errorPrimary => PrimitiveColors.error[500]!;
  @override
  Color get errorSecondary => PrimitiveColors.error[600]!;
  @override
  Color get errorSolid => PrimitiveColors.error[600]!;
  @override
  Color get warningPrimary => PrimitiveColors.warning[500]!;
  @override
  Color get warningSecondary => PrimitiveColors.warning[600]!;
  @override
  Color get warningSolid => PrimitiveColors.warning[600]!;
  @override
  Color get successPrimary => PrimitiveColors.success[500]!;
  @override
  Color get successSecondary => PrimitiveColors.success[600]!;
  @override
  Color get successSolid => PrimitiveColors.success[600]!;
}
