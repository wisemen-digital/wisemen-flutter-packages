import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repository/repository.dart';
import 'package:sandbox/app.dart';
import 'package:sandbox/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

import 'flavors.dart';
import 'utils/utils.dart';

Future<void> initMain(Flavor flavor) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load();

  F.appFlavor = flavor;

  await clearSecureStorage();

  initFeatures();

  final repository = RepositoryService(
    baseUrl: F.baseUrl,
    clientId: F.clientId,
    onLogout: () {},
  );

  runApp(
    UncontrolledProviderScope(
      container: ProviderContainer(
        overrides: [
          appRepositoryServiceProvider.overrideWithValue(repository),
          wiseZitadelOptionsProvider.overrideWithValue(
            WiseZitadelOptions(
              zitadelBaseUrl: F.zitadelBaseUrl,
              bundleId: F.bundleId,
              applicationId: F.zitadelAppId,
              organizationId: F.zitadelOrganizationId,
              buttonOptions: WiseZitadelButtonOptions(
                color: (context) => Colors.white,
                buttonTextStyle: (context) => const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onLoginSuccess: (router, ref, token) async {
                if (token == null) {
                  return;
                }
                await ref.read(appRepositoryServiceProvider).setToken(token);
                router.replace(const EmptyScreenRoute());
              },
              supportedTypes: [
                const ZitadelLoginType(
                  buttonText: 'Internal',
                  iconSvgString: '',
                  idp: '',
                ),
              ],
            ),
          ),
        ],
      ),
      child: const App(),
    ),
  );
}

Future<void> clearSecureStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('firstRun') ?? true) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
    await prefs.setBool('firstRun', false);
  }
}
