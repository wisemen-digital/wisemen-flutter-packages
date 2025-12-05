// ignore_for_file: unused_import
import 'package:auto_route/auto_route.dart';
import 'package:flutter_ultra_playground/features/shared/shared.dart';
import 'package:flutter_ultra_playground/router/guards/auth_guard.dart';
import 'package:flutter_ultra_playground/router/routes/adaptive_bottomsheet_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//mason: insert import

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: '')
class AppRouter extends RootStackRouter {
  late Ref ref;

  late final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: SplashScreenRoute.page,
      initial: true,
      guards: [AuthGuard(ref: ref)],
    ),
    CustomRoute(page: LoginScreenRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
    AutoRoute(page: DashboardScreenRoute.page),
    AdaptiveBottomSheetRoute(page: SettingsScreenRoute.page),
    AdaptiveBottomSheetRoute(page: AppThemeScreenRoute.page),
    AdaptiveBottomSheetRoute(page: PersonalInfoScreenRoute.page),
  ];
}
