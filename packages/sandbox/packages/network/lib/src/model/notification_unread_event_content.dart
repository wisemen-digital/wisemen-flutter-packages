//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_unread_event_content.g.dart';

/// NotificationUnreadEventContent
///
/// Properties:
/// * [notificationUuid]
/// * [userUuid]
@BuiltValue()
abstract class NotificationUnreadEventContent
    implements
        Built<
          NotificationUnreadEventContent,
          NotificationUnreadEventContentBuilder
        > {
  @BuiltValueField(wireName: r'notificationUuid')
  String get notificationUuid;

  @BuiltValueField(wireName: r'userUuid')
  String get userUuid;

  NotificationUnreadEventContent._();

  factory NotificationUnreadEventContent([
    void updates(NotificationUnreadEventContentBuilder b),
  ]) = _$NotificationUnreadEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationUnreadEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationUnreadEventContent> get serializer =>
      _$NotificationUnreadEventContentSerializer();
}

class _$NotificationUnreadEventContentSerializer
    implements PrimitiveSerializer<NotificationUnreadEventContent> {
  @override
  final Iterable<Type> types = const [
    NotificationUnreadEventContent,
    _$NotificationUnreadEventContent,
  ];

  @override
  final String wireName = r'NotificationUnreadEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationUnreadEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'notificationUuid';
    yield serializers.serialize(
      object.notificationUuid,
      specifiedType: const FullType(String),
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
    NotificationUnreadEventContent object, {
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
    required NotificationUnreadEventContentBuilder result,
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
  NotificationUnreadEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationUnreadEventContentBuilder();
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
