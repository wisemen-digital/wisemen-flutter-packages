import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisecore/wisecore.dart';

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
      body: Center(
        child: StreamBuilder<String>(
          stream: ref.watch(SettingsFeature.settingsRepository).userName,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Text('Hello, ${snapshot.data}');
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
