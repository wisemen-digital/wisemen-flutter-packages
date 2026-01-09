//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/role_assigned_to_user_event_content.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/subject_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_role_assigned_domain_event_log.g.dart';

/// UserRoleAssignedDomainEventLog
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
abstract class UserRoleAssignedDomainEventLog
    implements
        Built<
          UserRoleAssignedDomainEventLog,
          UserRoleAssignedDomainEventLogBuilder
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
  UserRoleAssignedDomainEventLogTypeEnum get type;
  // enum typeEnum {  user.role-assigned,  };

  @BuiltValueField(wireName: r'content')
  RoleAssignedToUserEventContent get content;

  UserRoleAssignedDomainEventLog._();

  factory UserRoleAssignedDomainEventLog([
    void updates(UserRoleAssignedDomainEventLogBuilder b),
  ]) = _$UserRoleAssignedDomainEventLog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserRoleAssignedDomainEventLogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserRoleAssignedDomainEventLog> get serializer =>
      _$UserRoleAssignedDomainEventLogSerializer();
}

class _$UserRoleAssignedDomainEventLogSerializer
    implements PrimitiveSerializer<UserRoleAssignedDomainEventLog> {
  @override
  final Iterable<Type> types = const [
    UserRoleAssignedDomainEventLog,
    _$UserRoleAssignedDomainEventLog,
  ];

  @override
  final String wireName = r'UserRoleAssignedDomainEventLog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserRoleAssignedDomainEventLog object, {
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
      specifiedType: const FullType(UserRoleAssignedDomainEventLogTypeEnum),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(RoleAssignedToUserEventContent),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserRoleAssignedDomainEventLog object, {
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
    required UserRoleAssignedDomainEventLogBuilder result,
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
                      UserRoleAssignedDomainEventLogTypeEnum,
                    ),
                  )
                  as UserRoleAssignedDomainEventLogTypeEnum;
          result.type = valueDes;
          break;
        case r'content':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      RoleAssignedToUserEventContent,
                    ),
                  )
                  as RoleAssignedToUserEventContent;
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
  UserRoleAssignedDomainEventLog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserRoleAssignedDomainEventLogBuilder();
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

class UserRoleAssignedDomainEventLogTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user.role-assigned')
  static const UserRoleAssignedDomainEventLogTypeEnum userPeriodRoleAssigned =
      _$userRoleAssignedDomainEventLogTypeEnum_userPeriodRoleAssigned;

  static Serializer<UserRoleAssignedDomainEventLogTypeEnum> get serializer =>
      _$userRoleAssignedDomainEventLogTypeEnumSerializer;

  const UserRoleAssignedDomainEventLogTypeEnum._(String name) : super(name);

  static BuiltSet<UserRoleAssignedDomainEventLogTypeEnum> get values =>
      _$userRoleAssignedDomainEventLogTypeEnumValues;
  static UserRoleAssignedDomainEventLogTypeEnum valueOf(String name) =>
      _$userRoleAssignedDomainEventLogTypeEnumValueOf(name);
}
