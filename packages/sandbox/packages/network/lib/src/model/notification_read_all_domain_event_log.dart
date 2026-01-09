//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/all_notifications_marked_as_read_event_content.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/subject_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_read_all_domain_event_log.g.dart';

/// NotificationReadAllDomainEventLog
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
abstract class NotificationReadAllDomainEventLog
    implements
        Built<
          NotificationReadAllDomainEventLog,
          NotificationReadAllDomainEventLogBuilder
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
  NotificationReadAllDomainEventLogTypeEnum get type;
  // enum typeEnum {  notification.read.all,  };

  @BuiltValueField(wireName: r'content')
  AllNotificationsMarkedAsReadEventContent get content;

  NotificationReadAllDomainEventLog._();

  factory NotificationReadAllDomainEventLog([
    void updates(NotificationReadAllDomainEventLogBuilder b),
  ]) = _$NotificationReadAllDomainEventLog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationReadAllDomainEventLogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationReadAllDomainEventLog> get serializer =>
      _$NotificationReadAllDomainEventLogSerializer();
}

class _$NotificationReadAllDomainEventLogSerializer
    implements PrimitiveSerializer<NotificationReadAllDomainEventLog> {
  @override
  final Iterable<Type> types = const [
    NotificationReadAllDomainEventLog,
    _$NotificationReadAllDomainEventLog,
  ];

  @override
  final String wireName = r'NotificationReadAllDomainEventLog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationReadAllDomainEventLog object, {
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
      specifiedType: const FullType(NotificationReadAllDomainEventLogTypeEnum),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(AllNotificationsMarkedAsReadEventContent),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationReadAllDomainEventLog object, {
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
    required NotificationReadAllDomainEventLogBuilder result,
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
                      NotificationReadAllDomainEventLogTypeEnum,
                    ),
                  )
                  as NotificationReadAllDomainEventLogTypeEnum;
          result.type = valueDes;
          break;
        case r'content':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      AllNotificationsMarkedAsReadEventContent,
                    ),
                  )
                  as AllNotificationsMarkedAsReadEventContent;
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
  NotificationReadAllDomainEventLog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationReadAllDomainEventLogBuilder();
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

class NotificationReadAllDomainEventLogTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'notification.read.all')
  static const NotificationReadAllDomainEventLogTypeEnum
  notificationPeriodReadPeriodAll =
      _$notificationReadAllDomainEventLogTypeEnum_notificationPeriodReadPeriodAll;

  static Serializer<NotificationReadAllDomainEventLogTypeEnum> get serializer =>
      _$notificationReadAllDomainEventLogTypeEnumSerializer;

  const NotificationReadAllDomainEventLogTypeEnum._(String name) : super(name);

  static BuiltSet<NotificationReadAllDomainEventLogTypeEnum> get values =>
      _$notificationReadAllDomainEventLogTypeEnumValues;
  static NotificationReadAllDomainEventLogTypeEnum valueOf(String name) =>
      _$notificationReadAllDomainEventLogTypeEnumValueOf(name);
}
