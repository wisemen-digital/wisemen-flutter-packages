import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/app.dart';
import 'package:sandbox/feature_init_util.dart';
import 'package:sandbox/feedback_demo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise_feedback/wise_feedback.dart';

import 'flavors.dart';

Future<void> initMain(Flavor flavor) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  F.appFlavor = flavor;

  // Set portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );

  await clearSecureStorage();

  // if (!F.onesignalKey.isNullOrEmpty) {
  //   try {
  //     OneSignal.initialize(F.onesignalKey!);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
  // if (!kDebugMode && !F.sentryDsn.isNullOrEmpty) {
  //   await SentryFlutter.init(
  //     (options) {
  //       options
  //         ..dsn = F.sentryDsn
  //         ..environment = F.name.toLowerCase();
  //     },
  //   );
  // }

  initFeatures();

  runApp(
    UncontrolledProviderScope(
      container: ProviderContainer(),
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
