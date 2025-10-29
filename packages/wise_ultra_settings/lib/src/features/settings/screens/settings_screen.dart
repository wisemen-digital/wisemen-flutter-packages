import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

/// Main settings screen that displays user profile and configurable settings sections.
///
/// This screen shows a profile summary at the top followed by customizable
/// sections of settings items. If no sections are provided, it defaults to
/// showing profile management, app info, and logout sections.
///
/// Example usage with default sections:
/// ```dart
/// context.router.push(const SettingsRoute());
/// ```
///
/// Example usage with custom sections:
/// ```dart
/// context.router.push(SettingsRoute(
///   sections: [
///     BaseSettingsSection.profileManagement,
///     MyCustomSection.mySection,
///     BaseSettingsSection.logout,
///   ],
/// ));
/// ```
class SettingsScreen extends ConsumerWidget {
  /// Creates a settings screen.
  ///
  /// If [sections] is null, defaults to showing:
  /// - [BaseSettingsSection.profileManagement]
  /// - [BaseSettingsSection.appInfo]
  /// - [BaseSettingsSection.logout]
  const SettingsScreen({super.key, this.sections});

  /// Optional list of settings sections to display.
  ///
  /// Sections will be displayed in the order they appear in the list.
  /// If null, default sections will be used.
  final List<SettingsSection>? sections;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = this.sections ?? [BaseSettingsSection.profileManagement, BaseSettingsSection.appInfo, BaseSettingsSection.logout];

    final user = ref.watch(currentUserProvider).value;

    return Scaffold(
      backgroundColor: context.backgroundColors.primary,
      appBar: PlatformAppBar(
        backgroundColor: context.backgroundColors.primary,
        title: const SizedBox.shrink(),
        actions: [
          AppBarButton(
            title: SettingsFeature.localizations.done(context),
            isBold: true,
            onPressed: () {
              ref.watch(SettingsFeature.navigationManager).completeSettingsScreen();
            },
          ),
        ],
        transitionBetweenRoutes: false,
      ),
      body: Column(
        children: [
          if (user != null)
            Padding(
              padding: padM.copyWith(top: 0),
              child: ProfileSummary(user: user),
            ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                const SliverPadding(padding: EdgeInsets.only(top: 1)),
                ...sections.map((s) => SettingsSectionList(section: s)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
