//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_created_event_content.g.dart';

/// NotificationCreatedEventContent
///
/// Properties:
/// * [uuid]
/// * [type]
@BuiltValue()
abstract class NotificationCreatedEventContent
    implements
        Built<
          NotificationCreatedEventContent,
          NotificationCreatedEventContentBuilder
        > {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'type')
  NotificationType get type;
  // enum typeEnum {  user.created,  system.test-notification,  };

  NotificationCreatedEventContent._();

  factory NotificationCreatedEventContent([
    void updates(NotificationCreatedEventContentBuilder b),
  ]) = _$NotificationCreatedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationCreatedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationCreatedEventContent> get serializer =>
      _$NotificationCreatedEventContentSerializer();
}

class _$NotificationCreatedEventContentSerializer
    implements PrimitiveSerializer<NotificationCreatedEventContent> {
  @override
  final Iterable<Type> types = const [
    NotificationCreatedEventContent,
    _$NotificationCreatedEventContent,
  ];

  @override
  final String wireName = r'NotificationCreatedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationCreatedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(NotificationType),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationCreatedEventContent object, {
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
    required NotificationCreatedEventContentBuilder result,
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
        case r'type':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(NotificationType),
                  )
                  as NotificationType;
          result.type = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationCreatedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationCreatedEventContentBuilder();
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
