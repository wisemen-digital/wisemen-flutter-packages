import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/wisecore.dart';

const _pushButtonKey = Key('push-button');
const _popButtonKey = Key('pop-button');

class _FirstRoute extends PageRouteInfo<void> {
  const _FirstRoute() : super(name);

  static const String name = 'FirstRoute';
  static final PageInfo page = PageInfo(
    name,
    builder: (data) => const _VisibleAwarePage(),
  );
}

class _SecondRoute extends PageRouteInfo<void> {
  const _SecondRoute() : super(name);

  static const String name = 'SecondRoute';
  static final PageInfo page = PageInfo(
    name,
    builder: (data) => const _SecondPage(),
  );
}

class _TestRouter extends RootStackRouter {
  _TestRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: _FirstRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: _SecondRoute.page,
          path: '/second',
        ),
      ];
}

void main() {
  group('VisibleAwareStateMixin', () {
    late _TestRouter router;
    late VisibleAwareObserver observer;

    setUp(() {
      _VisibleAwarePage.events.clear();
      router = _TestRouter();
      observer = VisibleAwareObserver();
    });

    Future<void> pumpRouter(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router.config(
            navigatorObservers: () => [observer],
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('calls push on subscribe and pop on route pop', (tester) async {
      await pumpRouter(tester);

      expect(_VisibleAwarePage.events, [AppearanceType.push]);

      await tester.tap(find.byKey(_pushButtonKey));
      await tester.pumpAndSettle();

      expect(_VisibleAwarePage.events, [AppearanceType.push]);

      await tester.tap(find.byKey(_popButtonKey));
      await tester.pumpAndSettle();

      expect(
        _VisibleAwarePage.events,
        [AppearanceType.push, AppearanceType.pop],
      );
    });

    testWidgets('calls backgroundResume only when the route is top',
        (tester) async {
      await pumpRouter(tester);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();

      expect(
        _VisibleAwarePage.events,
        [AppearanceType.push, AppearanceType.backgroundResume],
      );

      await tester.tap(find.byKey(_pushButtonKey));
      await tester.pumpAndSettle();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();

      expect(
        _VisibleAwarePage.events,
        [AppearanceType.push, AppearanceType.backgroundResume],
      );
    });
  });
}

class _VisibleAwarePage extends StatefulWidget {
  const _VisibleAwarePage();

  static final List<AppearanceType> events = <AppearanceType>[];

  @override
  State<_VisibleAwarePage> createState() => _VisibleAwarePageState();
}

class _VisibleAwarePageState extends State<_VisibleAwarePage>
    with VisibleAwareStateMixin<_VisibleAwarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          key: _pushButtonKey,
          onPressed: () => context.pushRoute(const _SecondRoute()),
          child: const Text('Push'),
        ),
      ),
    );
  }

  @override
  void onViewDidAppear(AppearanceType type) {
    _VisibleAwarePage.events.add(type);
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          key: _popButtonKey,
          onPressed: () => context.router.pop(),
          child: const Text('Pop'),
        ),
      ),
    );
  }
}
