//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_channel.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_type_channel_config.g.dart';

/// NotificationTypeChannelConfig
///
/// Properties:
/// * [channel]
/// * [defaultValue]
/// * [isSupported]
@BuiltValue()
abstract class NotificationTypeChannelConfig
    implements
        Built<
          NotificationTypeChannelConfig,
          NotificationTypeChannelConfigBuilder
        > {
  @BuiltValueField(wireName: r'channel')
  NotificationChannel get channel;
  // enum channelEnum {  email,  sms,  app,  push,  };

  @BuiltValueField(wireName: r'defaultValue')
  bool get defaultValue;

  @BuiltValueField(wireName: r'isSupported')
  bool get isSupported;

  NotificationTypeChannelConfig._();

  factory NotificationTypeChannelConfig([
    void updates(NotificationTypeChannelConfigBuilder b),
  ]) = _$NotificationTypeChannelConfig;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationTypeChannelConfigBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationTypeChannelConfig> get serializer =>
      _$NotificationTypeChannelConfigSerializer();
}

class _$NotificationTypeChannelConfigSerializer
    implements PrimitiveSerializer<NotificationTypeChannelConfig> {
  @override
  final Iterable<Type> types = const [
    NotificationTypeChannelConfig,
    _$NotificationTypeChannelConfig,
  ];

  @override
  final String wireName = r'NotificationTypeChannelConfig';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationTypeChannelConfig object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'channel';
    yield serializers.serialize(
      object.channel,
      specifiedType: const FullType(NotificationChannel),
    );
    yield r'defaultValue';
    yield serializers.serialize(
      object.defaultValue,
      specifiedType: const FullType(bool),
    );
    yield r'isSupported';
    yield serializers.serialize(
      object.isSupported,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationTypeChannelConfig object, {
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
    required NotificationTypeChannelConfigBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'channel':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(NotificationChannel),
                  )
                  as NotificationChannel;
          result.channel = valueDes;
          break;
        case r'defaultValue':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.defaultValue = valueDes;
          break;
        case r'isSupported':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.isSupported = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationTypeChannelConfig deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationTypeChannelConfigBuilder();
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
