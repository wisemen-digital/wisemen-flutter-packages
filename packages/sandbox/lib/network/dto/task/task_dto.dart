import 'package:json_annotation/json_annotation.dart';

import '../../utils/base_dto.dart';

part 'task_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TaskDTO implements BaseDTO {
  const TaskDTO({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    this.createdAt,
  });

  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final String? createdAt;

  factory TaskDTO.fromJson(Json json) => _$TaskDTOFromJson(json);

  @override
  Json toJson() => _$TaskDTOToJson(this);
}
