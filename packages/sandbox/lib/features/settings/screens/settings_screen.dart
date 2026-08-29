import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/router/app_router.gr.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisecore/wisecore.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> with VisibleAwareStateMixin {
  @override
  void onViewDidAppear(AppearanceType type) {
    ref.read(SettingsFeature.settingsRepository).getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          PlatformButton2.text(
            text: 'navigate to BiDirectional Paged List',
            textStyle: context.body,
            onPressed: () => context.router.push(const BiDirectionalCalendarDemoScreenRoute()),
            color: context.backgroundColors.brandPrimary,
            foregroundColor: context.foregroundColors.brandPrimary,
          ),
          Center(
            child: ref
                .watch(SettingsProviders.user)
                .whenStream(
                  data: (data) => Text(
                    data?.fullName ?? '',
                    style: context.body.copyWith(color: context.textColors.primary),
                  ),
                  error: (error, stackTrace) => ErrorWidget(error),
                  loading: () => const CircularProgressIndicator(),
                ),
          ),
        ],
      ),
    );
  }
}
