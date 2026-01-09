import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/router/app_router.gr.dart';
import 'package:sandbox/utils/utils.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wiseclient/wiseclient.dart' show AuthenticationStatus;

class AuthGuard extends AutoRouteGuard {
  final Ref ref;
  AuthGuard({required this.ref});

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final status = await ref.read(appRepositoryServiceProvider).authenticationStatus.first;
    switch (status) {
      case AuthenticationStatus.initial:
        resolver.next();
      case AuthenticationStatus.unauthenticated:
        resolver.redirectUntil(WiseLoginScreenRoute());
      case AuthenticationStatus.authenticated:
        resolver.redirectUntil(const EmptyScreenRoute());
    }
  }
}
