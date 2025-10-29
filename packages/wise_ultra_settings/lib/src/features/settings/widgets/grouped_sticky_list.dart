import 'package:flutter/material.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

class GroupedStickyList extends StatelessWidget {
  const GroupedStickyList({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return StickyHeaderSection(
      title: title,
      content: Padding(
        padding: padHM,
        child: GroupedList(items: items),
      ),
    );
  }
}
