import '../theming/theming.dart';
import 'base.dart';

final baseTheme = WiseTheme(
  identifier: 'wise_theming_base_theme',
  lightColors: WiseBrightness(
    textColors: LightTextColors(),
    foregroundColors: LightForegroundColors(),
    borderColors: LightBorderColors(),
    backgroundColors: LightBackgroundColors(),
    utilityColors: LightUtilityColors(),
  ),
  darkColors: WiseBrightness(
    textColors: DarkTextColors(),
    foregroundColors: DarkForegroundColors(),
    borderColors: DarkBorderColors(),
    backgroundColors: DarkBackgroundColors(),
    utilityColors: DarkUtilityColors(),
  ),
);
