//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/role_permissions_cache_cleared_event_content.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/subject_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_permissions_cache_cleared_domain_event_log.g.dart';

/// RolePermissionsCacheClearedDomainEventLog
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
/// * [type]
/// * [content]
@BuiltValue()
abstract class RolePermissionsCacheClearedDomainEventLog
    implements
        Built<
          RolePermissionsCacheClearedDomainEventLog,
          RolePermissionsCacheClearedDomainEventLogBuilder
        > {
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

  @BuiltValueField(wireName: r'type')
  RolePermissionsCacheClearedDomainEventLogTypeEnum get type;
  // enum typeEnum {  role.permissions.cache.cleared,  };

  @BuiltValueField(wireName: r'content')
  RolePermissionsCacheClearedEventContent get content;

  RolePermissionsCacheClearedDomainEventLog._();

  factory RolePermissionsCacheClearedDomainEventLog([
    void updates(RolePermissionsCacheClearedDomainEventLogBuilder b),
  ]) = _$RolePermissionsCacheClearedDomainEventLog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RolePermissionsCacheClearedDomainEventLogBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RolePermissionsCacheClearedDomainEventLog> get serializer =>
      _$RolePermissionsCacheClearedDomainEventLogSerializer();
}

class _$RolePermissionsCacheClearedDomainEventLogSerializer
    implements PrimitiveSerializer<RolePermissionsCacheClearedDomainEventLog> {
  @override
  final Iterable<Type> types = const [
    RolePermissionsCacheClearedDomainEventLog,
    _$RolePermissionsCacheClearedDomainEventLog,
  ];

  @override
  final String wireName = r'RolePermissionsCacheClearedDomainEventLog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RolePermissionsCacheClearedDomainEventLog object, {
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
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(
        RolePermissionsCacheClearedDomainEventLogTypeEnum,
      ),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(RolePermissionsCacheClearedEventContent),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RolePermissionsCacheClearedDomainEventLog object, {
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
    required RolePermissionsCacheClearedDomainEventLogBuilder result,
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
        case r'type':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      RolePermissionsCacheClearedDomainEventLogTypeEnum,
                    ),
                  )
                  as RolePermissionsCacheClearedDomainEventLogTypeEnum;
          result.type = valueDes;
          break;
        case r'content':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      RolePermissionsCacheClearedEventContent,
                    ),
                  )
                  as RolePermissionsCacheClearedEventContent;
          result.content.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RolePermissionsCacheClearedDomainEventLog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RolePermissionsCacheClearedDomainEventLogBuilder();
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

class RolePermissionsCacheClearedDomainEventLogTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'role.permissions.cache.cleared')
  static const RolePermissionsCacheClearedDomainEventLogTypeEnum
  rolePeriodPermissionsPeriodCachePeriodCleared =
      _$rolePermissionsCacheClearedDomainEventLogTypeEnum_rolePeriodPermissionsPeriodCachePeriodCleared;

  static Serializer<RolePermissionsCacheClearedDomainEventLogTypeEnum>
  get serializer =>
      _$rolePermissionsCacheClearedDomainEventLogTypeEnumSerializer;

  const RolePermissionsCacheClearedDomainEventLogTypeEnum._(String name)
    : super(name);

  static BuiltSet<RolePermissionsCacheClearedDomainEventLogTypeEnum>
  get values => _$rolePermissionsCacheClearedDomainEventLogTypeEnumValues;
  static RolePermissionsCacheClearedDomainEventLogTypeEnum valueOf(
    String name,
  ) => _$rolePermissionsCacheClearedDomainEventLogTypeEnumValueOf(name);
}
