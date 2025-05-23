import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_zitadel_login/src/providers/wise_zitadel_provider.dart';
import 'package:wise_zitadel_login/src/routes/wise_login_screen_route.dart';

import '../utils/fake_ref.dart';

Text builder(BuildContext context) => const Text('Logo');

class FakeRouteData extends Fake implements RouteData {
  @override
  T argsAs<T>({T Function()? orElse}) {
    return const WiseScreenRouteArgs(builder: builder) as T;
  }
}

void main() {
  group('WiseLoginScreenRoute', () {
    test('should have correct name', () {
      expect(WiseLoginScreenRoute.name, 'WiseLoginScreenRoute');
    });

    test('should create route with correct args', () {
      final route = WiseLoginScreenRoute(builder: builder);

      expect(route.args, isA<WiseScreenRouteArgs>());
      expect(route.args?.builder, builder);
      expect(route.routeName, WiseLoginScreenRoute.name);
    });

    test('should create WiseScreenRouteArgs with builder', () {
      const args = WiseScreenRouteArgs(builder: builder);

      expect(args.builder, builder);
    });

    test('should create WiseScreenRouteArgs without builder', () {
      const args = WiseScreenRouteArgs();

      expect(args.builder, isNull);
    });

    testWidgets('WiseLoginScreenRoute has correct page', (tester) async {
      expect(WiseLoginScreenRoute.page, isA<PageInfo>());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            wiseZitadelOptionsProvider.overrideWithValue(
              FakeRef().read(wiseZitadelOptionsProvider),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: WiseLoginScreenRoute.page.builder(FakeRouteData()),
            ),
          ),
        ),
      );

      expect(find.text('Logo'), findsOneWidget);
    });

    test('WiseLoginScreenRoute extends PageRouteInfo', () {
      final route = WiseLoginScreenRoute();

      expect(route, isA<PageRouteInfo>());
    });
  });
}
