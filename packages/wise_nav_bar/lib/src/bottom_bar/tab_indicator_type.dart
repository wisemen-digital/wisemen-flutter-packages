import 'package:flutter/cupertino.dart';

/// Tab indicator type for the bottom navigation bar
enum TabIndicatorType {
  /// No indicator
  none,

  /// Line indicator with rounded corners
  roundedRectangle;

  /// Indicator height
  static const double height = 3;

  /// Indicator widget
  Widget indicatorWidget({
    bool selected = true,
    double size = 24,
    Color? color,
  }) {
    switch (this) {
      case TabIndicatorType.none:
        return const SizedBox.shrink();
      case TabIndicatorType.roundedRectangle:
        return Positioned(
          top: -(height / 2),
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedOpacity(
              opacity: selected ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                height: height,
                width: size,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            ),
          ),
        );
    }
  }
}
