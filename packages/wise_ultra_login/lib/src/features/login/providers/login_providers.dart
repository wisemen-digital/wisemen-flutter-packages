import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../login.dart';

part 'login_providers.g.dart';

/// Provider that exposes the list of supported login methods.
///
/// This provider fetches the available authentication methods from the
/// configured [LoginRepository] and makes them available to the UI.
///
/// The list is determined by [LoginFlavors.loginMethods] and controls
/// which login buttons are displayed in the [LoginScreen].
///
/// Example usage:
/// ```dart
/// final methods = ref.watch(supportedLoginTypesProvider);
/// for (final method in methods) {
///   print('Available: ${method.name}');
/// }
/// ```
@riverpod
class SupportedLoginTypes extends _$SupportedLoginTypes {
  @override
  List<LoginMethod> build() {
    return ref.watch(LoginFeature.repository).getSupportedLoginMethods();
  }
}

/// Provider that tracks the currently selected login method during authentication.
///
/// This provider maintains state for which login method is currently being used,
/// allowing the UI to show loading indicators for the specific method being
/// processed.
///
/// The state is set to a [LoginMethod] when login begins and reset to null
/// when the operation completes (success or failure).
///
/// Example usage:
/// ```dart
/// // Check if a specific method is loading
/// final selectedMethod = ref.watch(selectedLoginMethodProvider);
/// final isGoogleLoading = selectedMethod?.type == LoginType.google;
///
/// // Set the selected method (typically done by LoginController)
/// ref.read(selectedLoginMethodProvider.notifier).changeValue(googleMethod);
///
/// // Clear the selection
/// ref.read(selectedLoginMethodProvider.notifier).changeValue(null);
/// ```
@riverpod
class SelectedLoginMethod extends _$SelectedLoginMethod {
  @override
  LoginMethod? build() {
    return null;
  }

  /// Updates the currently selected login method.
  ///
  /// Parameters:
  /// - [value]: The login method being processed, or null to clear the selection
  void changeValue(LoginMethod? value) => state = value;
}
