typedef Json = Map<String, dynamic>;

abstract class BaseDTO {
  factory BaseDTO.fromJson(Json json) {
    throw UnimplementedError('fromJson must be implemented');
  }

  Json toJson();
}
