import 'dart:ui';

import '../colors/colors.dart';
import 'primitive_colors.dart';

class LightTextColors implements TextColors {
  @override
  Color get primary => PrimitiveColors.gray[900]!;
  @override
  Color get primaryOnBrand => PrimitiveColors.white;
  @override
  Color get secondary => PrimitiveColors.gray[700]!;
  @override
  Color get secondaryOnBrand => PrimitiveColors.brand[200]!;
  @override
  Color get tertiary => PrimitiveColors.gray[600]!;
  @override
  Color get tertiaryHover => PrimitiveColors.gray[700]!;
  @override
  Color get tertiaryOnBrand => PrimitiveColors.brand[200]!;
  @override
  Color get quaternary => PrimitiveColors.gray[500]!;
  @override
  Color get quaternaryOnBrand => PrimitiveColors.brand[300]!;
  @override
  Color get white => PrimitiveColors.white;
  @override
  Color get disabled => PrimitiveColors.gray[500]!;
  @override
  Color get placeholder => PrimitiveColors.gray[500]!;
  @override
  Color get placeholderSubtle => PrimitiveColors.gray[300]!;
  @override
  Color get brandPrimary => PrimitiveColors.brand[900]!;
  @override
  Color get brandSecondary => PrimitiveColors.brand[700]!;
  @override
  Color get brandTertiary => PrimitiveColors.brand[600]!;
  @override
  Color get brandTertiaryAlt => PrimitiveColors.brand[600]!;
  @override
  Color get errorPrimary => PrimitiveColors.error[600]!;
  @override
  Color get warningPrimary => PrimitiveColors.warning[600]!;
  @override
  Color get successPrimary => PrimitiveColors.success[600]!;
}

class DarkTextColors implements TextColors {
  @override
  Color get primary => PrimitiveColors.grayDark[50]!;
  @override
  Color get primaryOnBrand => PrimitiveColors.grayDark[50]!;
  @override
  Color get secondary => PrimitiveColors.grayDark[200]!;
  @override
  Color get secondaryOnBrand => PrimitiveColors.grayDark[300]!;
  @override
  Color get tertiary => PrimitiveColors.grayDark[400]!;
  @override
  Color get tertiaryHover => PrimitiveColors.grayDark[300]!;
  @override
  Color get tertiaryOnBrand => PrimitiveColors.grayDark[400]!;
  @override
  Color get quaternary => PrimitiveColors.grayDark[400]!;
  @override
  Color get quaternaryOnBrand => PrimitiveColors.grayDark[400]!;
  @override
  Color get white => PrimitiveColors.white;
  @override
  Color get disabled => PrimitiveColors.grayDark[500]!;
  @override
  Color get placeholder => PrimitiveColors.grayDark[400]!;
  @override
  Color get placeholderSubtle => PrimitiveColors.grayDark[700]!;
  @override
  Color get brandPrimary => PrimitiveColors.grayDark[50]!;
  @override
  Color get brandSecondary => PrimitiveColors.grayDark[300]!;
  @override
  Color get brandTertiary => PrimitiveColors.grayDark[400]!;
  @override
  Color get brandTertiaryAlt => PrimitiveColors.grayDark[50]!;
  @override
  Color get errorPrimary => PrimitiveColors.error[400]!;
  @override
  Color get warningPrimary => PrimitiveColors.warning[400]!;
  @override
  Color get successPrimary => PrimitiveColors.success[400]!;
}
