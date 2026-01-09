//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/subject_type.dart';
import 'package:openapi/src/model/role_renamed_event_content.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_renamed_domain_event_log.g.dart';

/// RoleRenamedDomainEventLog
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
abstract class RoleRenamedDomainEventLog
    implements
        Built<RoleRenamedDomainEventLog, RoleRenamedDomainEventLogBuilder> {
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
  RoleRenamedDomainEventLogTypeEnum get type;
  // enum typeEnum {  role.renamed,  };

  @BuiltValueField(wireName: r'content')
  RoleRenamedEventContent get content;

  RoleRenamedDomainEventLog._();

  factory RoleRenamedDomainEventLog([
    void updates(RoleRenamedDomainEventLogBuilder b),
  ]) = _$RoleRenamedDomainEventLog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleRenamedDomainEventLogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleRenamedDomainEventLog> get serializer =>
      _$RoleRenamedDomainEventLogSerializer();
}

class _$RoleRenamedDomainEventLogSerializer
    implements PrimitiveSerializer<RoleRenamedDomainEventLog> {
  @override
  final Iterable<Type> types = const [
    RoleRenamedDomainEventLog,
    _$RoleRenamedDomainEventLog,
  ];

  @override
  final String wireName = r'RoleRenamedDomainEventLog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleRenamedDomainEventLog object, {
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
      specifiedType: const FullType(RoleRenamedDomainEventLogTypeEnum),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(RoleRenamedEventContent),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleRenamedDomainEventLog object, {
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
    required RoleRenamedDomainEventLogBuilder result,
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
                      RoleRenamedDomainEventLogTypeEnum,
                    ),
                  )
                  as RoleRenamedDomainEventLogTypeEnum;
          result.type = valueDes;
          break;
        case r'content':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(RoleRenamedEventContent),
                  )
                  as RoleRenamedEventContent;
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
  RoleRenamedDomainEventLog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleRenamedDomainEventLogBuilder();
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

class RoleRenamedDomainEventLogTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'role.renamed')
  static const RoleRenamedDomainEventLogTypeEnum rolePeriodRenamed =
      _$roleRenamedDomainEventLogTypeEnum_rolePeriodRenamed;

  static Serializer<RoleRenamedDomainEventLogTypeEnum> get serializer =>
      _$roleRenamedDomainEventLogTypeEnumSerializer;

  const RoleRenamedDomainEventLogTypeEnum._(String name) : super(name);

  static BuiltSet<RoleRenamedDomainEventLogTypeEnum> get values =>
      _$roleRenamedDomainEventLogTypeEnumValues;
  static RoleRenamedDomainEventLogTypeEnum valueOf(String name) =>
      _$roleRenamedDomainEventLogTypeEnumValueOf(name);
}
