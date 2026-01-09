//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_preset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_my_notification_preference_preset_command.g.dart';

/// UpdateMyNotificationPreferencePresetCommand
///
/// Properties:
/// * [preset]
@BuiltValue()
abstract class UpdateMyNotificationPreferencePresetCommand
    implements
        Built<
          UpdateMyNotificationPreferencePresetCommand,
          UpdateMyNotificationPreferencePresetCommandBuilder
        > {
  @BuiltValueField(wireName: r'preset')
  NotificationPreset get preset;
  // enum presetEnum {  all,  default,  custom,  none,  };

  UpdateMyNotificationPreferencePresetCommand._();

  factory UpdateMyNotificationPreferencePresetCommand([
    void updates(UpdateMyNotificationPreferencePresetCommandBuilder b),
  ]) = _$UpdateMyNotificationPreferencePresetCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateMyNotificationPreferencePresetCommandBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateMyNotificationPreferencePresetCommand>
  get serializer => _$UpdateMyNotificationPreferencePresetCommandSerializer();
}

class _$UpdateMyNotificationPreferencePresetCommandSerializer
    implements
        PrimitiveSerializer<UpdateMyNotificationPreferencePresetCommand> {
  @override
  final Iterable<Type> types = const [
    UpdateMyNotificationPreferencePresetCommand,
    _$UpdateMyNotificationPreferencePresetCommand,
  ];

  @override
  final String wireName = r'UpdateMyNotificationPreferencePresetCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateMyNotificationPreferencePresetCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'preset';
    yield serializers.serialize(
      object.preset,
      specifiedType: const FullType(NotificationPreset),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateMyNotificationPreferencePresetCommand object, {
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
    required UpdateMyNotificationPreferencePresetCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'preset':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(NotificationPreset),
                  )
                  as NotificationPreset;
          result.preset = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateMyNotificationPreferencePresetCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateMyNotificationPreferencePresetCommandBuilder();
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
