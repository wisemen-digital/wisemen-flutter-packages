//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/job_status.dart';
import 'package:openapi/src/model/queue_name.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_jobs_index_item_response.g.dart';

/// ViewJobsIndexItemResponse
///
/// Properties:
/// * [queueName]
/// * [id]
/// * [name]
/// * [status]
/// * [createdAt]
/// * [completedAt]
@BuiltValue()
abstract class ViewJobsIndexItemResponse
    implements
        Built<ViewJobsIndexItemResponse, ViewJobsIndexItemResponseBuilder> {
  @BuiltValueField(wireName: r'queueName')
  QueueName get queueName;
  // enum queueNameEnum {  system,  };

  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'status')
  JobStatus get status;
  // enum statusEnum {  created,  active,  completed,  retry,  failed,  cancelled,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'completedAt')
  DateTime? get completedAt;

  ViewJobsIndexItemResponse._();

  factory ViewJobsIndexItemResponse([
    void updates(ViewJobsIndexItemResponseBuilder b),
  ]) = _$ViewJobsIndexItemResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobsIndexItemResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobsIndexItemResponse> get serializer =>
      _$ViewJobsIndexItemResponseSerializer();
}

class _$ViewJobsIndexItemResponseSerializer
    implements PrimitiveSerializer<ViewJobsIndexItemResponse> {
  @override
  final Iterable<Type> types = const [
    ViewJobsIndexItemResponse,
    _$ViewJobsIndexItemResponse,
  ];

  @override
  final String wireName = r'ViewJobsIndexItemResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobsIndexItemResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'queueName';
    yield serializers.serialize(
      object.queueName,
      specifiedType: const FullType(QueueName),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(JobStatus),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'completedAt';
    yield object.completedAt == null
        ? null
        : serializers.serialize(
            object.completedAt,
            specifiedType: const FullType.nullable(DateTime),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewJobsIndexItemResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(
      serializers,
      object,
      specifiedType: specifiedType,
    ).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ViewJobsIndexItemResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'queueName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(QueueName),
                  )
                  as QueueName;
          result.queueName = valueDes;
          break;
        case r'id':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.name = valueDes;
          break;
        case r'status':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(JobStatus),
                  )
                  as JobStatus;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.createdAt = valueDes;
          break;
        case r'completedAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(DateTime),
                  )
                  as DateTime?;
          if (valueDes == null) continue;
          result.completedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewJobsIndexItemResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobsIndexItemResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
