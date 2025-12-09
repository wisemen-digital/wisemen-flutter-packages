// ignore_for_file: unused_import
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/router/app_router.dart';
import 'package:sandbox/router/app_router.gr.dart';
import 'package:wiseclient/wiseclient.dart';

import '../../network/clients/protected_client.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref ref;
  AuthGuard({required this.ref});

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final status =
        await ref.read(protectedClientProvider).authenticationStatus.first;
    switch (status) {
      case AuthenticationStatus.initial:
        resolver.next();
      case AuthenticationStatus.unauthenticated:
      case AuthenticationStatus.authenticated:
        resolver.redirectUntil(const SettingsScreenRoute());
    }
  }
}
