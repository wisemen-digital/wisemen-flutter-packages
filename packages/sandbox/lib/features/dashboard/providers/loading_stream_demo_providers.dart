import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisecore/wisecore.dart';

part 'loading_stream_demo_providers.g.dart';

/// Stands in for a local database like Drift: a watch emits the current items
/// right away (an empty list on a fresh install), and again after every write.
class DemoItemsDatabase {
  List<String> _items = [];
  final _changes = StreamController<List<String>>.broadcast();

  Stream<List<String>> watch() => Stream.multi((listener) {
    listener.add(_items);
    final subscription = _changes.stream.listen(listener.add, onDone: listener.close);
    listener.onCancel = subscription.cancel;
  });

  void write(List<String> items) {
    _items = items;
    _changes.add(items);
  }

  Future<void> close() => _changes.close();
}

@Riverpod(keepAlive: true)
DemoItemsDatabase demoItemsDatabase(Ref ref) {
  final database = DemoItemsDatabase();
  ref.onDispose(database.close);
  return database;
}

/// Watches the database and fetches the items, the way the providers in the
/// apps use [LoadingStreamProvider].
@riverpod
class DemoItems extends _$DemoItems with LoadingStreamProvider<List<String>> {
  static const fetchDuration = Duration(seconds: 3);

  @override
  Stream<List<String>> build() {
    refresh();
    return ref.watch(demoItemsDatabaseProvider).watch();
  }

  @override
  Future<void> refreshFunction() async {
    final fetchRef = ref;
    await Future<void>.delayed(fetchDuration);
    if (fetchRef.mounted) {
      fetchRef.read(demoItemsDatabaseProvider).write(['Item 1', 'Item 2', 'Item 3']);
    }
  }

  @override
  Future<void> onError(Object error, StackTrace stackTrace) async {}
}
