import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'bottom_bar.dart';

/// [PlatformFloatingBottomBar] with FloatingCupertinoTabBar and FloatingMaterialBottomBar
class PlatformFloatingBottomBar
    extends PlatformWidget<FloatingCupertinoTabBar, Widget> {
  /// Constructor [PlatformFloatingBottomBar]
  const PlatformFloatingBottomBar({
    required this.items,
    required this.onTap,
    required this.currentIndex,
    required this.inActiveColor,
    super.key,
    this.activeColor,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.backgroundColor = Colors.white,
    this.indicatorType = TabIndicatorType.none,
    this.borderSide,
    this.borderRadius,
  });

  /// Navigation bar items
  final List<BottomNavigationBarItem> items;

  /// Void callback onTap with int tabIndex
  final void Function(int index) onTap;

  /// Current index (selected tab)
  final int currentIndex;

  /// Active color (defaults to theme values)
  final Color? activeColor;

  /// Inactive color (defaults to theme values for Android)
  /// on iOS defaults to [CupertinoColors.inactiveGray]
  final Color? inActiveColor;

  /// Selected font size (defaults to 14) only used for Android
  final double selectedFontSize;

  /// Unselected font size (defaults to 12) only used for Android
  final double unselectedFontSize;

  /// Background color (defaults to white)
  final Color backgroundColor;

  /// Type of the tab indicator
  final TabIndicatorType indicatorType;

  /// Tab bar's border side
  final BorderSide? borderSide;

  /// Tab bar's border radius
  final BorderRadius? borderRadius;

  @override
  FloatingCupertinoTabBar createCupertinoWidget(BuildContext context) =>
      FloatingCupertinoTabBar(
        currentIndex: currentIndex,
        items: items,
        onTap: onTap,
        activeColor: activeColor,
        inactiveColor: inActiveColor ?? CupertinoColors.inactiveGray,
        backgroundColor: backgroundColor,
        border: Border.fromBorderSide(
          borderSide ?? BorderSide.none,
        ),
        borderRadius: borderRadius,
        indicatorType: indicatorType,
      );

  @override
  FloatingMaterialBottomBar createMaterialWidget(BuildContext context) =>
      FloatingMaterialBottomBar(
        items: items,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: activeColor,
        unselectedItemColor: inActiveColor,
        backgroundColor: backgroundColor,
        selectedFontSize: selectedFontSize,
        unselectedFontSize: unselectedFontSize,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(kToolbarHeight),
          side: borderSide ?? BorderSide.none,
        ),
        indicatorType: indicatorType,
      );
}
