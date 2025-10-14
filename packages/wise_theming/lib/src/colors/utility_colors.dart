import 'package:flutter/widgets.dart';

/// Abstract base class defining utility colors for special purposes.
///
/// Implement this class to provide a set of semantic utility colors that can
/// be used for badges, status indicators, categories, or any other special
/// UI elements that need distinct colors.
///
/// Example implementation:
/// ```dart
/// class MyUtilityColors extends UtilityColors {
///   @override
///   Color get red => const Color(0xFFFF0000);
///
///   @override
///   Color get blue => const Color(0xFF0000FF);
///
///   // ... implement all other colors
/// }
/// ```
abstract class UtilityColors {
  /// Teal utility color for badges, tags, or status indicators.
  Color get teal;

  /// Blue utility color for badges, tags, or status indicators.
  Color get blue;

  /// Orange utility color for badges, tags, or status indicators.
  Color get orange;

  /// Pink utility color for badges, tags, or status indicators.
  Color get pink;

  /// Purple utility color for badges, tags, or status indicators.
  Color get purple;

  /// Green utility color for badges, tags, or status indicators.
  Color get green;

  /// Red utility color for badges, tags, or status indicators.
  Color get red;

  /// Yellow utility color for badges, tags, or status indicators.
  Color get yellow;

  /// Indigo utility color for badges, tags, or status indicators.
  Color get indigo;
}
