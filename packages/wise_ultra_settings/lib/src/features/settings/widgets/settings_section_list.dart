import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

/// Widget that renders a settings section with its header and items.
///
/// This widget displays a section title as a sticky header (if the title is not empty)
/// and renders all the section's items in a grouped list below it.
///
/// Used internally by [SettingsScreen] to render each section.
class SettingsSectionList extends StatelessWidget {
  /// Creates a settings section list widget.
  ///
  /// The [section] parameter defines the section to display.
  const SettingsSectionList({required this.section, super.key});

  /// The settings section to display.
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
