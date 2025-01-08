import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// typedef for widget size change function
typedef OnWidgetSizeChange = void Function(Size size);

/// [MeasureSizeRenderObject] to measure widget
class MeasureSizeRenderObject extends RenderProxyBox {
  /// Constructor [MeasureSizeRenderObject]
  MeasureSizeRenderObject(this.onChange);

  /// Size change callback
  Size? oldSize;

  /// Size change callback
  OnWidgetSizeChange onChange;

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

/// [MeasureSize] widget
class MeasureSize extends SingleChildRenderObjectWidget {
  /// Constructor [MeasureSize]
  const MeasureSize({
    required this.onChange,
    required Widget super.child,
    super.key,
  });

  /// Size change callback
  final OnWidgetSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant MeasureSizeRenderObject renderObject,
  ) {
    renderObject.onChange = onChange;
  }
}
