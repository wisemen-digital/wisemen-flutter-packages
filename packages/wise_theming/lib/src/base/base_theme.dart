import '../theming/theming.dart';
import 'base.dart';

final _baseLightTheme = WiseTheme(
  identifier: 'Base theme',
  themeType: WiseThemeType.light,
  textColors: lightTextColors,
  foregroundColors: lightForegroundColors,
  borderColors: lightBorderColors,
  backgroundColors: lightBackgroundColors,
  utilityColors: lightUtilityColors,
);

final _baseDarkTheme = WiseTheme(
  identifier: 'Base dark theme',
  themeType: WiseThemeType.dark,
  textColors: darkTextColors,
  foregroundColors: darkForegroundColors,
  borderColors: darkBorderColors,
  backgroundColors: darkBackgroundColors,
  utilityColors: darkUtilityColors,
);

final _highContrastLightTheme = WiseTheme(
  identifier: 'High contrast theme',
  themeType: WiseThemeType.lightContrast,
  textColors: highContrastLightTextColors,
  foregroundColors: highContrastLightForegroundColors,
  borderColors: highContrastLightBorderColors,
  backgroundColors: highContrastLightBackgroundColors,
  utilityColors: highContrastLightUtilityColors,
);

final _highContrastDarkTheme = WiseTheme(
  identifier: 'High contrast dark theme',
  themeType: WiseThemeType.darkContrast,
  textColors: highContrastDarkTextColors,
  foregroundColors: highContrastDarkForegroundColors,
  borderColors: highContrastDarkBorderColors,
  backgroundColors: highContrastDarkBackgroundColors,
  utilityColors: highContrastDarkUtilityColors,
);

/// The default base supported themes provided by wise_theming.
///
/// This theme uses the default color implementations ([lightForegroundColors],
/// [lightForegroundColors], [lightBorderColors], [lightBackgroundColors], etc.
/// - A fallback theme when a requested theme identifier is not found
/// - A reference implementation showing how to construct a [WiseTheme]
/// - A ready-to-use default theme for quick prototyping
///
/// The base theme includes complete color schemes for both light and dark modes.
///
/// Example usage:
/// ```dart
/// WiseTheming(
///   supportedThemes: supportedThemes,
///   currentTheme: 'custom',
/// );
/// ```
final List<WiseTheme> supportedThemes = [
  _baseLightTheme,
  _baseDarkTheme,
  _highContrastLightTheme,
  _highContrastDarkTheme,
];
