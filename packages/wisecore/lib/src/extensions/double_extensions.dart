import 'dart:math' as math;

/// Extensions on [double] type
extension DoubleExtensions on double {
  /// Converts [double] to radians
  double toRadians() {
    return this * math.pi / 180;
  }
}
