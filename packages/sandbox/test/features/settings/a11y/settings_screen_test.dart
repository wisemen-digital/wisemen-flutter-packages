import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandbox/features/settings/settings.dart';
import 'package:snaptest/snaptest.dart';
import 'package:wisecore/wisecore.dart';

import '../../../utils/utils.dart';

void main() {
  late ObserverRouter router = ObserverRouter();
  setUpAll(MockApp.init);
  tearDownAll(MockApp.tear);

  Future<void> pumpRouter(WidgetTester tester) => pumpRouterApp(
    tester,
    router,
    observers: () => [VisibleAwareObserver()],
    container: MockApp.providerContainer,
  );

  testWidgets('SettingsScreen is accessible', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await pumpRouter(tester);

    router.push(const SettingsScreenRoute());
    await tester.pumpAndSettle();

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(
      tester,
      meetsGuideline(
        CustomMinimumContrastGuideline(
          finder: find.byType(SettingsScreen),
        ),
      ),
    );
    await snap(settings: SnaptestSettings(blockText: false, includeDeviceFrame: true, devices: Devices.android.all));

    expect(find.text('Hello, John Doe'), findsAny);

    handle.dispose();
  });
}

class ObserverRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SettingsScreenRoute.page, initial: true),
  ];
}

class SettingsScreenRoute extends PageRouteInfo<void> {
  const SettingsScreenRoute({List<PageRouteInfo>? children}) : super(SettingsScreenRoute.name, initialChildren: children);

  static const String name = 'SettingsScreenRoute';
  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}
