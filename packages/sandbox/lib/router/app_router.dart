import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/router/guards/auth_guard.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: '')
class AppRouter extends RootStackRouter {
  late Ref ref;

  late final List<AutoRoute> routes = [
    AdaptiveRoute(
      path: '/',
      page: SplashScreenRoute.page,
      initial: true,
      guards: [
        AuthGuard(ref: ref),
      ],
    ),
    AdaptiveRoute(
      path: '/settings',
      page: SettingsScreenRoute.page,
    ),
    //mason: insert auto route
  ];
}
