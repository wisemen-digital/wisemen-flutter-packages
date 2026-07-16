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
      page: DashboardRouter.page,
      children: [
        AdaptiveRoute(
          path: 'settings',
          page: SettingsScreenRoute.page,
          title: (context, data) => 'Settings',
        ),
        AdaptiveRoute(
          path: 'other-settings',
          page: OtherSettingsScreenRoute.page,
          title: (context, data) => 'Other settings',
        ),
        AdaptiveRoute(page: EmptyRoute.page),
      ],
    ),
    AdaptiveRoute(
      path: '/bidirectional-calendar-demo',
      page: BiDirectionalCalendarDemoScreenRoute.page,
      title: (context, data) => 'Bi-directional calendar demo',
    ),
    //mason: insert auto route
  ];
}
