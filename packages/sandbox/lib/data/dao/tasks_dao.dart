import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sandbox/data/table/tasks_table.dart';
import 'package:sandbox/database/database.dart';

part 'tasks_dao.g.dart';

@DriftAccessor(tables: [TasksTable])
class TasksDao extends DatabaseAccessor<Database> with _$TasksDaoMixin {
  TasksDao(super.attachedDatabase);

  /// Insert or update a single task
  Future<void> insertTask(TasksTableCompanion task) async {
    await into(tasksTable).insertOnConflictUpdate(task);
  }

  /// Insert or update tasks (replaces all existing tasks)
  Future<void> insertTasks(List<TasksTableCompanion> tasks) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(tasksTable, tasks);
    });

    // Remove tasks not in the new set
    final ids = tasks.map((e) => e.id.value).toSet();
    await (delete(tasksTable)..where((t) => t.id.isNotIn(ids))).go();
  }

  /// Delete a task by ID
  Future<void> deleteTask({required String id}) async {
    await (delete(tasksTable)..where((t) => t.id.equals(id))).go();
  }

  /// Watch all tasks ordered by creation date
  Stream<List<TaskObject>> watchAll() {
    return (select(tasksTable)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).watch();
  }

  /// Watch a single task by ID
  Stream<TaskObject?> watchById({required String id}) {
    return (select(tasksTable)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }
}

@riverpod
TasksDao tasksDao(Ref ref) {
  return TasksDao(ref.read(databaseServiceProvider));
}
