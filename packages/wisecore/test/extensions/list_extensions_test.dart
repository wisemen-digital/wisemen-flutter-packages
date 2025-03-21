import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/list_extension.dart';

void main() {
  group('CustomListExtensions', () {
    test('addOrUpdateItem should add item if it does not exist', () {
      final list = [1, 2, 3];
      final updatedList = list.addOrUpdateItem(
        item: 4,
        predicate: (element) => element == 4,
      );
      expect(updatedList, [1, 2, 3, 4]);
    });

    test('addOrUpdateItem should update item if it exists', () {
      final list = [1, 2, 3];
      final updatedList = list.addOrUpdateItem(
        item: 2,
        predicate: (element) => element == 2,
      );
      expect(updatedList, [1, 2, 3]);
    });

    test('addOrUpdateItem should handle null list', () {
      List<int>? list;
      final updatedList = list.addOrUpdateItem(
        item: 1,
        predicate: (element) => element == 1,
      );
      expect(updatedList, [1]);
    });

    test('updateItem should update item at given index', () {
      final list = [1, 2, 3];
      final updatedList = list.updateItem(
        item: 4,
        index: 1,
      );
      expect(updatedList, [1, 4, 3]);
    });

    test('updateItem should handle null list', () {
      List<int>? list;
      final updatedList = list.updateItem(
        item: 1,
        index: 0,
      );
      expect(updatedList, [1]);
    });
  });
}
