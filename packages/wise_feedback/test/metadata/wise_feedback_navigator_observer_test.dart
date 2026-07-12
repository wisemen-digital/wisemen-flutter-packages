import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

Route<void> _route(String name) => PageRouteBuilder<void>(
      settings: RouteSettings(name: name),
      pageBuilder: (_, __, ___) => const SizedBox(),
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
  });
}
