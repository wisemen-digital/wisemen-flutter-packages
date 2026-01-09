import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/generated/l10n.dart';
import 'package:sandbox/router/app_router_service.dart';
import 'package:sandbox/router/route_observer.dart';
import 'package:sandbox/theme/theme.dart';
import 'package:sandbox/utils/utils.dart';

import 'flavors.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: _flavorBanner(
        child: Consumer(
          builder: (context, ref, child) {
            return MaterialApp.router(
              title: F.appName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              // themeMode:
              //     ref.watch(themeModeStreamProvider).value ?? ThemeMode.system,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultMaterialLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              routerConfig: ref
                  .watch(appRouterServiceProvider)
                  .config(
                    deepLinkBuilder: (deepLink) => deepLink,
                    navigatorObservers: () => [AppRouterObserver()],
                    reevaluateListenable: ReevaluateListenable.stream(
                      ref.watch(appRepositoryServiceProvider).authenticationStatus,
                    ),
                  ),
            );
          },
        ),
      ),
    );
  }
}

Widget _flavorBanner({required Widget child, bool show = true}) => show && F.appFlavor != Flavor.PRODUCTION
    ? Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          location: BannerLocation.topStart,
          message: F.bannerName!,
          color: const Color(0xFF7D1B1A),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0, letterSpacing: 1.0, color: Colors.white),
          textDirection: TextDirection.ltr,
          child: child,
        ),
      )
    : child;
