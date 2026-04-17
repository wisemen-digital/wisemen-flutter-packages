import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/features/shared/shared_feature.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

@RoutePage()
class EmptyScreen extends ConsumerWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: PlatformButton2.text(
            text: 'Log out',
            onPressed: () {
              ref.read(SharedFeature.appSettingsRepository).updateSelectedTheme(supportedThemes.firstWhere((e) => e.themeType == WiseThemeType.dark));
            },
            color: context.backgroundColors.brandSecondary,
            foregroundColor: context.foregroundColors.brandPrimary,
            textStyle: context.headline,
            borderSide: BorderSide(color: context.borderColors.primary),
            size: const Size.fromHeight(40),
          ),
        ),
      ),
    );
  }
}
