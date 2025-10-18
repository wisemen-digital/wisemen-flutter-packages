import 'dart:ui';

/// [UtilityColors] that holds utility colors used for specific purposes throughout the app.
/// Use utility color variables for color-coded elements, categories, and visual distinctions.
class UtilityColors {
  /// Creates an instance of [UtilityColors].
  const UtilityColors({
    required this.teal,
    required this.blue,
    required this.orange,
    required this.pink,
    required this.purple,
    required this.green,
    required this.red,
    required this.yellow,
    required this.indigo,
    this.customColors,
  });

  /// Teal utility color for informational and neutral elements.
  /// Used for secondary information displays, neutral status indicators, and calm accent elements.
  final Color teal;

  /// Blue utility color for informational and interactive elements.
  /// Used for information messages, links, and interactive elements that need trustworthy appearance.
  final Color blue;

  /// Orange utility color for attention and warning elements.
  /// Used for moderate warnings, attention-grabbing elements, and energetic accent colors.
  final Color orange;

  /// Pink utility color for highlight and accent elements.
  /// Used for creative highlights, feminine branding elements, and playful accent colors.
  final Color pink;

  /// Purple utility color for premium and creative elements.
  /// Used for premium features, creative content, and sophisticated accent elements.
  final Color purple;

  /// Green utility color for success and positive elements.
  /// Used for success states, positive feedback, and elements indicating completion or growth.
  final Color green;

  /// Red utility color for error and critical elements.
  /// Used for error states, destructive actions, and critical alerts that require immediate attention.
  final Color red;

  /// Yellow utility color for caution and highlight elements.
  /// Used for caution warnings, highlights, and elements that need to draw attention without being critical.
  final Color yellow;

  /// Indigo utility color for deep accent and sophisticated elements.
  /// Used for deep accent colors, sophisticated branding, and elements requiring a premium feel.
  final Color indigo;

  /// Variable used to add custom colors that are not part of the standard palette.
  /// It's possible to write extensions on this class to use the colors the same way as the standard colors.
  /// Example:
  ///
  /// ```dart
  /// extension CustomColorExtension on UtilityColors {
  ///   Color get customColorName => customColors['customColorName']!;
  /// }
  /// ```
  final Map<String, Color>? customColors;

  /// Linearly interpolates between two [UtilityColors] themes.
  static UtilityColors lerp(UtilityColors a, UtilityColors b, double t) {
    return UtilityColors(
      teal: Color.lerp(a.teal, b.teal, t)!,
      blue: Color.lerp(a.blue, b.blue, t)!,
      orange: Color.lerp(a.orange, b.orange, t)!,
      pink: Color.lerp(a.pink, b.pink, t)!,
      purple: Color.lerp(a.purple, b.purple, t)!,
      green: Color.lerp(a.green, b.green, t)!,
      red: Color.lerp(a.red, b.red, t)!,
      yellow: Color.lerp(a.yellow, b.yellow, t)!,
      indigo: Color.lerp(a.indigo, b.indigo, t)!,
      customColors: b.customColors,
    );
  }
}
