import 'dart:math' as math;

/// Extensions on [double] type
extension DoubleExtensions on double {
  /// Converts [double] to radians
  double toRadians() {
    return this * math.pi / 180;
  }

  /// Converts a [double] between 0 and 1 to an alpha value between 0 and 255
  int opacityToAlpha() {
    if (this <= 0) return 0;
    if (this >= 1) return 255;
    return (this * 255).round();
  }
}
