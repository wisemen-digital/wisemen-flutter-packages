import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padL,
          child: Column(
            spacing: 8,
            children: [
              PlatformDropdownPicker<ThemeModeDropDownModel>(
                onChanged: (option) async {
                  if (option != null) {
                    await ref
                        .read(settingsControllerProvider.notifier)
                        .toggleThemeMode(option.mode);
                  }
                },
                options: ThemeMode.values
                    .map((mode) => ThemeModeDropDownModel(mode: mode))
                    .toList(),
                borderRadius: BorderRadius.circular(12),
                focusNode: FocusNode(),
                selected: ref.watch(SettingsProviders.themeMode).value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  padding: padM,
                  child: Row(
                    children: [
                      Text(
                        ref.watch(themeModeStreamProvider).value?.name ?? '',
                      ),
                    ],
                  ),
                ),
              ),
              PlatformSwitch(
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Theme.of(context).colorScheme.secondary,
                value: ref.watch(switchValueProvider),
                onChanged: ref.read(switchValueProvider.notifier).changeValue,
              ),
              PlatformAnimatedButton(
                onPressed: () async {
                  FlutterPlatformAlert.showCustomAlert(
                    windowTitle: 'windowTitle',
                    text: 'text',
                    negativeButtonTitle: 'doom',
                    neutralButtonTitle: 'gloom',
                    options: PlatformAlertOptions(
                      ios: IosAlertOptions(
                        alertStyle: IosAlertStyle.actionSheet,
                        negativeButtonStyle: IosButtonStyle.destructive,
                        neutralButtonStyle: IosButtonStyle.normal,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Other settings',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(
                height: 1000,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
