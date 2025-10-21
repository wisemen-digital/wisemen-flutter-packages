import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

class SettingsSectionList extends StatelessWidget {
  const SettingsSectionList({required this.section, super.key});

  final SettingsSection section;

  @override
  Widget build(BuildContext context) {
    if (section.getTitle(context).isNotEmpty) {
      return SliverStickyHeader.builder(
        builder: (context, state) =>
            StickyHeader(trailingEnd: true, title: section.getTitle(context), isPinned: state.isPinned, scrollPercentage: state.scrollPercentage),
        sliver: SliverToBoxAdapter(
          child: Padding(
            padding: padHM.copyWith(bottom: 16),
            child: GroupedList(items: section.getItems().map((item) => SettingsCell(item: item)).toList()),
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Padding(
          padding: padM,
          child: GroupedList(items: section.getItems().map((item) => SettingsCell(item: item)).toList()),
        ),
      );
    }
  }
}
