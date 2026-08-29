import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repository/repository.dart';
import 'package:sandbox/app.dart';
import 'package:sandbox/feedback_demo.dart';
import 'package:sandbox/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise_feedback/wise_feedback.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wisecore/wisecore.dart';

import 'flavors.dart';
import 'utils/utils.dart';

Future<void> initMain(Flavor flavor) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load();

  F.appFlavor = flavor;

  await clearSecureStorage();

  initFeatures();

  final RepositoryService repository;
  if (flavor == Flavor.DEVELOPMENT) {
    repository = RepositoryService.mock();
  } else {
    repository = RepositoryService(
      baseUrl: F.baseUrl,
      authUrl: F.zitadelBaseUrl,
      clientId: F.clientId,
      onLogout: () {},
    );
  }

  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    UncontrolledProviderScope(
      container: ProviderContainer(
        overrides: [
          appRepositoryServiceProvider.overrideWithValue(repository),
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          wiseZitadelOptionsProvider.overrideWithValue(
            WiseZitadelOptions(
              zitadelBaseUrl: F.zitadelBaseUrl,
              bundleId: F.bundleId,
              applicationId: F.zitadelAppId,
              organizationId: F.zitadelOrganizationId,
              buttonOptions: WiseZitadelButtonOptions(
                color: (context) => context.backgroundColors.primary,
                buttonTextStyle: (context) => context.body.copyWith(
                  color: context.foregroundColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onLoginSuccess: (router, ref, token) async {
                if (token == null) {
                  return;
                }
                await ref.read(appRepositoryServiceProvider).setToken(token);
                router.replace(const SettingsScreenRoute());
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
      // wise_feedback smoke test: tap the bug button to capture a screenshot +
      // title + description and file it as a Linear issue. Supply a
      // least-privilege Linear bot token + team id via
      // --dart-define=LINEAR_TOKEN=... --dart-define=LINEAR_TEAM_ID=... .
      child: WiseFeedback(
        transport: LinearDirectTransport(
          token: const String.fromEnvironment('LINEAR_TOKEN'),
          teamId: const String.fromEnvironment('LINEAR_TEAM_ID'),
        ),
        // Structured bug template: Current/Desired Situation, Steps from the
        // nav breadcrumb, and auto-filled Context.
        template: const BugReportTemplate(),
        navigatorObserver: wiseFeedbackObserver,
        reporter: () => const FeedbackReporter(
          id: 'demo-user',
          name: 'Demo User',
          email: 'demo@wisemen.digital',
        ),
        metadataBuilder: () => {'environment': F.name},
        categories: const ['bug', 'improvement', 'change request'],
        onStatusChanged: (status) {
          switch (status) {
            case FeedbackSuccess(:final result):
              debugPrint('wise_feedback: filed ${result.issueUrl}');
            case FeedbackFailure(:final error):
              debugPrint('wise_feedback: failed $error');
            case FeedbackIdle():
            case FeedbackSubmitting():
              break;
          }
        },
        child: const App(),
      ),
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
