import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart'
    show PlatformButton2;

import '../utils/fake_ref.dart';
import '../utils/mock_auth.dart';

class MockStackRouter extends Mock implements StackRouter {}

class FakePageRouteInfo extends Fake implements PageRouteInfo {}

void main() {
  final mockStackRouter = MockStackRouter();

  setUpAll(() {
    mockPlatformAlerts();
    registerFallbackValue(FakePageRouteInfo());
  });

  tearDown(() {
    loginCalls = 0;
  });

  testWidgets('WiseLoginScreen with builder has buttons and builder content',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wiseZitadelOptionsProvider.overrideWithValue(
            FakeRef().read(wiseZitadelOptionsProvider),
          ),
        ],
        child: MaterialApp(
          home: WiseLoginScreen(
            builder: (_) => const Text('Logo'),
          ),
        ),
      ),
    );

    expect(find.text('Logo'), findsOneWidget);
    expect(
      find.byType(PlatformButton2),
      findsNWidgets(
        FakeRef().read(wiseZitadelOptionsProvider).supportedTypes.length,
      ),
    );
  });

  testWidgets('WiseLoginScreen can call login method', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wiseZitadelOptionsProvider.overrideWithValue(
            FakeRef().read(wiseZitadelOptionsProvider),
          ),
        ],
        child: MaterialApp(
          home: StackRouterScope(
            controller: mockStackRouter,
            stateHash: 0,
            child: WiseLoginScreen(
              builder: (_) => const Text('Logo'),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(PlatformButton2), findsOneWidget);
    await tester.tap(find.byType(PlatformButton2));
    expect(loginCalls, isPositive);
  });
}
