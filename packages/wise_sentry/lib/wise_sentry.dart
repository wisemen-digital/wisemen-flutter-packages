/// Library for sentry logging
library wise_sentry;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

export 'package:sentry_flutter/sentry_flutter.dart' show SentryWidgetsFlutterBinding;

export 'src/core.dart';

/// Initialize Wisemen Sentry
/// [dsn] Sentry DSN
/// [appRunner] Function that runs the main app widget
/// [environment] Optional environment string (e.g., 'production', 'staging')
/// [productionSampleRate] Sample rate for production environment (default is 0.2)
/// [logInDebugMode] Whether to log errors in debug mode (default is false)
Future<void> initializeSentry({
  required String? dsn,
  required Widget Function() appRunner,
  String? environment,
  double productionSampleRate = 0.2,
  bool logInDebugMode = false,
}) async {
  if (dsn == null || dsn.isEmpty) {
    // If no DSN is provided, run the app without Sentry
    print('WiseSentry: No DSN provided, running without Sentry.');
    runApp(appRunner());
    return;
  }

  await SentryFlutter.init(
    (options) {
      options
        ..dsn = dsn
        ..environment = environment
        ..tracesSampleRate = environment == 'production' ? productionSampleRate : 1.0
        ..beforeSend = (event, hint) {
          if (!logInDebugMode && kDebugMode) {
            print('Sentry exception: $event | ${event.tags}');
            // Drop events in debug mode if logging is disabled
            return null;
          } else {
            return event;
          }
        };
    },
    appRunner: () => runApp(
      SentryWidget(child: appRunner()),
    ),
  );
}
