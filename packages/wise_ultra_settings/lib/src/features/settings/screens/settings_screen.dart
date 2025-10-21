import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';
import '../widgets/app_bar_button.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key, this.sections});

  final List<SettingsSection>? sections;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = this.sections ?? [BaseSettingsSection.profileManagement, BaseSettingsSection.appInfo, BaseSettingsSection.logout];

    final user = User(uuid: '123', firstName: 'Robbe', lastName: 'Jansens', profilePictureUrl: null);

    return Scaffold(
      backgroundColor: context.backgroundColors.primary,
      appBar: PlatformAppBar(
        backgroundColor: context.backgroundColors.primary,
        title: const SizedBox.shrink(),
        actions: [AppBarButton(title: SettingsFeature.localizations.done(context), isBold: true, onPressed: context.router.maybePop)],
        transitionBetweenRoutes: false,
      ),
      body: Column(
        children: [
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
