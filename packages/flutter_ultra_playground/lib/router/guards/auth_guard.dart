// ignore_for_file: unused_import
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ultra_playground/flavors.dart';
import 'package:flutter_ultra_playground/network/services/app_service.dart';
import 'package:flutter_ultra_playground/router/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wiseclient/wiseclient.dart';

import '../../network/clients/protected_client.dart';
import '../app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref ref;
  AuthGuard({required this.ref});

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final status = await ref.read(protectedClientProvider).authenticationStatus.first;

    const PageRouteInfo? unauthenticatedRoute = LoginScreenRoute();
    const PageRouteInfo? authenticatedRoute = DashboardScreenRoute();

    switch (status) {
      case AuthenticationStatus.initial:
        resolver.next();
      case AuthenticationStatus.unauthenticated:
        await Future.delayed(const Duration(milliseconds: 300));
        try {
          F.config = await ref.read(appServiceProvider).getAppConfig(F.identifier);
          PersistantFlavors.saveConfig();
        } catch (e) {}

        if (router.stack.where((p) => p.name == unauthenticatedRoute.routeName).isNotEmpty) {
          return;
        }

        router.replaceAll([unauthenticatedRoute]);
      case AuthenticationStatus.authenticated:
        try {
          F.config = await ref.read(appServiceProvider).getAppConfig(F.identifier);
          PersistantFlavors.saveConfig();
        } catch (e) {}

        if (router.stack.where((p) => p.name == authenticatedRoute.routeName).isNotEmpty) {
          return;
        }

        router.replaceAll([authenticatedRoute]);
    }
  }
}
