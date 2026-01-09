//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/notification_channel.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_my_notification_type_preference_command.g.dart';

/// UpdateMyNotificationTypePreferenceCommand
///
/// Properties:
/// * [channel]
/// * [isEnabled]
/// * [types]
@BuiltValue()
abstract class UpdateMyNotificationTypePreferenceCommand
    implements
        Built<
          UpdateMyNotificationTypePreferenceCommand,
          UpdateMyNotificationTypePreferenceCommandBuilder
        > {
  @BuiltValueField(wireName: r'channel')
  NotificationChannel get channel;
  // enum channelEnum {  email,  sms,  app,  push,  };

  @BuiltValueField(wireName: r'isEnabled')
  bool get isEnabled;

  @BuiltValueField(wireName: r'types')
  BuiltList<NotificationType> get types;

  UpdateMyNotificationTypePreferenceCommand._();

  factory UpdateMyNotificationTypePreferenceCommand([
    void updates(UpdateMyNotificationTypePreferenceCommandBuilder b),
  ]) = _$UpdateMyNotificationTypePreferenceCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateMyNotificationTypePreferenceCommandBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateMyNotificationTypePreferenceCommand> get serializer =>
      _$UpdateMyNotificationTypePreferenceCommandSerializer();
}

class _$UpdateMyNotificationTypePreferenceCommandSerializer
    implements PrimitiveSerializer<UpdateMyNotificationTypePreferenceCommand> {
  @override
  final Iterable<Type> types = const [
    UpdateMyNotificationTypePreferenceCommand,
    _$UpdateMyNotificationTypePreferenceCommand,
  ];

  @override
  final String wireName = r'UpdateMyNotificationTypePreferenceCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateMyNotificationTypePreferenceCommand object, {
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
    yield r'types';
    yield serializers.serialize(
      object.types,
      specifiedType: const FullType(BuiltList, [FullType(NotificationType)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateMyNotificationTypePreferenceCommand object, {
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
    required UpdateMyNotificationTypePreferenceCommandBuilder result,
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
        case r'types':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(NotificationType),
                    ]),
                  )
                  as BuiltList<NotificationType>;
          result.types.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateMyNotificationTypePreferenceCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateMyNotificationTypePreferenceCommandBuilder();
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
