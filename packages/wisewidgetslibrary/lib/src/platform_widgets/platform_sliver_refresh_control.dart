import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

/// A [PlatformSliverRefreshControl] that provides a [CupertinoSliverRefreshControl] with Material UI for slivers
class PlatformSliverRefreshControl extends PlatformWidget {
  /// [PlatformSliverRefreshControl] constructor
  const PlatformSliverRefreshControl({
    required this.onRefresh,
    this.backgroundColor,
    this.color,
    super.key,
  });

  /// Callback invoked when pulled
  /// If provided, must return a [Future] which will keep the indicator in the
  /// [RefreshIndicatorMode.refresh] state until the [Future] completes.
  /// Can be null, in which case a single frame of [RefreshIndicatorMode.armed]
  /// state will be drawn before going immediately to the [RefreshIndicatorMode.done]
  /// where the sliver will start retracting.
  final Future<void> Function()? onRefresh;

  /// Material [RefreshIndicator] background color.
  final Color? backgroundColor;

  /// Material [RefreshIndicator] color.
  final Color? color;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder:
          (
            context,
            refreshState,
            pulledExtent,
            refreshTriggerPullDistance,
            refreshIndicatorExtent,
          ) {
            return buildRefreshIndicator(refreshState, pulledExtent);
          },
    );
  }

  /// Builds the Material refresh indicator
  Widget buildRefreshIndicator(
    RefreshIndicatorMode refreshState,
    double pulledExtent,
  ) {
    return Row(
      children: [
        const Spacer(),
        CustomMaterialRefreshProgressIndicator(
          value: switch (refreshState) {
            RefreshIndicatorMode.armed || RefreshIndicatorMode.refresh => null,
            RefreshIndicatorMode.drag => (pulledExtent / 100).clamp(0, 1),
            RefreshIndicatorMode.inactive || RefreshIndicatorMode.done => 0,
          },
          color: color,
          backgroundColor: backgroundColor,
        ),
        const Spacer(),
      ],
    );
  }
}

//! This is a copy of the ProgressIndicator implementation in Flutter SDK.
//! Changed to fit a CupertinoSliverRefreshControl
const int _kIndeterminateCircularDuration = 1333 * 2222;

class _CircularProgressIndicatorPainter extends CustomPainter {
  _CircularProgressIndicatorPainter({
    required this.valueColor,
    required this.value,
    required this.headValue,
    required this.tailValue,
    required this.offsetValue,
    required this.rotationValue,
    required this.strokeWidth,
    required this.strokeAlign,
    this.strokeCap,
  }) : arcStart = value != null
           ? _startAngle
           : _startAngle +
                 tailValue * 3 / 2 * math.pi +
                 rotationValue * math.pi * 2.0 +
                 offsetValue * 0.5 * math.pi,
       arcSweep = value != null
           ? clampDouble(value, 0, 1) * _sweep
           : math.max(
               headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi,
               _epsilon,
             );

  final Color valueColor;
  final double? value;
  final double headValue;
  final double tailValue;
  final double offsetValue;
  final double rotationValue;
  final double strokeWidth;
  final double strokeAlign;
  final double arcStart;
  final double arcSweep;
  final StrokeCap? strokeCap;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Use the negative operator as intended to keep the exposed constant value
    // as users are already familiar with.

    final strokeOffset = strokeWidth / 2 * -strokeAlign;
    final arcBaseOffset = Offset(strokeOffset, strokeOffset);
    final arcActualSize = Size(
      size.height - strokeOffset * 2,
      size.height - strokeOffset * 2,
    );

    if (value == null && strokeCap == null) {
      // Indeterminate
      paint.strokeCap = StrokeCap.butt;
    }

    canvas.drawArc(
      arcBaseOffset & arcActualSize,
      arcStart,
      arcSweep,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressIndicatorPainter oldPainter) {
    return oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.offsetValue != offsetValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth ||
        oldPainter.strokeAlign != strokeAlign ||
        oldPainter.strokeCap != strokeCap;
  }
}

class _CircularProgressIndicator extends ProgressIndicator {
  /// Creates a circular progress indicator.
  ///
  /// {@macro flutter.material.ProgressIndicator.ProgressIndicator}
  const _CircularProgressIndicator({
    super.key,
    super.value,
    super.backgroundColor,
    super.color,
    super.valueColor,
    this.strokeWidth,
    this.strokeAlign,
    super.semanticsLabel,
    super.semanticsValue,
    this.strokeCap,
  });

  /// Creates an adaptive progress indicator that is a
  /// [CupertinoActivityIndicator] on [TargetPlatform.iOS] &
  /// [TargetPlatform.macOS] and a [CircularProgressIndicator] in material
  /// theme/non-Apple platforms.
  ///
  /// The [valueColor], [strokeWidth], [strokeAlign], [strokeCap],
  /// [semanticsLabel], [semanticsValue]
  /// {@macro flutter.material.ProgressIndicator.ProgressIndicator}
  /// Color of the circular track being filled by the circular indicator.
  ///
  /// If [CircularProgressIndicator.backgroundColor] is null then the
  /// ambient [ProgressIndicatorThemeData.circularTrackColor] will be used.
  /// If that is null, then the track will not be painted.
  @override
  Color? get backgroundColor => super.backgroundColor;

  /// The width of the line used to draw the circle.
  final double? strokeWidth;

  /// The relative position of the stroke on a [CircularProgressIndicator].
  final double? strokeAlign;

  /// The progress indicator's line ending.
  ///
  /// This determines the shape of the stroke ends of the progress indicator.
  /// By default, [strokeCap] is null.
  /// When [value] is null (indeterminate), the stroke ends are set to
  /// [StrokeCap.square]. When [value] is not null, the stroke
  /// ends are set to [StrokeCap.butt].
  ///
  /// Setting [strokeCap] to [StrokeCap.round] will result in a rounded end.
  /// Setting [strokeCap] to [StrokeCap.butt] with [value] == null will result
  /// in a slightly different indeterminate animation; the indicator completely
  /// disappears and reappears on its minimum value.
  /// Setting [strokeCap] to [StrokeCap.square] with [value] != null will
  /// result in a different display of [value]. The indicator will start
  /// drawing from slightly less than the start, and end slightly after
  /// the end. This will produce an alternative result, as the
  /// default behavior, for example, that a [value] of 0.5 starts at 90 degrees
  /// and ends at 270 degrees. With [StrokeCap.square], it could start 85
  /// degrees and end at 275 degrees.
  final StrokeCap? strokeCap;

  @override
  State<_CircularProgressIndicator> createState() =>
      _CircularProgressIndicatorState();

  Color _getValueColor(BuildContext context, {Color? defaultColor}) {
    return valueColor?.value ??
        color ??
        ProgressIndicatorTheme.of(context).color ??
        defaultColor ??
        Theme.of(context).colorScheme.primary;
  }

  Widget _buildSemanticsWrapper({
    required BuildContext context,
    required Widget child,
  }) {
    var expandedSemanticsValue = semanticsValue;
    if (value != null) {
      expandedSemanticsValue ??= '${(value! * 100).round()}%';
    }
    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }
}

class _CircularProgressIndicatorState extends State<_CircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  static const int _pathCount = _kIndeterminateCircularDuration ~/ 1333;
  static const int _rotationCount = _kIndeterminateCircularDuration ~/ 2222;

  static final Animatable<double> _strokeHeadTween = CurveTween(
    curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(curve: const SawTooth(_pathCount)));
  static final Animatable<double> _strokeTailTween = CurveTween(
    curve: const Interval(0.5, 1, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(curve: const SawTooth(_pathCount)));
  static final Animatable<double> _offsetTween = CurveTween(
    curve: const SawTooth(_pathCount),
  );
  static final Animatable<double> _rotationTween = CurveTween(
    curve: const SawTooth(_rotationCount),
  );

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateCircularDuration),
      vsync: this,
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(_CircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMaterialIndicator(
    BuildContext context,
    double headValue,
    double tailValue,
    double offsetValue,
    double rotationValue,
  ) {
    final indicatorTheme = ProgressIndicatorTheme.of(context);
    final ProgressIndicatorThemeData defaults =
        _CircularProgressIndicatorDefaultsM3Year2023(
          context,
          indeterminate: widget.value == null,
        );

    final strokeWidth =
        widget.strokeWidth ??
        indicatorTheme.strokeWidth ??
        defaults.strokeWidth!;
    final strokeAlign =
        widget.strokeAlign ??
        indicatorTheme.strokeAlign ??
        defaults.strokeAlign!;
    final strokeCap = widget.strokeCap ?? indicatorTheme.strokeCap;
    final constraints = indicatorTheme.constraints ?? defaults.constraints!;
    final effectivePadding =
        indicatorTheme.circularTrackPadding ?? defaults.circularTrackPadding;

    Widget result = ConstrainedBox(
      constraints: constraints,
      child: Center(
        child: CustomPaint(
          painter: _CircularProgressIndicatorPainter(
            valueColor: widget._getValueColor(
              context,
              defaultColor: defaults.color,
            ),
            value: widget.value, // may be null
            headValue:
                headValue, // remaining arguments are ignored if widget.value is not null
            tailValue: tailValue,
            offsetValue: offsetValue,
            rotationValue: rotationValue,
            strokeWidth: strokeWidth,
            strokeAlign: strokeAlign,
            strokeCap: strokeCap,
          ),
        ),
      ),
    );

    if (effectivePadding != null) {
      result = Padding(padding: effectivePadding, child: result);
    }

    return widget._buildSemanticsWrapper(context: context, child: result);
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return _buildMaterialIndicator(
          context,
          _strokeHeadTween.evaluate(_controller),
          _strokeTailTween.evaluate(_controller),
          _offsetTween.evaluate(_controller),
          _rotationTween.evaluate(_controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return _buildMaterialIndicator(context, 0, 0, 0, 0);
    }
    return _buildAnimation();
  }
}

class _RefreshProgressIndicatorPainter
    extends _CircularProgressIndicatorPainter {
  _RefreshProgressIndicatorPainter({
    required super.valueColor,
    required super.value,
    required super.headValue,
    required super.tailValue,
    required super.offsetValue,
    required super.rotationValue,
    required super.strokeWidth,
    required super.strokeAlign,
    required this.arrowheadScale,
    required super.strokeCap,
  });

  final double arrowheadScale;

  void paintArrowhead(Canvas canvas, Size size) {
    // ux, uy: a unit vector whose direction parallels the base of the arrowhead.
    // (So ux, -uy points in the direction the arrowhead points.)
    final arcEnd = arcStart + arcSweep;
    final ux = math.cos(arcEnd);
    final uy = math.sin(arcEnd);
    assert(
      size.width == size.height,
      'Arrowhead only works on square progress indicators',
    );
    final radius = size.width / 2.0;
    final arrowheadPointX =
        radius + ux * radius + -uy * strokeWidth * 2.0 * arrowheadScale;
    final arrowheadPointY =
        radius + uy * radius + ux * strokeWidth * 2.0 * arrowheadScale;
    final arrowheadRadius = strokeWidth * 2.0 * arrowheadScale;
    final innerRadius = radius - arrowheadRadius;
    final outerRadius = radius + arrowheadRadius;

    final path = Path()
      ..moveTo(radius + ux * innerRadius, radius + uy * innerRadius)
      ..lineTo(radius + ux * outerRadius, radius + uy * outerRadius)
      ..lineTo(arrowheadPointX, arrowheadPointY)
      ..close();

    final paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.height > 16 && size.height == size.width) {
      super.paint(canvas, size);
      if (arrowheadScale > 0.0) {
        paintArrowhead(canvas, size);
      }
    } else if (size.height > 10) {
      super.paint(canvas, size);
    }
  }
}

/// An indicator for the progress of refreshing the contents of a widget.
///
/// Typically used for swipe-to-refresh interactions. See [RefreshIndicator] for
/// a complete implementation of swipe-to-refresh driven by a [Scrollable]
/// widget.
///
/// The indicator arc is displayed with [valueColor], an animated value. To
/// specify a constant color use: `AlwaysStoppedAnimation<Color>(color)`.
///
/// See also:
///
///  * [RefreshIndicator], which automatically displays a [CircularProgressIndicator]
///    when the underlying vertical scrollable is over scrolled.
class CustomMaterialRefreshProgressIndicator
    extends _CircularProgressIndicator {
  /// Creates a refresh progress indicator.
  ///
  /// Rather than creating a refresh progress indicator directly, consider using
  /// a [RefreshIndicator] together with a [Scrollable] widget.
  ///
  /// {@macro flutter.material.ProgressIndicator.ProgressIndicator}
  const CustomMaterialRefreshProgressIndicator({
    super.key,
    super.value,
    super.backgroundColor,
    super.color,
    super.valueColor,
    super.strokeWidth =
        defaultStrokeWidth, // Different default than CircularProgressIndicator.
    super.strokeAlign,
    super.semanticsLabel,
    super.semanticsValue,
    super.strokeCap,
    this.elevation = 2.0,
    this.indicatorMargin = const EdgeInsets.all(4),
    this.indicatorPadding = const EdgeInsets.all(12),
  });

  /// {@macro flutter.material.material.elevation}
  final double elevation;

  /// The amount of space by which to inset the whole indicator.
  /// It accommodates the [elevation] of the indicator.
  final EdgeInsetsGeometry indicatorMargin;

  /// The amount of space by which to inset the inner refresh indicator.
  final EdgeInsetsGeometry indicatorPadding;

  /// Default stroke width.
  static const double defaultStrokeWidth = 2.5;

  /// Background color of that fills the circle under the refresh indicator.
  ///
  /// If [RefreshIndicator.backgroundColor] is null then the
  /// ambient [ProgressIndicatorThemeData.refreshBackgroundColor] will be used.
  /// If that is null, then the ambient theme's [ThemeData.canvasColor]
  /// will be used.
  @override
  Color? get backgroundColor => super.backgroundColor;

  @override
  // ignore: library_private_types_in_public_api
  State<_CircularProgressIndicator> createState() =>
      _RefreshProgressIndicatorState();
}

class _RefreshProgressIndicatorState extends _CircularProgressIndicatorState {
  static const double _indicatorSize = 41;

  /// Interval for arrow head to fully grow.
  static const double _strokeHeadInterval = 0.33;

  late final Animatable<double> _convertTween = CurveTween(
    curve: const Interval(0.1, _strokeHeadInterval),
  );

  late final Animatable<double>
  _additionalRotationTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      // Makes arrow to expand a little bit earlier, to match the Android look.
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -0.1, end: -0.2),
        weight: _strokeHeadInterval,
      ),
      // Additional rotation after the arrow expanded
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -0.2, end: 1.35),
        weight: 1 - _strokeHeadInterval,
      ),
    ],
  );

  // Last value received from the widget before null.
  double? _lastValue;

  /// Force casting the widget as [CustomMaterialRefreshProgressIndicator].
  @override
  CustomMaterialRefreshProgressIndicator get widget =>
      super.widget as CustomMaterialRefreshProgressIndicator;

  // Always show the indeterminate version of the circular progress indicator.
  //
  // When value is non-null the sweep of the progress indicator arrow's arc
  // varies from 0 to about 300 degrees.
  //
  // When value is null the arrow animation starting from wherever we left it.
  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    if (value != null) {
      _lastValue = value;
      _controller.value =
          _convertTween.transform(value) *
          (1333 / 2 / _kIndeterminateCircularDuration);
    }
    return _buildAnimation();
  }

  @override
  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return _buildMaterialIndicator(
          context,
          // Lengthen the arc a little
          1.05 *
              _CircularProgressIndicatorState._strokeHeadTween.evaluate(
                _controller,
              ),
          _CircularProgressIndicatorState._strokeTailTween.evaluate(
            _controller,
          ),
          _CircularProgressIndicatorState._offsetTween.evaluate(_controller),
          _CircularProgressIndicatorState._rotationTween.evaluate(_controller),
        );
      },
    );
  }

  @override
  Widget _buildMaterialIndicator(
    BuildContext context,
    double headValue,
    double tailValue,
    double offsetValue,
    double rotationValue,
  ) {
    final value = widget.value;
    final arrowheadScale = value == null
        ? 0.0
        : const Interval(0.1, _strokeHeadInterval).transform(value);
    final double rotation;

    if (value == null && _lastValue == null) {
      rotation = 0.0;
    } else {
      rotation =
          math.pi * _additionalRotationTween.transform(value ?? _lastValue!);
    }

    var valueColor = widget._getValueColor(context);
    valueColor = valueColor.withValues(alpha: 1);

    final ProgressIndicatorThemeData defaults =
        _CircularProgressIndicatorDefaultsM3Year2023(
          context,
          indeterminate: value == null,
        );
    final indicatorTheme = ProgressIndicatorTheme.of(context);
    final backgroundColor =
        widget.backgroundColor ??
        indicatorTheme.refreshBackgroundColor ??
        Theme.of(context).canvasColor;
    final strokeWidth =
        widget.strokeWidth ??
        indicatorTheme.strokeWidth ??
        defaults.strokeWidth!;
    final strokeAlign =
        widget.strokeAlign ??
        indicatorTheme.strokeAlign ??
        defaults.strokeAlign!;
    final strokeCap = widget.strokeCap ?? indicatorTheme.strokeCap;

    return widget._buildSemanticsWrapper(
      context: context,
      child: Padding(
        padding: widget.indicatorMargin,
        child: SizedBox.square(
          dimension: _indicatorSize,
          child: Material(
            type: MaterialType.circle,
            color: backgroundColor,
            elevation: widget.elevation,
            child: Padding(
              padding: widget.indicatorPadding,
              child: Transform.rotate(
                angle: rotation,
                child: CustomPaint(
                  size: const Size.square(_indicatorSize),
                  painter: _RefreshProgressIndicatorPainter(
                    valueColor: valueColor,
                    value: null, // Draw the indeterminate progress indicator.
                    headValue: headValue,
                    tailValue: tailValue,
                    offsetValue: offsetValue,
                    rotationValue: rotationValue,
                    strokeWidth: strokeWidth,
                    strokeAlign: strokeAlign,
                    arrowheadScale: arrowheadScale,
                    strokeCap: strokeCap,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircularProgressIndicatorDefaultsM3Year2023
    extends ProgressIndicatorThemeData {
  _CircularProgressIndicatorDefaultsM3Year2023(
    this.context, {
    required this.indeterminate,
  });

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  final bool indeterminate;

  @override
  Color get color => _colors.primary;

  @override
  double get strokeWidth => 4;

  @override
  double? get strokeAlign => CircularProgressIndicator.strokeAlignCenter;

  @override
  BoxConstraints get constraints =>
      const BoxConstraints(minWidth: 36, minHeight: 36);
}
