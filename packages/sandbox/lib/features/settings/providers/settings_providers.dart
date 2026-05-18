import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisecore/wisecore.dart';

import '../settings.dart';

part 'settings_providers.g.dart';

class SettingsProviders {
  static var user = userProviderProvider;
}

@riverpod
class UserProvider extends _$UserProvider with LoadingStreamProvider<User?> {
  @override
  Stream<User?> build() {
    return ref.watch(SettingsFeature.settingsRepository).user;
  }

  @override
  Future<void> onError(Object error, StackTrace stackTrace) async {
    // to toast
  }

  @override
  Future<void> refreshFunction() async {
    await ref.watch(SettingsFeature.settingsRepository).getMe();
  }
}
