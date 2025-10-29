import 'dart:async';

import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../login.dart';

part 'login_controller.g.dart';

/// Controller for managing login and logout operations.
///
/// This Riverpod-based controller handles the authentication flow, including
/// initiating login with various methods, managing logout (with optional
/// confirmation), and tracking the current authentication state.
///
/// The controller uses AsyncValue to track loading, success, and error states,
/// allowing the UI to react appropriately to authentication operations.
///
/// Example usage:
/// ```dart
/// // Login with a specific method
/// ref.read(loginControllerProvider.notifier).login(loginMethod);
///
/// // Logout with confirmation dialog
/// ref.read(loginControllerProvider.notifier).logout(needsConfirmation: true);
///
/// // Watch authentication state
/// final authState = ref.watch(loginControllerProvider);
/// if (authState.isLoading) {
///   // Show loading indicator
/// }
/// ```
@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<dynamic> build() async {
    listenSelf((previous, next) {
      // ErrorUtils.showErrorDialog(next);
    });
    return null;
  }

  /// Initiates the login flow for the specified authentication method.
  ///
  /// This method:
  /// 1. Sets the state to loading
  /// 2. Updates the selected login method in the provider
  /// 3. Calls the repository's login method to perform OAuth2 authorization
  /// 4. Updates the state to success or error based on the result
  ///
  /// Parameters:
  /// - [method]: The authentication method to use (Apple, Google, Email, or custom)
  ///
  /// Throws any errors from the repository, which are captured in the AsyncValue state.
  ///
  /// Example:
  /// ```dart
  /// final googleMethod = LoginMethod(
  ///   id: 'google',
  ///   name: 'Google',
  ///   type: LoginType.google,
  /// );
  /// await ref.read(loginControllerProvider.notifier).login(googleMethod);
  /// ```
  Future<void> login(LoginMethod method) async {
    try {
      state = const AsyncValue.loading();

      ref.read(selectedLoginMethodProvider.notifier).changeValue(method);
      await ref.watch(LoginFeature.repository).login(method);

      state = const AsyncValue.data(null);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      rethrow;
    } finally {
      ref.read(selectedLoginMethodProvider.notifier).changeValue(null);
    }
  }

  /// Logs out the current user, optionally showing a confirmation dialog.
  ///
  /// This method:
  /// 1. Optionally shows a platform-native confirmation dialog
  /// 2. If confirmed (or no confirmation needed), calls the repository's logout method
  /// 3. Revokes tokens and ends the OAuth2 session with Zitadel
  /// 4. Updates the state to reflect the logout operation
  ///
  /// Parameters:
  /// - [needsConfirmation]: If true, shows a confirmation dialog before logging out.
  ///   The dialog uses platform-specific styling (iOS destructive style on iOS).
  ///   Defaults to false.
  ///
  /// Example:
  /// ```dart
  /// // Logout with confirmation
  /// await ref.read(loginControllerProvider.notifier).logout(needsConfirmation: true);
  ///
  /// // Logout without confirmation
  /// await ref.read(loginControllerProvider.notifier).logout();
  /// ```
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
