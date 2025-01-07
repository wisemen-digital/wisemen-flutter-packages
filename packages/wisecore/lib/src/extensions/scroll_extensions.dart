import 'package:flutter/material.dart';

/// Extensions on [ScrollController]
extension ScrollExtensions on ScrollController {
  /// Scrolls to the bottom of the list
  Future<void> scrollToBottom({
    Duration duration = Durations.medium2,
    Curve curve = Curves.easeInOut,
  }) async {
    await animateTo(
      position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  /// Scrolls to the top of the list
  Future<void> scrollToTop({
    Duration duration = Durations.medium2,
    Curve curve = Curves.easeInOut,
  }) async {
    await animateTo(
      position.minScrollExtent,
      duration: duration,
      curve: curve,
    );
  }
}
