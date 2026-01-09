//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'preference_types.g.dart';

/// PreferenceTypes
///
/// Properties:
/// * [email]
/// * [sms]
/// * [app]
/// * [push]
@BuiltValue()
abstract class PreferenceTypes
    implements Built<PreferenceTypes, PreferenceTypesBuilder> {
  @BuiltValueField(wireName: r'email')
  BuiltList<NotificationType> get email;

  @BuiltValueField(wireName: r'sms')
  BuiltList<NotificationType> get sms;

  @BuiltValueField(wireName: r'app')
  BuiltList<NotificationType> get app;

  @BuiltValueField(wireName: r'push')
  BuiltList<NotificationType> get push;

  PreferenceTypes._();

  factory PreferenceTypes([void updates(PreferenceTypesBuilder b)]) =
      _$PreferenceTypes;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PreferenceTypesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PreferenceTypes> get serializer =>
      _$PreferenceTypesSerializer();
}

class _$PreferenceTypesSerializer
    implements PrimitiveSerializer<PreferenceTypes> {
  @override
  final Iterable<Type> types = const [PreferenceTypes, _$PreferenceTypes];

  @override
  final String wireName = r'PreferenceTypes';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PreferenceTypes object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(BuiltList, [FullType(NotificationType)]),
    );
    yield r'sms';
    yield serializers.serialize(
      object.sms,
      specifiedType: const FullType(BuiltList, [FullType(NotificationType)]),
    );
    yield r'app';
    yield serializers.serialize(
      object.app,
      specifiedType: const FullType(BuiltList, [FullType(NotificationType)]),
    );
    yield r'push';
    yield serializers.serialize(
      object.push,
      specifiedType: const FullType(BuiltList, [FullType(NotificationType)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PreferenceTypes object, {
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
    required PreferenceTypesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(NotificationType),
                    ]),
                  )
                  as BuiltList<NotificationType>;
          result.email.replace(valueDes);
          break;
        case r'sms':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(NotificationType),
                    ]),
                  )
                  as BuiltList<NotificationType>;
          result.sms.replace(valueDes);
          break;
        case r'app':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(NotificationType),
                    ]),
                  )
                  as BuiltList<NotificationType>;
          result.app.replace(valueDes);
          break;
        case r'push':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(NotificationType),
                    ]),
                  )
                  as BuiltList<NotificationType>;
          result.push.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PreferenceTypes deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PreferenceTypesBuilder();
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
