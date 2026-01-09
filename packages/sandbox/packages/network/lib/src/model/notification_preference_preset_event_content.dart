//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_preset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_preference_preset_event_content.g.dart';

/// NotificationPreferencePresetEventContent
///
/// Properties:
/// * [userUuid]
/// * [preset]
@BuiltValue()
abstract class NotificationPreferencePresetEventContent
    implements
        Built<
          NotificationPreferencePresetEventContent,
          NotificationPreferencePresetEventContentBuilder
        > {
  @BuiltValueField(wireName: r'userUuid')
  String get userUuid;

  @BuiltValueField(wireName: r'preset')
  NotificationPreset get preset;
  // enum presetEnum {  all,  default,  custom,  none,  };

  NotificationPreferencePresetEventContent._();

  factory NotificationPreferencePresetEventContent([
    void updates(NotificationPreferencePresetEventContentBuilder b),
  ]) = _$NotificationPreferencePresetEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationPreferencePresetEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationPreferencePresetEventContent> get serializer =>
      _$NotificationPreferencePresetEventContentSerializer();
}

class _$NotificationPreferencePresetEventContentSerializer
    implements PrimitiveSerializer<NotificationPreferencePresetEventContent> {
  @override
  final Iterable<Type> types = const [
    NotificationPreferencePresetEventContent,
    _$NotificationPreferencePresetEventContent,
  ];

  @override
  final String wireName = r'NotificationPreferencePresetEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationPreferencePresetEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userUuid';
    yield serializers.serialize(
      object.userUuid,
      specifiedType: const FullType(String),
    );
    yield r'preset';
    yield serializers.serialize(
      object.preset,
      specifiedType: const FullType(NotificationPreset),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationPreferencePresetEventContent object, {
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
    required NotificationPreferencePresetEventContentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.userUuid = valueDes;
          break;
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
  NotificationPreferencePresetEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationPreferencePresetEventContentBuilder();
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
