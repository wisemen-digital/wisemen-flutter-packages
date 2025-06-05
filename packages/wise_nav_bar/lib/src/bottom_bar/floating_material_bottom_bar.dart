import 'dart:collection' show Queue;
import 'dart:math' as math;

import 'package:flutter/material.dart'
    hide BottomNavigationBarLandscapeLayout, BottomNavigationBarType;
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' show Vector3;

import 'tab_indicator_type.dart';

/// A Material Design bottom navigation bar that floats
class FloatingMaterialBottomBar extends StatefulWidget {
  /// Creates a Material Design bottom navigation bar that floats
  FloatingMaterialBottomBar({
    required this.items,
    super.key,
    this.onTap,
    this.currentIndex = 0,
    this.elevation,
    Color? fixedColor,
    this.backgroundColor,
    this.iconSize = 24.0,
    Color? selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.mouseCursor,
    this.enableFeedback,
    this.shape,
    this.indicatorType = TabIndicatorType.none,
  })  : assert(items.length >= 2, 'There must be at least two items'),
        assert(
          items.every((BottomNavigationBarItem item) => item.label != null),
          'Every item must have a non-null label',
        ),
        assert(
          0 <= currentIndex && currentIndex < items.length,
          'currentIndex must be in the range [0, items.length - 1]',
        ),
        assert(
          elevation == null || elevation >= 0.0,
          'elevation must be null or non-negative',
        ),
        assert(iconSize >= 0.0, 'iconSize must be non-negative'),
        assert(
          selectedItemColor == null || fixedColor == null,
          'Either selectedItemColor or fixedColor can be specified, but not both',
        ),
        assert(
          selectedFontSize >= 0.0,
          'selectedFontSize must be non-negative',
        ),
        assert(
          unselectedFontSize >= 0.0,
          'unselectedFontSize must be non-negative',
        ),
        selectedItemColor = selectedItemColor ?? fixedColor;

  /// Defines the appearance of the button items that are arrayed within the
  /// bottom navigation bar.
  final List<BottomNavigationBarItem> items;

  /// Called when one of the [items] is tapped.
  ///
  /// The stateful widget that creates the bottom navigation bar needs to keep
  /// track of the index of the selected [BottomNavigationBarItem] and call
  /// `setState` to rebuild the bottom navigation bar with the new [currentIndex].
  final ValueChanged<int>? onTap;

  /// The index into [items] for the current active [BottomNavigationBarItem].
  final int currentIndex;

  /// The z-coordinate of this [BottomNavigationBar].
  ///
  /// If null, defaults to `8.0`.
  ///
  /// {@macro flutter.material.material.elevation}
  final double? elevation;

  /// The value of [selectedItemColor].
  ///
  /// This getter only exists for backwards compatibility, the
  /// [selectedItemColor] property is preferred.
  Color? get fixedColor => selectedItemColor;

  /// The color of the [BottomNavigationBar] itself.
  ///
  /// [items] have [BottomNavigationBarItem.backgroundColor] set, the [items]'
  /// backgroundColor will splash and overwrite this color.
  final Color? backgroundColor;

  /// The size of all of the [BottomNavigationBarItem] icons.
  ///
  /// See [BottomNavigationBarItem.icon] for more information.
  final double iconSize;

  /// The color of the selected [BottomNavigationBarItem.icon] and
  /// [BottomNavigationBarItem.label].
  ///
  /// If null then the [ThemeData.primaryColor] is used.
  final Color? selectedItemColor;

  /// The color of the unselected [BottomNavigationBarItem.icon] and
  /// [BottomNavigationBarItem.label]s.
  ///
  /// If null then the [ThemeData.unselectedWidgetColor]'s color is used.
  final Color? unselectedItemColor;

  /// The size, opacity, and color of the icon in the currently selected
  /// [BottomNavigationBarItem.icon].
  ///
  /// If this is not provided, the size will default to [iconSize], the color
  /// will default to [selectedItemColor].
  ///
  /// It this field is provided, it must contain non-null [IconThemeData.size]
  /// and [IconThemeData.color] properties. Also, if this field is supplied,
  /// [unselectedIconTheme] must be provided.
  final IconThemeData? selectedIconTheme;

  /// The size, opacity, and color of the icon in the currently unselected
  /// [BottomNavigationBarItem.icon]s.
  ///
  /// If this is not provided, the size will default to [iconSize], the color
  /// will default to [unselectedItemColor].
  ///
  /// It this field is provided, it must contain non-null [IconThemeData.size]
  /// and [IconThemeData.color] properties. Also, if this field is supplied,
  /// [selectedIconTheme] must be provided.
  final IconThemeData? unselectedIconTheme;

  /// The [TextStyle] of the [BottomNavigationBarItem] labels when they are
  /// selected.
  final TextStyle? selectedLabelStyle;

  /// The [TextStyle] of the [BottomNavigationBarItem] labels when they are not
  /// selected.
  final TextStyle? unselectedLabelStyle;

  /// The font size of the [BottomNavigationBarItem] labels when they are selected.
  ///
  /// If [TextStyle.fontSize] of [selectedLabelStyle] is non-null, it will be
  /// used instead of this.
  ///
  /// Defaults to `14.0`.
  final double selectedFontSize;

  /// The font size of the [BottomNavigationBarItem] labels when they are not
  /// selected.
  ///
  /// If [TextStyle.fontSize] of [unselectedLabelStyle] is non-null, it will be
  /// used instead of this.
  ///
  /// Defaults to `12.0`.
  final double unselectedFontSize;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// items.
  ///
  /// If [mouseCursor] is a [WidgetStateMouseCursor], its `resolve` method
  /// can define the appearance of the cursor depending on whether
  /// [WidgetState.selected] is active.
  ///
  /// If null, then the value of [BottomNavigationBarThemeData.mouseCursor] is used. If
  /// that is also null, then [WidgetStateMouseCursor.clickable] is used.
  final MouseCursor? mouseCursor;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// Navigation bar's shape
  final ShapeBorder? shape;

  /// Indicator type
  final TabIndicatorType indicatorType;

  @override
  State<FloatingMaterialBottomBar> createState() =>
      _FloatingMaterialBottomBarState();
}

// This represents a single tile in the bottom navigation bar. It is intended
// to go into a flex container.
class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile(
    this.item,
    this.animation,
    this.iconSize, {
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
    required this.mouseCursor,
    required this.enableFeedback,
    required this.indicatorType,
    super.key,
    this.onTap,
    this.labelColorTween,
    this.iconColorTween,
    this.flex,
    this.selected = false,
    this.indexLabel,
  });

  final BottomNavigationBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback? onTap;
  final ColorTween? labelColorTween;
  final ColorTween? iconColorTween;
  final double? flex;
  final bool selected;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final String? indexLabel;
  final MouseCursor mouseCursor;
  final bool enableFeedback;
  final TabIndicatorType indicatorType;

  @override
  Widget build(BuildContext context) {
    final selectedFontSize = selectedLabelStyle.fontSize!;

    final selectedIconSize = selectedIconTheme?.size ?? iconSize;
    final unselectedIconSize = unselectedIconTheme?.size ?? iconSize;

    // The amount that the selected icon is bigger than the unselected icons,
    // (or zero if the selected icon is not bigger than the unselected icons).
    final double selectedIconDiff =
        math.max(selectedIconSize - unselectedIconSize, 0);
    // The amount that the unselected icons are bigger than the selected icon,
    // (or zero if the unselected icons are not any bigger than the selected icon).
    final double unselectedIconDiff =
        math.max(unselectedIconSize - selectedIconSize, 0);

    // The effective tool tip message to be shown on the BottomNavigationBarItem.
    final effectiveTooltip = item.tooltip == '' ? null : item.tooltip;

    // Defines the padding for the animating icons + labels.
    //
    // The animations go from "Unselected":
    // =======
    // |      <-- Padding equal to the text height + 1/2 selectedIconDiff.
    // |  ☆
    // | text <-- Invisible text + padding equal to 1/2 selectedIconDiff.
    // =======
    //
    // To "Selected":
    //
    // =======
    // |      <-- Padding equal to 1/2 text height + 1/2 unselectedIconDiff.
    // |  ☆
    // | text
    // |      <-- Padding equal to 1/2 text height + 1/2 unselectedIconDiff.
    // =======
    final bottomPadding = Tween<double>(
      begin: selectedFontSize / 2.0 + selectedIconDiff / 2.0,
      end: selectedFontSize / 2.0 + unselectedIconDiff / 2.0,
    ).evaluate(animation);
    final topPadding = Tween<double>(
      begin: selectedFontSize / 2.0 + selectedIconDiff / 2.0,
      end: selectedFontSize / 2.0 + unselectedIconDiff / 2.0,
    ).evaluate(animation);

    Widget result = InkResponse(
      onTap: onTap,
      radius: kBottomNavigationBarHeight,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
            child: _Tile(
              icon: _TileIcon(
                colorTween: iconColorTween!,
                animation: animation,
                iconSize: iconSize,
                selected: selected,
                item: item,
                selectedIconTheme: selectedIconTheme,
                unselectedIconTheme: unselectedIconTheme,
              ),
              label: _Label(
                colorTween: labelColorTween!,
                animation: animation,
                item: item,
                selectedLabelStyle: selectedLabelStyle,
                unselectedLabelStyle: unselectedLabelStyle,
              ),
            ),
          ),
          indicatorType.indicatorWidget(
            selected: selected,
            size: selectedIconTheme?.size ?? iconSize,
            color:
                selectedIconTheme?.color ?? iconColorTween?.evaluate(animation),
          ),
        ],
      ),
    );

    if (effectiveTooltip != null) {
      result = Tooltip(
        message: effectiveTooltip,
        preferBelow: false,
        verticalOffset: selectedIconSize + selectedFontSize,
        excludeFromSemantics: true,
        child: result,
      );
    }

    result = Semantics(
      selected: selected,
      button: true,
      container: true,
      child: Stack(
        children: <Widget>[
          result,
          Semantics(label: indexLabel),
        ],
      ),
    );

    return Expanded(child: result);
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.label});

  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, label],
    );
  }
}

class _TileIcon extends StatelessWidget {
  const _TileIcon({
    required this.colorTween,
    required this.animation,
    required this.iconSize,
    required this.selected,
    required this.item,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
  });

  final ColorTween colorTween;
  final Animation<double> animation;
  final double iconSize;
  final bool selected;
  final BottomNavigationBarItem item;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;

  @override
  Widget build(BuildContext context) {
    final iconColor = colorTween.evaluate(animation);
    final defaultIconTheme = IconThemeData(color: iconColor, size: iconSize);
    final iconThemeData = IconThemeData.lerp(
      defaultIconTheme.merge(unselectedIconTheme),
      defaultIconTheme.merge(selectedIconTheme),
      animation.value,
    );

    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1,
      child: IconTheme(
        data: iconThemeData,
        child: selected ? item.activeIcon : item.icon,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.colorTween,
    required this.animation,
    required this.item,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
  });

  final ColorTween colorTween;
  final Animation<double> animation;
  final BottomNavigationBarItem item;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;

  @override
  Widget build(BuildContext context) {
    final selectedFontSize = selectedLabelStyle.fontSize;
    final unselectedFontSize = unselectedLabelStyle.fontSize;

    final customStyle = TextStyle.lerp(
      unselectedLabelStyle,
      selectedLabelStyle,
      animation.value,
    )!;
    var text = DefaultTextStyle.merge(
      style: customStyle.copyWith(
        fontSize: selectedFontSize,
        color: colorTween.evaluate(animation),
      ),
      // The font size should grow here when active, but because of the way
      // font rendering works, it doesn't grow smoothly if we just animate
      // the font size, so we use a transform instead.
      child: Transform(
        transform: Matrix4.diagonal3(
          Vector3.all(
            Tween<double>(
              begin: unselectedFontSize! / selectedFontSize!,
              end: 1,
            ).evaluate(animation),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Text(item.label!),
      ),
    );

    text =
        Align(alignment: Alignment.bottomCenter, heightFactor: 1, child: text);

    if (item.label != null) {
      // Do not grow text in bottom navigation bar when we can show a tooltip
      // instead.
      text = MediaQuery.withClampedTextScaling(maxScaleFactor: 1, child: text);
    }

    return text;
  }
}

class _FloatingMaterialBottomBarState extends State<FloatingMaterialBottomBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  List<CurvedAnimation> _animations = <CurvedAnimation>[];

  // A queue of color splashes currently being animated.
  final Queue<_Circle> _circles = Queue<_Circle>();

  // Last splash circle's color, and the final color of the control after
  // animation is complete.
  Color? _backgroundColor;

  static final Animatable<double> _flexTween =
      Tween<double>(begin: 1, end: 1.5);

  void _resetState() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final circle in _circles) {
      circle.dispose();
    }
    for (final animation in _animations) {
      animation.dispose();
    }
    _circles.clear();

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(duration: kThemeAnimationDuration, vsync: this)
        ..addListener(_rebuild);
    });
    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {
      // Rebuilding when any of the controllers tick, i.e. when the items are
      // animated.
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final circle in _circles) {
      circle.dispose();
    }
    for (final animation in _animations) {
      animation.dispose();
    }
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween.evaluate(animation);

  @override
  void didUpdateWidget(FloatingMaterialBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // No animated segue if the length of the items list changes.
    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    } else {
      if (_backgroundColor !=
          widget.items[widget.currentIndex].backgroundColor) {
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
      }
    }
  }

  // If the given [TextStyle] has a non-null `fontSize`, it should be used.
  // Otherwise, the [selectedFontSize] parameter should be used.
  static TextStyle _effectiveTextStyle(TextStyle? textStyle, double fontSize) {
    // ignore: parameter_assignments
    textStyle ??= const TextStyle();
    // Prefer the font size on textStyle if present.
    return textStyle.fontSize == null
        ? textStyle.copyWith(fontSize: fontSize)
        : textStyle;
  }

  List<Widget> _createTiles() {
    final localizations = MaterialLocalizations.of(context);

    final themeData = Theme.of(context);
    final bottomTheme = BottomNavigationBarTheme.of(context);

    final themeColor = switch (themeData.brightness) {
      Brightness.light => themeData.colorScheme.primary,
      Brightness.dark => themeData.colorScheme.secondary,
    };

    final effectiveSelectedLabelStyle = _effectiveTextStyle(
      widget.selectedLabelStyle ?? bottomTheme.selectedLabelStyle,
      widget.selectedFontSize,
    );

    final effectiveUnselectedLabelStyle = _effectiveTextStyle(
      widget.unselectedLabelStyle ?? bottomTheme.unselectedLabelStyle,
      widget.unselectedFontSize,
    );

    final colorTween = ColorTween(
      begin: widget.unselectedItemColor ??
          bottomTheme.unselectedItemColor ??
          themeData.unselectedWidgetColor,
      end: widget.selectedItemColor ??
          bottomTheme.selectedItemColor ??
          widget.fixedColor ??
          themeColor,
    );

    final tiles = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      final states = <WidgetState>{
        if (i == widget.currentIndex) WidgetState.selected,
      };

      final effectiveMouseCursor = WidgetStateProperty.resolveAs<MouseCursor?>(
            widget.mouseCursor,
            states,
          ) ??
          bottomTheme.mouseCursor?.resolve(states) ??
          WidgetStateMouseCursor.clickable.resolve(states);

      tiles.add(
        _BottomNavigationTile(
          widget.items[i],
          _animations[i],
          widget.iconSize,
          key: widget.items[i].key,
          selectedIconTheme:
              widget.selectedIconTheme ?? bottomTheme.selectedIconTheme,
          unselectedIconTheme:
              widget.unselectedIconTheme ?? bottomTheme.unselectedIconTheme,
          selectedLabelStyle: effectiveSelectedLabelStyle,
          unselectedLabelStyle: effectiveUnselectedLabelStyle,
          enableFeedback:
              widget.enableFeedback ?? bottomTheme.enableFeedback ?? true,
          onTap: () {
            widget.onTap?.call(i);
          },
          labelColorTween: colorTween,
          iconColorTween: colorTween,
          flex: _evaluateFlex(_animations[i]),
          selected: i == widget.currentIndex,
          indexLabel: localizations.tabLabel(
            tabIndex: i + 1,
            tabCount: widget.items.length,
          ),
          mouseCursor: effectiveMouseCursor,
          indicatorType: widget.indicatorType,
        ),
      );
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    assert(
      debugCheckHasDirectionality(context),
      'FloatingBottomBar widgets require a Directionality widget ancestor.',
    );
    assert(
      debugCheckHasMaterialLocalizations(context),
      'FloatingBottomBar widgets require MaterialLocalizations.',
    );
    assert(
      debugCheckHasMediaQuery(context),
      'FloatingBottomBar widgets require MediaQuery.',
    );
    assert(
      debugCheckHasOverlay(context),
      'FloatingBottomBar widgets require Overlay.',
    );

    final bottomTheme = BottomNavigationBarTheme.of(context);
    final backgroundColor =
        widget.backgroundColor ?? bottomTheme.backgroundColor;

    return Semantics(
      explicitChildNodes: true,
      child: _Bar(
        elevation: widget.elevation ?? bottomTheme.elevation ?? 4.0,
        shape: widget.shape,
        color: backgroundColor,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: kBottomNavigationBarHeight,
          ),
          child: CustomPaint(
            painter: _RadialPainter(
              circles: _circles.toList(),
              textDirection: Directionality.of(context),
            ),
            child: Material(
              // Splashes.
              type: MaterialType.transparency,
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                child: DefaultTextStyle.merge(
                  overflow: TextOverflow.ellipsis,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _createTiles(),
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

// Optionally center a Material child for landscape layouts when layout is
// BottomNavigationBarLandscapeLayout.centered
class _Bar extends StatelessWidget {
  const _Bar({
    required this.child,
    required this.elevation,
    required this.color,
    this.shape,
  });

  final Widget child;
  final double elevation;
  final ShapeBorder? shape;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var alignedChild = child;
    if (MediaQuery.orientationOf(context) == Orientation.landscape) {
      alignedChild = Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1,
        child: SizedBox(width: MediaQuery.sizeOf(context).height, child: child),
      );
    }
    return Material(
      elevation: elevation,
      color: color,
      shape: shape,
      child: alignedChild,
    );
  }
}

// Describes an animating color splash circle.
class _Circle {
  _Circle({
    required this.state,
    required this.index,
    required this.color,
    required TickerProvider vsync,
  }) {
    controller =
        AnimationController(duration: kThemeAnimationDuration, vsync: vsync);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();
  }

  final _FloatingMaterialBottomBarState state;
  final int index;
  final Color color;
  late AnimationController controller;
  late CurvedAnimation animation;

  double get horizontalLeadingOffset {
    double weightSum(Iterable<Animation<double>> animations) {
      // We're adding flex values instead of animation values to produce correct
      // ratios.
      return animations
          .map<double>(state._evaluateFlex)
          .fold<double>(0, (double sum, double value) => sum + value);
    }

    final allWeights = weightSum(state._animations);
    // These weights sum to the start edge of the indexed item.
    final leadingWeights = weightSum(state._animations.sublist(0, index));

    // Add half of its flex value in order to get to the center.
    return (leadingWeights +
            state._evaluateFlex(state._animations[index]) / 2.0) /
        allWeights;
  }

  void dispose() {
    controller.dispose();
    animation.dispose();
  }
}

// Paints the animating color splash circles.
class _RadialPainter extends CustomPainter {
  _RadialPainter({required this.circles, required this.textDirection});

  final List<_Circle> circles;
  final TextDirection textDirection;

  // Computes the maximum radius attainable such that at least one of the
  // bounding rectangle's corners touches the edge of the circle. Drawing a
  // circle larger than this radius is not needed, since there is no perceivable
  // difference within the cropped rectangle.
  static double _maxRadius(Offset center, Size size) {
    final double maxX = math.max(center.dx, size.width - center.dx);
    final double maxY = math.max(center.dy, size.height - center.dy);
    return math.sqrt(maxX * maxX + maxY * maxY);
  }

  @override
  bool shouldRepaint(_RadialPainter oldPainter) {
    if (textDirection != oldPainter.textDirection) {
      return true;
    }
    if (circles == oldPainter.circles) {
      return false;
    }
    if (circles.length != oldPainter.circles.length) {
      return true;
    }
    for (var i = 0; i < circles.length; i += 1) {
      if (circles[i] != oldPainter.circles[i]) {
        return true;
      }
    }
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final circle in circles) {
      final paint = Paint()..color = circle.color;
      final rect = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.clipRect(rect);
      final leftFraction = switch (textDirection) {
        TextDirection.rtl => 1.0 - circle.horizontalLeadingOffset,
        TextDirection.ltr => circle.horizontalLeadingOffset,
      };
      final center = Offset(leftFraction * size.width, size.height / 2.0);
      final radiusTween =
          Tween<double>(begin: 0, end: _maxRadius(center, size));
      canvas.drawCircle(
        center,
        radiusTween.transform(circle.animation.value),
        paint,
      );
    }
  }
}
