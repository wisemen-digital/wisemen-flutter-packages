import 'package:flutter/material.dart';

import 'scalar_options.dart';

class WiseScalarScope extends InheritedWidget {
  const WiseScalarScope({
    required this.options,
    required super.child,
    super.key,
  });

  final ScalarOptions options;

  @override
  bool updateShouldNotify(WiseScalarScope oldWidget) {
    return options != oldWidget.options;
  }
}
