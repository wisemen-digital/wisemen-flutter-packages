//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/subject_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'domain_event_log_response.g.dart';

/// DomainEventLogResponse
///
/// Properties:
/// * [uuid]
/// * [createdAt]
/// * [version]
/// * [source_]
/// * [userUuid]
/// * [message]
/// * [subjectType]
/// * [subjectId]
@BuiltValue()
abstract class DomainEventLogResponse
    implements Built<DomainEventLogResponse, DomainEventLogResponseBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'source')
  String get source_;

  @BuiltValueField(wireName: r'userUuid')
  String? get userUuid;

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'subjectType')
  SubjectType? get subjectType;
  // enum subjectTypeEnum {  contact,  file,  role,  user,  };

  @BuiltValueField(wireName: r'subjectId')
  String? get subjectId;

  DomainEventLogResponse._();

  factory DomainEventLogResponse([
    void updates(DomainEventLogResponseBuilder b),
  ]) = _$DomainEventLogResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DomainEventLogResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DomainEventLogResponse> get serializer =>
      _$DomainEventLogResponseSerializer();
}

class _$DomainEventLogResponseSerializer
    implements PrimitiveSerializer<DomainEventLogResponse> {
  @override
  final Iterable<Type> types = const [
    DomainEventLogResponse,
    _$DomainEventLogResponse,
  ];

  @override
  final String wireName = r'DomainEventLogResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DomainEventLogResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(String),
    );
    yield r'userUuid';
    yield object.userUuid == null
        ? null
        : serializers.serialize(
            object.userUuid,
            specifiedType: const FullType.nullable(String),
          );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'subjectType';
    yield object.subjectType == null
        ? null
        : serializers.serialize(
            object.subjectType,
            specifiedType: const FullType.nullable(SubjectType),
          );
    yield r'subjectId';
    yield object.subjectId == null
        ? null
        : serializers.serialize(
            object.subjectId,
            specifiedType: const FullType.nullable(String),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    DomainEventLogResponse object, {
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
    required DomainEventLogResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'uuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.uuid = valueDes;
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
        case r'version':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int;
          result.version = valueDes;
          break;
        case r'source':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.source_ = valueDes;
          break;
        case r'userUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.userUuid = valueDes;
          break;
        case r'message':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.message = valueDes;
          break;
        case r'subjectType':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(SubjectType),
                  )
                  as SubjectType?;
          if (valueDes == null) continue;
          result.subjectType = valueDes;
          break;
        case r'subjectId':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.subjectId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DomainEventLogResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DomainEventLogResponseBuilder();
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
