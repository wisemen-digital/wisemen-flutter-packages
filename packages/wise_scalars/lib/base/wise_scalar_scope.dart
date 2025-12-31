import 'package:flutter/material.dart';

import 'scalar_options.dart';

/// An inherited widget that provides [ScalarOptions] to its descendants.
class WiseScalarScope extends InheritedWidget {
  /// Creates a [WiseScalarScope] widget
  const WiseScalarScope({
    required this.options,
    required super.child,
    super.key,
  });

  /// The [ScalarOptions] provided to descendants
  final ScalarOptions options;

  @override
  bool updateShouldNotify(WiseScalarScope oldWidget) {
    return options != oldWidget.options;
  }
}
