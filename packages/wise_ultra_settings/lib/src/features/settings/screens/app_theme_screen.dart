import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';

import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../providers/settings_providers.dart';

import '../settings.dart';

@RoutePage()
class AppThemeScreen extends ConsumerWidget {
  const AppThemeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider).value;

    return Scaffold(
      backgroundColor: context.backgroundColors.primary,
      appBar: PlatformAppBar(
        backgroundColor: context.backgroundColors.primary,
        title: const SizedBox.shrink(),
        actions: [AppBarButton(title: SettingsFeature.localizations.done(context), isBold: true, onPressed: context.router.maybePop)],
        transitionBetweenRoutes: false,
      ),
      body: _buildThemeModeOptions(context, ref, themeMode),
    );
  }

  Widget _buildThemeModeOptions(BuildContext context, WidgetRef ref, ThemeMode? currentMode) {
    return ListView(
      padding: padM,
      children: [
        _buildThemeModeOption(
          context: context,
          ref: ref,
          title: SettingsFeature.localizations.lightMode(context),
          themeMode: ThemeMode.light,
          isSelected: currentMode == ThemeMode.light,
          icon: Icons.light_mode,
        ),
        gapHM,
        _buildThemeModeOption(
          context: context,
          ref: ref,
          title: SettingsFeature.localizations.darkMode(context),
          themeMode: ThemeMode.dark,
          isSelected: currentMode == ThemeMode.dark,
          icon: Icons.dark_mode,
        ),
        gapHM,
        _buildThemeModeOption(
          context: context,
          ref: ref,
          title: SettingsFeature.localizations.system(context),
          themeMode: ThemeMode.system,
          isSelected: currentMode == ThemeMode.system,
          icon: Icons.brightness_auto,
        ),
      ],
    );
  }

  Widget _buildThemeModeOption({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required ThemeMode themeMode,
    required bool isSelected,
    required IconData icon,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          ref.read(themeModeProvider.notifier).setThemeMode(themeMode);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: padM,
          decoration: BoxDecoration(
            color: context.backgroundColors.secondary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? context.foregroundColors.brandPrimary : context.borderColors.primary, width: isSelected ? 2 : 1),
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? context.foregroundColors.brandPrimary : context.foregroundColors.primary, size: 24),
              gapWM,
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: context.textColors.primary),
                ),
              ),
              if (isSelected) Icon(Icons.check_circle, color: context.foregroundColors.brandPrimary, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
