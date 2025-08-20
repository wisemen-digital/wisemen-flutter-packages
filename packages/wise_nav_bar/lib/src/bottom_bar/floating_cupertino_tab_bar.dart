import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'tab_indicator_type.dart';

// Standard iOS 10 tab bar height + 10 for the bottom padding
const double _kTabBarHeight = 60;
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;

/// An iOS-styled bottom navigation tab bar.
///
/// Displays multiple tabs using [BottomNavigationBarItem] with one tab being
/// active, the first tab by default.
///
/// This [StatelessWidget] doesn't store the active tab itself. You must
/// listen to the [onTap] callbacks and call `setState` with a new [currentIndex]
/// for the new selection to reflect. This can also be done automatically
/// by wrapping this with a [CupertinoTabScaffold].
///
/// Tab changes typically trigger a switch between [Navigator]s, each with its
/// own navigation stack, per standard iOS design. This can be done by using
/// [CupertinoTabView]s inside each tab builder in [CupertinoTabScaffold].
///
/// If the given [backgroundColor]'s opacity is not 1.0 (which is the case by
/// default), it will produce a blurring effect to the content behind it.
///
/// When used as [CupertinoTabScaffold.tabBar], by default [FloatingCupertinoTabBar]
/// disables text scaling to match the native iOS behavior. To override
/// this behavior, wrap each of the `navigationBar`'s components inside a
/// [MediaQuery] with the desired [TextScaler].
///
/// {@tool dartpad}
/// This example shows a [FloatingCupertinoTabBar] placed in a [CupertinoTabScaffold].
///
/// ** See code in examples/api/lib/cupertino/bottom_tab_bar/cupertino_tab_bar.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CupertinoTabScaffold], which hosts the [FloatingCupertinoTabBar] at the bottom.
///  * [BottomNavigationBarItem], an item in a [FloatingCupertinoTabBar].
///  * <https://developer.apple.com/design/human-interface-guidelines/ios/bars/tab-bars/>
class FloatingCupertinoTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// Creates a tab bar in the iOS style.
  const FloatingCupertinoTabBar({
    required this.items,
    super.key,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = _kDefaultTabBarInactiveColor,
    this.iconSize = 30.0,
    this.height = _kTabBarHeight,
    this.border,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(_kTabBarHeight),
    ),
    this.indicatorType = TabIndicatorType.none,
  })  : assert(
          items.length >= 2,
          "Tabs need at least 2 items to conform to Apple's HIG",
        ),
        assert(
          0 <= currentIndex && currentIndex < items.length,
          'Current index must be between 0 and the number of items minus 1, inclusive',
        ),
        assert(height >= 0.0, 'Height must be non-negative');

  /// The interactive items laid out within the bottom navigation bar.
  final List<BottomNavigationBarItem> items;

  /// The callback that is called when a item is tapped.
  ///
  /// The widget creating the bottom navigation bar needs to keep track of the
  /// current index and call `setState` to rebuild it with the newly provided
  /// index.
  final ValueChanged<int>? onTap;

  /// The index into [items] of the current active item.
  ///
  /// Must be between 0 and the number of tabs minus 1, inclusive.
  final int currentIndex;

  /// The background color of the tab bar. If it contains transparency, the
  /// tab bar will automatically produce a blurring effect to the content
  /// behind it.
  ///
  /// Defaults to [CupertinoTheme]'s `barBackgroundColor` when null.
  final Color? backgroundColor;

  /// The foreground color of the icon and title for the [BottomNavigationBarItem]
  /// of the selected tab.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? activeColor;

  /// The foreground color of the icon and title for the [BottomNavigationBarItem]s
  /// in the unselected state.
  ///
  /// Defaults to a [CupertinoDynamicColor] that matches the disabled foreground
  /// color of the native `UITabBar` component.
  final Color inactiveColor;

  /// The size of all of the [BottomNavigationBarItem] icons.
  ///
  /// This value is used to configure the [IconTheme] for the navigation bar.
  /// When a [BottomNavigationBarItem.icon] widget is not an [Icon] the widget
  /// should configure itself to match the icon theme's size and color.
  final double iconSize;

  /// The height of the [FloatingCupertinoTabBar].
  ///
  /// Defaults to 60.
  final double height;

  /// The border of the [FloatingCupertinoTabBar].
  ///
  /// The default value is a one physical pixel top border with grey color.
  final Border? border;

  /// The border radius of the [FloatingCupertinoTabBar].
  ///
  /// The default value the height of the bar
  final BorderRadius? borderRadius;

  /// The type of the tab indicator.
  final TabIndicatorType indicatorType;

  @override
  Size get preferredSize => Size.fromHeight(height);

  /// Indicates whether the tab bar is fully opaque or can have contents behind
  /// it show through it.
  bool opaque(BuildContext context) {
    final backgroundColor =
        this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return (CupertinoDynamicColor.resolve(backgroundColor, context).a * 255)
            .round() ==
        0xFF;
  }

  @override
  Widget build(BuildContext context) {
    assert(
      debugCheckHasMediaQuery(context),
      'FloatingCupertinoTabBar must be placed inside a MediaQuery widget.',
    );

    final backgroundColor = CupertinoDynamicColor.resolve(
      this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
          ? side
          : side.copyWith(
              color: CupertinoDynamicColor.resolve(side.color, context),
            );
    }

    // Return the border as is when it's a subclass.
    final resolvedBorder = border == null || border.runtimeType != Border
        ? border
        : Border(
            top: resolveBorderSide(border!.top),
            left: resolveBorderSide(border!.left),
            bottom: resolveBorderSide(border!.bottom),
            right: resolveBorderSide(border!.right),
          );

    final inactive = CupertinoDynamicColor.resolve(inactiveColor, context);
    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        border: resolvedBorder,
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 24,
            spreadRadius: -16,
          ),
        ],
      ),
      child: SizedBox(
        height: height,
        child: IconTheme.merge(
          // Default with the inactive state.
          data: IconThemeData(color: inactive, size: iconSize),
          child: DefaultTextStyle(
            // Default with the inactive state.
            style: CupertinoTheme.of(context)
                .textTheme
                .tabLabelTextStyle
                .copyWith(color: inactive),
            child: Semantics(
              explicitChildNodes: true,
              child: Row(
                // Align bottom since we want the labels to be aligned.
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _buildTabItems(context),
              ),
            ),
          ),
        ),
      ),
    );

    if (!opaque(context)) {
      // For non-opaque backgrounds, apply a blur effect.
      result = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: result,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final result = <Widget>[];
    final localizations = CupertinoLocalizations.of(context);

    for (var index = 0; index < items.length; index += 1) {
      final active = index == currentIndex;
      result.add(
        _wrapActiveItem(
          context,
          Expanded(
            // Make tab items part of the EditableText tap region so that
            // switching tabs doesn't unfocus text fields.
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                TextFieldTapRegion(
                  child: Semantics(
                    selected: active,
                    hint: localizations.tabSemanticsLabel(
                      tabIndex: index + 1,
                      tabCount: items.length,
                    ),
                    child: MouseRegion(
                      cursor:
                          kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onTap == null
                            ? null
                            : () {
                                onTap!(index);
                              },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 2,
                            children: _buildSingleTabItem(items[index], active),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                indicatorType.indicatorWidget(
                  selected: active,
                  size: iconSize,
                  color: active
                      ? activeColor ?? CupertinoTheme.of(context).primaryColor
                      : inactiveColor,
                ),
              ],
            ),
          ),
          active: active,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(BottomNavigationBarItem item, bool active) {
    return <Widget>[
      Center(child: active ? item.activeIcon : item.icon),
      if (item.label != null) Text(item.label!),
    ];
  }

  /// Change the active tab item's icon and title colors to active.
  Widget _wrapActiveItem(
    BuildContext context,
    Widget item, {
    required bool active,
  }) {
    if (!active) {
      return item;
    }

    final activeColor = CupertinoDynamicColor.resolve(
      this.activeColor ?? CupertinoTheme.of(context).primaryColor,
      context,
    );
    return IconTheme.merge(
      data: IconThemeData(color: activeColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: activeColor),
        child: item,
      ),
    );
  }

  /// Create a clone of the current [FloatingCupertinoTabBar] but with provided
  /// parameters overridden.
  FloatingCupertinoTabBar copyWith({
    Key? key,
    List<BottomNavigationBarItem>? items,
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
    double? iconSize,
    double? height,
    Border? border,
    int? currentIndex,
    ValueChanged<int>? onTap,
  }) {
    return FloatingCupertinoTabBar(
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      height: height ?? this.height,
      border: border ?? this.border,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }
}
