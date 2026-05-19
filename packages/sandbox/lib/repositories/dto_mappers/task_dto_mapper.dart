import 'package:drift/drift.dart';
import 'package:sandbox/database/database.dart';

import '../../network/network.dart';

extension TaskDtoMapper on TaskDTO {
  /// Maps DTO to database table companion for insertion
  TasksTableCompanion toTableCompanion() {
    return TasksTableCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt != null ? DateTime.parse(createdAt!) : null),
    );
  }
}
