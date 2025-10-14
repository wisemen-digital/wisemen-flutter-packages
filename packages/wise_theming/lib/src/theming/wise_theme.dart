import 'theming.dart';

/// Represents a complete theme configuration with light and dark color schemes.
///
/// A [WiseTheme] encapsulates all color definitions for both light and dark modes
/// of a particular theme. Each theme is uniquely identified by its [identifier].
///
/// Example:
/// ```dart
/// final myTheme = WiseTheme(
///   identifier: 'my-theme',
///   lightColors: WiseBrightness(
///     textColors: MyLightTextColors(),
///     foregroundColors: MyLightForegroundColors(),
///     borderColors: MyLightBorderColors(),
///     backgroundColors: MyLightBackgroundColors(),
///     utilityColors: MyLightUtilityColors(),
///   ),
///   darkColors: WiseBrightness(
///     textColors: MyDarkTextColors(),
///     foregroundColors: MyDarkForegroundColors(),
///     borderColors: MyDarkBorderColors(),
///     backgroundColors: MyDarkBackgroundColors(),
///     utilityColors: MyDarkUtilityColors(),
///   ),
/// );
/// ```
class WiseTheme {
  /// Creates a new theme with light and dark color configurations.
  ///
  /// [identifier] - A unique string identifier for this theme.
  /// [lightColors] - The color scheme to use in light mode.
  /// [darkColors] - The color scheme to use in dark mode.
  WiseTheme({
    required this.identifier,
    required this.lightColors,
    required this.darkColors,
  });

  /// A unique identifier for this theme.
  ///
  /// Used to select and switch between different themes at runtime.
  final String identifier;

  /// The complete color scheme for light mode.
  final WiseBrightness lightColors;

  /// The complete color scheme for dark mode.
  final WiseBrightness darkColors;
}
