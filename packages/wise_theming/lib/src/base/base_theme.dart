import '../theming/theming.dart';
import 'base.dart';

/// The default base theme provided by wise_theming.
///
/// This theme uses the default color implementations ([LightTextColors],
/// [LightBackgroundColors], etc.) based on [PrimitiveColors]. It serves as:
/// - A fallback theme when a requested theme identifier is not found
/// - A reference implementation showing how to construct a [WiseTheme]
/// - A ready-to-use default theme for quick prototyping
///
/// The base theme includes complete color schemes for both light and dark modes.
///
/// Example usage:
/// ```dart
/// // Use as fallback
/// WiseTheming.init(
///   supportedThemes: [customTheme],
///   currentTheme: 'custom',
/// );
/// // If 'custom' is not found, baseTheme is used automatically
/// ```
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
