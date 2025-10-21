import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

import '../login.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<dynamic> build() async {
    listenSelf((previous, next) {
      // ErrorUtils.showErrorDialog(next);
    });
    return null;
  }

  Future<void> login(LoginMethod method) async {
    try {
      state = const AsyncValue.loading();

      ref.read(selectedLoginMethodProvider.notifier).changeValue(method);
      await ref.watch(LoginFeature.repository).login(method);

      state = const AsyncValue.data(null);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    } finally {
      ref.read(selectedLoginMethodProvider.notifier).changeValue(null);
    }
  }

  Future<void> logout({bool needsConfirmation = false}) async {
    try {
      if (needsConfirmation) {
        final result = await FlutterPlatformAlert.showCustomAlert(
          windowTitle: LoginFeature.localizations.logout,
          text: LoginFeature.localizations.logoutWarning,
          positiveButtonTitle: LoginFeature.localizations.logout,
          neutralButtonTitle: LoginFeature.localizations.cancel,
          options: PlatformAlertOptions(
            ios: IosAlertOptions(
              positiveButtonStyle: IosButtonStyle.destructive,
              neutralButtonStyle: IosButtonStyle.cancel,
            ),
          ),
        );

        if (result == CustomButton.neutralButton) {
          return;
        }
      }

      state = const AsyncValue.loading();

      await ref.watch(LoginFeature.repository).logout();

      state = const AsyncValue.data(null);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    } finally {
      ref.read(selectedLoginMethodProvider.notifier).changeValue(null);
    }
  }
}
