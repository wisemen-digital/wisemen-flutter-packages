//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_channel.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_my_channel_notification_preference_command.g.dart';

/// UpdateMyChannelNotificationPreferenceCommand
///
/// Properties:
/// * [channel]
/// * [isEnabled]
@BuiltValue()
abstract class UpdateMyChannelNotificationPreferenceCommand
    implements
        Built<
          UpdateMyChannelNotificationPreferenceCommand,
          UpdateMyChannelNotificationPreferenceCommandBuilder
        > {
  @BuiltValueField(wireName: r'channel')
  NotificationChannel get channel;
  // enum channelEnum {  email,  sms,  app,  push,  };

  @BuiltValueField(wireName: r'isEnabled')
  bool get isEnabled;

  UpdateMyChannelNotificationPreferenceCommand._();

  factory UpdateMyChannelNotificationPreferenceCommand([
    void updates(UpdateMyChannelNotificationPreferenceCommandBuilder b),
  ]) = _$UpdateMyChannelNotificationPreferenceCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(
    UpdateMyChannelNotificationPreferenceCommandBuilder b,
  ) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateMyChannelNotificationPreferenceCommand>
  get serializer => _$UpdateMyChannelNotificationPreferenceCommandSerializer();
}

class _$UpdateMyChannelNotificationPreferenceCommandSerializer
    implements
        PrimitiveSerializer<UpdateMyChannelNotificationPreferenceCommand> {
  @override
  final Iterable<Type> types = const [
    UpdateMyChannelNotificationPreferenceCommand,
    _$UpdateMyChannelNotificationPreferenceCommand,
  ];

  @override
  final String wireName = r'UpdateMyChannelNotificationPreferenceCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateMyChannelNotificationPreferenceCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'channel';
    yield serializers.serialize(
      object.channel,
      specifiedType: const FullType(NotificationChannel),
    );
    yield r'isEnabled';
    yield serializers.serialize(
      object.isEnabled,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateMyChannelNotificationPreferenceCommand object, {
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
    required UpdateMyChannelNotificationPreferenceCommandBuilder result,
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
        case r'isEnabled':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.isEnabled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateMyChannelNotificationPreferenceCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateMyChannelNotificationPreferenceCommandBuilder();
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
