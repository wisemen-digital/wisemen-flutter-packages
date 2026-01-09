import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref ref;
  AuthGuard({required this.ref});

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    // final status =
    //     await ref.read(protectedClientProvider).authenticationStatus.first;
    // switch (status) {
    //   case AuthenticationStatus.initial:
    //     resolver.next();
    //   case AuthenticationStatus.unauthenticated:
    //   case AuthenticationStatus.authenticated:
    //     resolver.redirectUntil();
    // }
  }
}
