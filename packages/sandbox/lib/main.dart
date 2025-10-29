import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/app.dart';
import 'package:sandbox/feature_init_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wisecore/wisecore.dart';

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
