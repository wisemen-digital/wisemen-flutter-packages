import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

Route<void> _route(String name) => PageRouteBuilder<void>(
  settings: RouteSettings(name: name),
  pageBuilder: (_, __, ___) => const SizedBox(),
);

TabPageRoute _tab(String name, int index) => TabPageRoute(
  routeInfo: RouteMatch(
    config: AutoRoute(page: PageInfo.emptyShell(name), path: name),
    segments: <String>[name],
    stringMatch: name,
    key: ValueKey<String>(name),
  ),
  index: index,
);

void main() {
  group('WiseFeedbackNavigatorObserver', () {
    test('records pushed route names in order', () {
      final observer = WiseFeedbackNavigatorObserver()
        ..didPush(_route('a'), null)
        ..didPush(_route('b'), null)
        ..didPush(_route('c'), null);
      expect(observer.breadcrumbs, ['a', 'b', 'c']);
    });

    test('drops the oldest entry beyond maxEntries', () {
      final observer = WiseFeedbackNavigatorObserver(maxEntries: 2)
        ..didPush(_route('a'), null)
        ..didPush(_route('b'), null)
        ..didPush(_route('c'), null);
      expect(observer.breadcrumbs, ['b', 'c']);
    });

    test('ignores routes without a name', () {
      final observer = WiseFeedbackNavigatorObserver()
        ..didPush(_route(''), null);
      expect(observer.breadcrumbs, isEmpty);
    });

    test('records tab switches alongside pushes', () {
      final observer = WiseFeedbackNavigatorObserver()
        ..didPush(_route('home'), null)
        ..didChangeTabRoute(_tab('SettingsRoute', 1), _tab('HomeRoute', 0));
      expect(observer.breadcrumbs, ['home', 'SettingsRoute']);
    });

    test('records a tab activated for the first time', () {
      final observer = WiseFeedbackNavigatorObserver()
        ..didInitTabRoute(
          _tab('SettingsRoute', 1),
          _tab('HomeRoute', 0),
        );
      expect(observer.breadcrumbs, ['SettingsRoute']);
    });

    test('ignores tabs built without the user moving to them', () {
      final observer = WiseFeedbackNavigatorObserver()
        ..didInitTabRoute(_tab('HomeRoute', 0), null)
        ..didInitTabRoute(_tab('SettingsRoute', 1), null);
      expect(observer.breadcrumbs, isEmpty);
    });
  });
}
