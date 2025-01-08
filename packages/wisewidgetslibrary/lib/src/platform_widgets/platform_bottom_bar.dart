import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

/// [PlatformBottomBar] with CupertinoTabBar and BottomNavigationBar
class PlatformBottomBar extends PlatformWidget<CupertinoTabBar, Widget> {
  /// Constructor [PlatformBottomBar]
  const PlatformBottomBar({
    required this.items,
    required this.onTap,
    required this.currentIndex,
    required this.inActiveColor,
    super.key,
    this.activeColor,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.backgroundColor = Colors.white,
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

  @override
  CupertinoTabBar createCupertinoWidget(BuildContext context) =>
      CupertinoTabBar(
        currentIndex: currentIndex,
        items: items,
        onTap: onTap,
        activeColor: activeColor,
        inactiveColor: inActiveColor ?? CupertinoColors.inactiveGray,
        backgroundColor: backgroundColor,
      );

  @override
  BottomNavigationBar createMaterialWidget(BuildContext context) =>
      BottomNavigationBar(
        items: items,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: activeColor,
        unselectedItemColor: inActiveColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedFontSize: selectedFontSize,
        unselectedFontSize: unselectedFontSize,
      );
}
