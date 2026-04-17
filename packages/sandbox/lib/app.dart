import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/features/shared/shared.dart';
import 'package:sandbox/generated/l10n.dart';
import 'package:sandbox/router/app_router_service.dart';
import 'package:sandbox/router/route_observer.dart';
import 'package:sandbox/utils/utils.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisecore/wisecore.dart';

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
            final theming = WiseTheming(
              supportedThemes: supportedThemes,
              targetPlatform: Theme.of(context).platform,
              selectedTheme: ref.watch(AppSettingsProviders.themeMode).value,
              // selectedTheme: ref.watch(themeModeStreamProvider).value ?? ThemeMode.system,
            );
            return MaterialApp.router(
              title: F.appName,
              theme: theming.lightTheme,
              darkTheme: theming.darkTheme,
              highContrastTheme: theming.lightContrastTheme,
              highContrastDarkTheme: theming.darkContrastTheme,
              themeMode: theming.themeMode,
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
                    navigatorObservers: () => [AppRouterObserver(), VisibleAwareObserver()],
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
