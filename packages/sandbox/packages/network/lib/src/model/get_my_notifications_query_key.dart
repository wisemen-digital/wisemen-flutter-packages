//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_my_notifications_query_key.g.dart';

/// GetMyNotificationsQueryKey
///
/// Properties:
/// * [createdAt]
/// * [notificationUuid]
@BuiltValue()
abstract class GetMyNotificationsQueryKey
    implements
        Built<GetMyNotificationsQueryKey, GetMyNotificationsQueryKeyBuilder> {
  @BuiltValueField(wireName: r'createdAt')
  String get createdAt;

  @BuiltValueField(wireName: r'notificationUuid')
  String get notificationUuid;

  GetMyNotificationsQueryKey._();

  factory GetMyNotificationsQueryKey([
    void updates(GetMyNotificationsQueryKeyBuilder b),
  ]) = _$GetMyNotificationsQueryKey;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetMyNotificationsQueryKeyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetMyNotificationsQueryKey> get serializer =>
      _$GetMyNotificationsQueryKeySerializer();
}

class _$GetMyNotificationsQueryKeySerializer
    implements PrimitiveSerializer<GetMyNotificationsQueryKey> {
  @override
  final Iterable<Type> types = const [
    GetMyNotificationsQueryKey,
    _$GetMyNotificationsQueryKey,
  ];

  @override
  final String wireName = r'GetMyNotificationsQueryKey';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetMyNotificationsQueryKey object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(String),
    );
    yield r'notificationUuid';
    yield serializers.serialize(
      object.notificationUuid,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetMyNotificationsQueryKey object, {
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
    required GetMyNotificationsQueryKeyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'createdAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.createdAt = valueDes;
          break;
        case r'notificationUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.notificationUuid = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetMyNotificationsQueryKey deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetMyNotificationsQueryKeyBuilder();
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
