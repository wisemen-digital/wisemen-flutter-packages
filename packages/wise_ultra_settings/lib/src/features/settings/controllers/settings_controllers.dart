import 'package:flutter/services.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wise_ultra_settings/src/features/settings/providers/settings_providers.dart';
import 'package:wise_ultra_settings/src/features/settings/settings_feature.dart';

part 'settings_controllers.g.dart';

@riverpod
class SettingsControllers extends _$SettingsControllers {
  @override
  FutureOr<dynamic> build() async {
    listenSelf(
      (previous, next) {
        // ErrorUtils.showErrorDialog(next);
      },
    );
    return null;
  }

  Future<void> cancelEditProfile() async {
    final hasEdited = ref.read(hasEditedUserProvider);

    if (!hasEdited || await _confirmCancel()) {
      ref.read(SettingsFeature.navigationManager).completeSettingsScreen();
    }
  }

  Future<bool> _confirmCancel() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
    final result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: SettingsFeature.localizations.areYouSure,
      text: SettingsFeature.localizations.unsavedChangesWarning,
      positiveButtonTitle: SettingsFeature.localizations.yes,
      negativeButtonTitle: SettingsFeature.localizations.no,
      options: PlatformAlertOptions(
        ios: IosAlertOptions(
          positiveButtonStyle: IosButtonStyle.normal,
          negativeButtonStyle: IosButtonStyle.cancel,
        ),
      ),
    );

    return result == CustomButton.positiveButton;
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    DateTime? birthDate,
  }) async {
    try {
      state = const AsyncValue.loading();

      ref.read(SettingsFeature.repository).updateUser(
            firstName: firstName,
            lastName: lastName,
            birthDate: birthDate,
          );

      state = const AsyncValue.data(null);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
