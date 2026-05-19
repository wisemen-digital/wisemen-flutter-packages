import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/router/guards/auth_guard.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

import 'adaptive_bottom_sheet_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: '')
class AppRouter extends RootStackRouter {
  late Ref ref;

  late final List<AutoRoute> routes = [
    CustomRoute(
      path: '/',
      page: SplashScreenRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: [
        AuthGuard(ref: ref),
      ],
    ),
    CustomRoute(
      page: WiseLoginScreenRoute.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    AdaptiveRoute(page: SettingsScreenRoute.page),
    AdaptiveBottomSheetRoute(page: DamageFormScreenRoute.page),
    //mason: insert auto route
  ];
}
