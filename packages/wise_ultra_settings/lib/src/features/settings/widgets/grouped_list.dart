import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';

/// Widget that displays a list of items in a grouped card style.
///
/// Renders items in a rounded container with separators between each item.
/// Used internally to display settings items within a section.
class GroupedList extends StatelessWidget {
  /// Creates a grouped list widget.
  const GroupedList({required this.items, super.key});

  /// The list of widgets to display in the grouped container.
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.backgroundColors.secondary),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => items[index],
          itemCount: items.length,
          separatorBuilder: (context, index) => Container(margin: const EdgeInsets.only(left: 15), height: 0.5, color: context.borderColors.primary),
        ),
      ),
    );
  }
}
