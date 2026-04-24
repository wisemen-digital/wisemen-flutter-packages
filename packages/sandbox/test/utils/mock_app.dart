import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';
import 'package:sandbox/generated/l10n.dart';
import 'package:sandbox/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/open.dart';
import 'package:wisecore/wisecore.dart';

class MockStackRouter extends Mock implements StackRouter {}

class FakePageRouteInfo extends Fake implements PageRouteInfo {}

class MockApp {
  static late final ProviderContainer providerContainer;
  static late final UncontrolledProviderScope app;
  static late final StackRouter mockStackRouter = MockStackRouter();

  static Future<void> init() async {
    initFeatures();
    registerFallbackValue(FakePageRouteInfo());
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    open.overrideFor(OperatingSystem.macOS, () {
      return DynamicLibrary.open('/usr/lib/libsqlite3.dylib');
    });
    providerContainer = ProviderContainer(
      overrides: [
        appRepositoryServiceProvider.overrideWithValue(
          RepositoryService.mock(
            database: Database(
              DatabaseConnection(
                NativeDatabase.memory(),
                closeStreamsSynchronously: true,
              ),
            ),
          ),
        ),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );
  }

  static void tear() {
    providerContainer.dispose();
  }
}

Future<void> pumpRouterApp(
  WidgetTester tester,
  RootStackRouter router, {
  String? initialLink,
  Listenable? reevaluationNotifier,
  NavigatorObserversBuilder observers = AutoRouterDelegate.defaultNavigatorObserversBuilder,
  ProviderContainer? container,
}) {
  return tester
      .pumpWidget(
        UncontrolledProviderScope(
          container: container ?? ProviderContainer(),
          child: MaterialApp.router(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultMaterialLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routeInformationParser: router.defaultRouteParser(),
            routerDelegate: router.delegate(
              reevaluateListenable: reevaluationNotifier,
              deepLinkBuilder: (link) => initialLink == null ? link : DeepLink.path(initialLink),
              navigatorObservers: observers,
            ),
          ),
        ),
      )
      .then((_) => tester.pumpAndSettle());
}
