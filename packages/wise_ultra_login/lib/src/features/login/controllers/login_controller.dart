import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  Future<void> logout() async {
    try {
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
