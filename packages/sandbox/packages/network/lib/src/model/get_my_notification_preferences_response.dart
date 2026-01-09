//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_preset.dart';
import 'package:openapi/src/model/preference_types.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_my_notification_preferences_response.g.dart';

/// GetMyNotificationPreferencesResponse
///
/// Properties:
/// * [preset]
/// * [emailEnabled]
/// * [smsEnabled]
/// * [appEnabled]
/// * [pushEnabled]
/// * [preferences]
@BuiltValue()
abstract class GetMyNotificationPreferencesResponse
    implements
        Built<
          GetMyNotificationPreferencesResponse,
          GetMyNotificationPreferencesResponseBuilder
        > {
  @BuiltValueField(wireName: r'preset')
  NotificationPreset get preset;
  // enum presetEnum {  all,  default,  custom,  none,  };

  @BuiltValueField(wireName: r'emailEnabled')
  bool get emailEnabled;

  @BuiltValueField(wireName: r'smsEnabled')
  bool get smsEnabled;

  @BuiltValueField(wireName: r'appEnabled')
  bool get appEnabled;

  @BuiltValueField(wireName: r'pushEnabled')
  bool get pushEnabled;

  @BuiltValueField(wireName: r'preferences')
  PreferenceTypes get preferences;

  GetMyNotificationPreferencesResponse._();

  factory GetMyNotificationPreferencesResponse([
    void updates(GetMyNotificationPreferencesResponseBuilder b),
  ]) = _$GetMyNotificationPreferencesResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetMyNotificationPreferencesResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetMyNotificationPreferencesResponse> get serializer =>
      _$GetMyNotificationPreferencesResponseSerializer();
}

class _$GetMyNotificationPreferencesResponseSerializer
    implements PrimitiveSerializer<GetMyNotificationPreferencesResponse> {
  @override
  final Iterable<Type> types = const [
    GetMyNotificationPreferencesResponse,
    _$GetMyNotificationPreferencesResponse,
  ];

  @override
  final String wireName = r'GetMyNotificationPreferencesResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetMyNotificationPreferencesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'preset';
    yield serializers.serialize(
      object.preset,
      specifiedType: const FullType(NotificationPreset),
    );
    yield r'emailEnabled';
    yield serializers.serialize(
      object.emailEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'smsEnabled';
    yield serializers.serialize(
      object.smsEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'appEnabled';
    yield serializers.serialize(
      object.appEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'pushEnabled';
    yield serializers.serialize(
      object.pushEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'preferences';
    yield serializers.serialize(
      object.preferences,
      specifiedType: const FullType(PreferenceTypes),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetMyNotificationPreferencesResponse object, {
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
    required GetMyNotificationPreferencesResponseBuilder result,
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
        case r'emailEnabled':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.emailEnabled = valueDes;
          break;
        case r'smsEnabled':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.smsEnabled = valueDes;
          break;
        case r'appEnabled':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.appEnabled = valueDes;
          break;
        case r'pushEnabled':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.pushEnabled = valueDes;
          break;
        case r'preferences':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(PreferenceTypes),
                  )
                  as PreferenceTypes;
          result.preferences.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetMyNotificationPreferencesResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetMyNotificationPreferencesResponseBuilder();
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
