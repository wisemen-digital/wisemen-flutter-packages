import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../login.dart';

part 'login_providers.g.dart';

@riverpod
class SupportedLoginTypes extends _$SupportedLoginTypes {
  List<LoginMethod> build() {
    return ref.watch(LoginFeature.repository).getSupportedLoginMethods();
  }
}

@riverpod
class SelectedLoginMethod extends _$SelectedLoginMethod {
  LoginMethod? build() {
    return null;
  }

  void changeValue(LoginMethod? value) => state = value;
}
