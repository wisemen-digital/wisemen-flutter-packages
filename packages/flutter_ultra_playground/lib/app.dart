// ignore_for_file: unused_import
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_ultra_playground/features/shared/shared.dart';
import 'package:flutter_ultra_playground/generated/l10n.dart';
import 'package:flutter_ultra_playground/network/services/app_service.dart';
import 'package:flutter_ultra_playground/router/app_router.gr.dart';
import 'package:flutter_ultra_playground/router/app_router_service.dart';
import 'package:flutter_ultra_playground/router/route_observer.dart';

import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

import 'flavors.dart';
import 'network/clients/protected_client.dart';
import 'theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectedLoginMethodProvider);
    final themeMode = ref.watch(themeModeProvider).value;
    final theming = WiseTheming(supportedThemes: F.config != null ? brandedThemes : supportedThemes, targetPlatform: Theme.of(context).platform);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: _flavorBanner(
        child: Consumer(
          builder: (context, ref, child) {
            return ValueListenableBuilder(
              valueListenable: theming,
              builder: (context, value, child) {
                return MaterialApp.router(
                  title: F.appName,
                  themeMode: themeMode,
                  theme: theming.lightTheme,
                  darkTheme: theming.darkTheme,
                  highContrastTheme: theming.lightContrastTheme,
                  highContrastDarkTheme: theming.darkContrastTheme,
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
                        deepLinkBuilder: (deepLink) async {
                          F.identifier = deepLink.path.replaceAll('/', '');
                          Future(() async {
                            F.config = await ref.read(appServiceProvider).getAppConfig(F.identifier);
                            PersistantFlavors.saveConfig();
                          });
                          PersistantFlavors.saveConfig();
                          return deepLink;
                        },
                        deepLinkTransformer: (uri) async {
                          F.identifier = uri.path.replaceAll('/', '');
                          Future(() async {
                            F.config = await ref.read(appServiceProvider).getAppConfig(F.identifier);
                            PersistantFlavors.saveConfig();
                          });
                          PersistantFlavors.saveConfig();
                          return uri;
                        },
                        navigatorObservers: () => [AppRouterObserver()],

                        reevaluateListenable: ReevaluateListenable.stream(ref.watch(protectedClientProvider).authenticationStatus),

                        // ignore: require_trailing_commas
                      ),
                );
              },
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
