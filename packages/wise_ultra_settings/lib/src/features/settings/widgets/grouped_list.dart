import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';

class GroupedList extends StatelessWidget {
  const GroupedList({super.key, required this.items});

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
