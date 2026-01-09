//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_channel.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_notification_created_event_content.g.dart';

/// UserNotificationCreatedEventContent
///
/// Properties:
/// * [notificationUuid]
/// * [channel]
/// * [userUuid]
@BuiltValue()
abstract class UserNotificationCreatedEventContent
    implements
        Built<
          UserNotificationCreatedEventContent,
          UserNotificationCreatedEventContentBuilder
        > {
  @BuiltValueField(wireName: r'notificationUuid')
  String get notificationUuid;

  @BuiltValueField(wireName: r'channel')
  NotificationChannel get channel;
  // enum channelEnum {  email,  sms,  app,  push,  };

  @BuiltValueField(wireName: r'userUuid')
  String get userUuid;

  UserNotificationCreatedEventContent._();

  factory UserNotificationCreatedEventContent([
    void updates(UserNotificationCreatedEventContentBuilder b),
  ]) = _$UserNotificationCreatedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserNotificationCreatedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserNotificationCreatedEventContent> get serializer =>
      _$UserNotificationCreatedEventContentSerializer();
}

class _$UserNotificationCreatedEventContentSerializer
    implements PrimitiveSerializer<UserNotificationCreatedEventContent> {
  @override
  final Iterable<Type> types = const [
    UserNotificationCreatedEventContent,
    _$UserNotificationCreatedEventContent,
  ];

  @override
  final String wireName = r'UserNotificationCreatedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserNotificationCreatedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'notificationUuid';
    yield serializers.serialize(
      object.notificationUuid,
      specifiedType: const FullType(String),
    );
    yield r'channel';
    yield serializers.serialize(
      object.channel,
      specifiedType: const FullType(NotificationChannel),
    );
    yield r'userUuid';
    yield serializers.serialize(
      object.userUuid,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserNotificationCreatedEventContent object, {
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
    required UserNotificationCreatedEventContentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'notificationUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.notificationUuid = valueDes;
          break;
        case r'channel':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(NotificationChannel),
                  )
                  as NotificationChannel;
          result.channel = valueDes;
          break;
        case r'userUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.userUuid = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserNotificationCreatedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserNotificationCreatedEventContentBuilder();
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
