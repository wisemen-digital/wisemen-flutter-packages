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
  Color get teal;
  Color get blue;
  Color get orange;
  Color get pink;
  Color get purple;
  Color get green;
  Color get red;
  Color get yellow;
  Color get indigo;
}
