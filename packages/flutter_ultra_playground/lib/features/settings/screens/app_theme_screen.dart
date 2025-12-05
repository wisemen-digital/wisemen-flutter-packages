import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart' as settings;

@RoutePage()
class AppThemeScreen extends ConsumerWidget {
  const AppThemeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const settings.AppThemeScreen();
  }
}
