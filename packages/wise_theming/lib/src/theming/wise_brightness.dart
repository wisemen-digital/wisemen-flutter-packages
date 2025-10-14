import '../colors/colors.dart';

/// Contains all color definitions for a specific brightness mode (light or dark).
///
/// A [WiseBrightness] groups together all the different color categories needed
/// for a complete theme in either light or dark mode. Each category serves a
/// specific purpose:
/// - [textColors]: Colors for text content
/// - [foregroundColors]: Colors for icons and UI elements in the foreground
/// - [borderColors]: Colors for borders and dividers
/// - [backgroundColors]: Colors for backgrounds and surfaces
/// - [utilityColors]: Additional utility colors (red, blue, green, etc.)
///
/// Example:
/// ```dart
/// final lightMode = WiseBrightness(
///   textColors: LightTextColors(),
///   foregroundColors: LightForegroundColors(),
///   borderColors: LightBorderColors(),
///   backgroundColors: LightBackgroundColors(),
///   utilityColors: LightUtilityColors(),
/// );
/// ```
class WiseBrightness {
  /// Creates a brightness configuration with all required color categories.
  WiseBrightness({
    required this.textColors,
    required this.foregroundColors,
    required this.borderColors,
    required this.backgroundColors,
    required this.utilityColors,
  });

  /// Colors specifically for text content across the UI.
  final TextColors textColors;

  /// Colors for foreground elements like icons and interactive UI components.
  final ForegroundColors foregroundColors;

  /// Colors for borders, dividers, and outlines.
  final BorderColors borderColors;

  /// Colors for backgrounds and surfaces.
  final BackgroundColors backgroundColors;

  /// Utility colors for special purposes (alerts, badges, etc.).
  final UtilityColors utilityColors;
}
