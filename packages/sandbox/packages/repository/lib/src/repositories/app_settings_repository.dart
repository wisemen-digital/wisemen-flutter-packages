import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repository/src/services/app_settings_service.dart';
import 'package:sandbox/features/shared/shared.dart';
import 'package:wise_theming/src/theming/wise_theme.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  const AppSettingsRepositoryImpl({
    required this.ref,
  });

  final Ref ref;

  @override
  Stream<bool> get devMode => ref.watch(appSettingsService).devMode;

  @override
  Stream<WiseTheme?> get selectedTheme => ref.watch(appSettingsService).theme;

  @override
  Future<void> updateDevMode(bool devMode) async {
    await ref.read(appSettingsService).updateDevMode(devMode);
  }

  @override
  Future<void> updateSelectedTheme(WiseTheme theme) async {
    await ref.read(appSettingsService).updateTheme(theme);
  }
}

final appSettingsRepository = Provider<AppSettingsRepositoryImpl>(
  (ref) => AppSettingsRepositoryImpl(ref: ref),
);
