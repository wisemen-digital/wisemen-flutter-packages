import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisecore/wisecore.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

/// Widget that renders a single settings item as a tappable cell.
///
/// Displays the item's title, optional trailing text or widget, and a chevron
/// icon for navigable items. The logout item receives special styling with
/// error color and bold text.
///
/// Used internally by [SettingsSectionList] to render each item in a section.
class SettingsCell extends ConsumerWidget {
  /// Creates a settings cell widget.
  ///
  /// The [item] parameter defines the settings item to display.
  const SettingsCell({required this.item, super.key});

  /// The settings item to display.
  final SettingsItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trailingWidget = item.getTrailingWidget(context);
    final trailingText = item.getTrailingText(ref);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap(ref),
        child: Padding(
          padding: const EdgeInsets.all(10).copyWith(left: 15),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item.getTitle(context),
                  style: context.body.copyWith(
                    fontSize: 17,
                    color: item == BaseSettingsItem.logout ? context.textColors.errorPrimary : context.textColors.primary,
                    fontWeight: item == BaseSettingsItem.logout ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (trailingWidget != null) ...[gapWS, trailingWidget],
              if (trailingText != null) ...[
                gapWS,
                Text(trailingText, style: context.body.copyWith(fontSize: 15, color: context.textColors.tertiary)),
              ],
              if (item.onTap(ref) != null && item != BaseSettingsItem.logout) ...[
                gapWS,
                SvgPicture.asset(SettingsFeature.assets.chevronRight, colorFilter: context.textColors.primary.colorFiltered()),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
