import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'package:wise_ultra_settings/src/features/settings/settings.dart';

class StickyHeaderSection extends StatelessWidget {
  const StickyHeaderSection({
    required this.title,
    required this.content,
    super.key,
    this.trailing,
    this.hasBackground = true,
  });

  final String title;
  final Widget content;
  final Widget? trailing;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader.builder(
      builder: (context, state) => StickyHeader(trailingEnd: true, title: title, isPinned: state.isPinned, scrollPercentage: state.scrollPercentage),
      sliver: SliverToBoxAdapter(
        child: content,
      ),
    );
  }
}
