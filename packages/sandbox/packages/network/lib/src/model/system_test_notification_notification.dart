//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/test_notification_content.dart';
import 'package:openapi/src/model/created_by_user_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_test_notification_notification.g.dart';

/// SystemTestNotificationNotification
///
/// Properties:
/// * [createdAt]
/// * [readAt]
/// * [notificationUuid]
/// * [createdByUser]
/// * [message]
/// * [type]
/// * [meta]
@BuiltValue()
abstract class SystemTestNotificationNotification
    implements
        Built<
          SystemTestNotificationNotification,
          SystemTestNotificationNotificationBuilder
        > {
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'readAt')
  DateTime? get readAt;

  @BuiltValueField(wireName: r'notificationUuid')
  String get notificationUuid;

  @BuiltValueField(wireName: r'createdByUser')
  CreatedByUserResponse? get createdByUser;

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'type')
  SystemTestNotificationNotificationTypeEnum get type;
  // enum typeEnum {  system.test-notification,  };

  @BuiltValueField(wireName: r'meta')
  TestNotificationContent get meta;

  SystemTestNotificationNotification._();

  factory SystemTestNotificationNotification([
    void updates(SystemTestNotificationNotificationBuilder b),
  ]) = _$SystemTestNotificationNotification;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SystemTestNotificationNotificationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SystemTestNotificationNotification> get serializer =>
      _$SystemTestNotificationNotificationSerializer();
}

class _$SystemTestNotificationNotificationSerializer
    implements PrimitiveSerializer<SystemTestNotificationNotification> {
  @override
  final Iterable<Type> types = const [
    SystemTestNotificationNotification,
    _$SystemTestNotificationNotification,
  ];

  @override
  final String wireName = r'SystemTestNotificationNotification';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SystemTestNotificationNotification object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'readAt';
    yield object.readAt == null
        ? null
        : serializers.serialize(
            object.readAt,
            specifiedType: const FullType.nullable(DateTime),
          );
    yield r'notificationUuid';
    yield serializers.serialize(
      object.notificationUuid,
      specifiedType: const FullType(String),
    );
    yield r'createdByUser';
    yield object.createdByUser == null
        ? null
        : serializers.serialize(
            object.createdByUser,
            specifiedType: const FullType.nullable(CreatedByUserResponse),
          );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(SystemTestNotificationNotificationTypeEnum),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(TestNotificationContent),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SystemTestNotificationNotification object, {
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
    required SystemTestNotificationNotificationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'createdAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.createdAt = valueDes;
          break;
        case r'readAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(DateTime),
                  )
                  as DateTime?;
          if (valueDes == null) continue;
          result.readAt = valueDes;
          break;
        case r'notificationUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.notificationUuid = valueDes;
          break;
        case r'createdByUser':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(
                      CreatedByUserResponse,
                    ),
                  )
                  as CreatedByUserResponse?;
          if (valueDes == null) continue;
          result.createdByUser.replace(valueDes);
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
        case r'type':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      SystemTestNotificationNotificationTypeEnum,
                    ),
                  )
                  as SystemTestNotificationNotificationTypeEnum;
          result.type = valueDes;
          break;
        case r'meta':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(TestNotificationContent),
                  )
                  as TestNotificationContent;
          result.meta.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SystemTestNotificationNotification deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SystemTestNotificationNotificationBuilder();
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

class SystemTestNotificationNotificationTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'system.test-notification')
  static const SystemTestNotificationNotificationTypeEnum
  systemPeriodTestNotification =
      _$systemTestNotificationNotificationTypeEnum_systemPeriodTestNotification;

  static Serializer<SystemTestNotificationNotificationTypeEnum>
  get serializer => _$systemTestNotificationNotificationTypeEnumSerializer;

  const SystemTestNotificationNotificationTypeEnum._(String name) : super(name);

  static BuiltSet<SystemTestNotificationNotificationTypeEnum> get values =>
      _$systemTestNotificationNotificationTypeEnumValues;
  static SystemTestNotificationNotificationTypeEnum valueOf(String name) =>
      _$systemTestNotificationNotificationTypeEnumValueOf(name);
}
