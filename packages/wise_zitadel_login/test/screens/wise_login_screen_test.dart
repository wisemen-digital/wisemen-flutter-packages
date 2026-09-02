import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart'
    show PlatformButton2;

import '../utils/fake_authenticator.dart';
import '../utils/test_options.dart';

class MockStackRouter extends Mock implements StackRouter {}

class FakePageRouteInfo extends Fake implements PageRouteInfo {}

Widget buildScreen({
  required WiseZitadelOptions options,
  required WiseZitadelAuthenticator authenticator,
  required StackRouter router,
}) {
  return ProviderScope(
    overrides: [
      wiseZitadelOptionsProvider.overrideWithValue(options),
      wiseZitadelAuthenticatorProvider.overrideWithValue(authenticator),
    ],
    child: MaterialApp(
      home: StackRouterScope(
        controller: router,
        stateHash: 0,
        child: WiseLoginScreen(
          builder: (_) => const Text('Logo'),
        ),
      ),
    ),
  );
}

void main() {
  final mockStackRouter = MockStackRouter();

  setUpAll(() {
    registerFallbackValue(FakePageRouteInfo());
  });

  testWidgets('WiseLoginScreen with builder has buttons and builder content', (
    tester,
  ) async {
    final options = testOptions();

    await tester.pumpWidget(
      buildScreen(
        options: options,
        authenticator: FakeAuthenticator(),
        router: mockStackRouter,
      ),
    );

    expect(find.text('Logo'), findsOneWidget);
    expect(
      find.byType(PlatformButton2),
      findsNWidgets(options.supportedTypes.length),
    );
  });

  testWidgets('WiseLoginScreen logs in with the pressed login type', (
    tester,
  ) async {
    final authenticator = FakeAuthenticator(
      token: OAuthToken(accessToken: 'access_token'),
    );
    OAuthToken? receivedToken;

    await tester.pumpWidget(
      buildScreen(
        options: testOptions(
          onLoginSuccess: (router, ref, token) => receivedToken = token,
        ),
        authenticator: authenticator,
        router: mockStackRouter,
      ),
    );

    await tester.tap(find.byType(PlatformButton2));
    await tester.pumpAndSettle();

    expect(authenticator.loginCalls, [testLoginType]);
    expect(receivedToken?.accessToken, 'access_token');
  });

  testWidgets('WiseLoginScreen shows the pressed button as loading', (
    tester,
  ) async {
    final completer = Completer<OAuthToken?>();
    final authenticator = FakeAuthenticator(completer: completer);

    await tester.pumpWidget(
      buildScreen(
        options: testOptions(),
        authenticator: authenticator,
        router: mockStackRouter,
      ),
    );

    expect(
      tester.widget<PlatformButton2>(find.byType(PlatformButton2)).isLoading,
      isFalse,
    );

    await tester.tap(find.byType(PlatformButton2));
    await tester.pump();

    expect(
      tester.widget<PlatformButton2>(find.byType(PlatformButton2)).isLoading,
      isTrue,
    );

    completer.complete(null);
    await tester.pumpAndSettle();

    expect(
      tester.widget<PlatformButton2>(find.byType(PlatformButton2)).isLoading,
      isFalse,
    );
  });

  testWidgets('WiseLoginScreen stops loading when the login fails', (
    tester,
  ) async {
    final completer = Completer<OAuthToken?>();
    final authenticator = FakeAuthenticator(completer: completer);

    await tester.pumpWidget(
      buildScreen(
        options: testOptions(),
        authenticator: authenticator,
        router: mockStackRouter,
      ),
    );

    await tester.tap(find.byType(PlatformButton2));
    await tester.pump();

    completer.completeError(Exception('the user closed the browser'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isException);
    expect(
      tester.widget<PlatformButton2>(find.byType(PlatformButton2)).isLoading,
      isFalse,
    );
  });

  testWidgets('WiseLoginScreen prepares the authenticator when it is shown', (
    tester,
  ) async {
    final authenticator = FakeAuthenticator();

    await tester.pumpWidget(
      buildScreen(
        options: testOptions(),
        authenticator: authenticator,
        router: mockStackRouter,
      ),
    );
    await tester.pump();

    expect(authenticator.prepareCalls, 1);
  });

  testWidgets('WiseLoginScreen reports a login that prepare resumed', (
    tester,
  ) async {
    final authenticator = FakeAuthenticator(
      resumedToken: OAuthToken(accessToken: 'resumed_token'),
    );
    OAuthToken? receivedToken;

    await tester.pumpWidget(
      buildScreen(
        options: testOptions(
          onLoginSuccess: (router, ref, token) => receivedToken = token,
        ),
        authenticator: authenticator,
        router: mockStackRouter,
      ),
    );
    await tester.pumpAndSettle();

    expect(receivedToken?.accessToken, 'resumed_token');
    expect(authenticator.loginCalls, isEmpty);
  });

  testWidgets('WiseLoginScreen reports nothing when prepare resumes nothing', (
    tester,
  ) async {
    var loginSuccessCalls = 0;

    await tester.pumpWidget(
      buildScreen(
        options: testOptions(
          onLoginSuccess: (router, ref, token) => loginSuccessCalls++,
        ),
        authenticator: FakeAuthenticator(),
        router: mockStackRouter,
      ),
    );
    await tester.pumpAndSettle();

    expect(loginSuccessCalls, 0);
  });
}
