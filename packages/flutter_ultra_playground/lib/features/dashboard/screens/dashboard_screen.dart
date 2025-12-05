import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

import '../../../network/clients/clients.dart';
import '../../../router/router.dart';

@RoutePage()
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UpdateWrapper(
      child: Scaffold(
        backgroundColor: context.backgroundColors.primary,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                child: Text('Settings', style: context.title.copyWith(color: context.foregroundColors.brandPrimary)),
                onPressed: () => context.router.push(const SettingsScreenRoute()),
              ),
              CupertinoButton(
                child: Text('Refresh token', style: context.title.copyWith(color: context.foregroundColors.brandPrimary)),
                onPressed: () async {
                  context.router.push(const SettingsScreenRoute());
                  final token = await ref.read(protectedClientProvider).fresh.token;
                  ref.read(baseLoginRepositoryProvider).refresh(token);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
