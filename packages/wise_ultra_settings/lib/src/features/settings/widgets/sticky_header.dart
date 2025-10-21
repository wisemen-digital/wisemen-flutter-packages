import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

class StickyHeader extends StatelessWidget {
  const StickyHeader({
    super.key,
    required this.title,
    required this.isPinned,
    required this.scrollPercentage,
    this.outerPadding = padHM,
    this.trailing,
    this.trailingEnd = false,
    this.topPadding = 12,
    this.bottomPadding = 6,
  });

  final String title;
  final bool isPinned;
  final double scrollPercentage;
  final EdgeInsets outerPadding;
  final Widget? trailing;
  final double topPadding;
  final double bottomPadding;
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
