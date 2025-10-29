import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

/// Widget that displays a sticky section header.
///
/// Renders a section title that can stick to the top of the scroll view.
/// When pinned, shows a bottom border and adjusts spacing based on scroll position.
///
/// Used internally by [SettingsSectionList] to display section headers.
class StickyHeader extends StatelessWidget {
  /// Creates a sticky header widget.
  const StickyHeader({
    required this.title,
    required this.isPinned,
    required this.scrollPercentage,
    super.key,
    this.outerPadding = padHM,
    this.trailing,
    this.trailingEnd = false,
    this.topPadding = 12,
    this.bottomPadding = 6,
  });

  /// The title text to display in the header.
  final String title;

  /// Whether the header is currently pinned to the top.
  final bool isPinned;

  /// The scroll percentage (0-1) when the header is being pinned.
  final double scrollPercentage;

  /// Outer padding around the header.
  final EdgeInsets outerPadding;

  /// Optional trailing widget to display on the right side.
  final Widget? trailing;

  /// Padding above the header.
  final double topPadding;

  /// Padding below the header.
  final double bottomPadding;

  /// Whether the title should expand to fill available space before the trailing widget.
  final bool trailingEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: outerPadding.copyWith(top: topPadding, bottom: bottomPadding),
      margin: EdgeInsets.only(bottom: isPinned ? (1 - scrollPercentage) * 8 : 8),
      decoration: BoxDecoration(
        color: context.backgroundColors.primary,
        border: isPinned ? Border(bottom: BorderSide(color: context.borderColors.primary)) : null,
      ),
      child: Row(
        children: [
          if (trailingEnd) Expanded(child: _buildText(context)) else Flexible(child: _buildText(context)),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      title,
      style: context.title.copyWith(fontSize: 17, color: context.textColors.primary, fontWeight: FontWeight.w700),
    );
  }
}
