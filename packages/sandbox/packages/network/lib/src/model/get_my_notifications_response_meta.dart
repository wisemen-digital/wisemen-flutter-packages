//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/get_my_notifications_query_key.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_my_notifications_response_meta.g.dart';

/// GetMyNotificationsResponseMeta
///
/// Properties:
/// * [next]
@BuiltValue()
abstract class GetMyNotificationsResponseMeta
    implements
        Built<
          GetMyNotificationsResponseMeta,
          GetMyNotificationsResponseMetaBuilder
        > {
  @BuiltValueField(wireName: r'next')
  GetMyNotificationsQueryKey? get next;

  GetMyNotificationsResponseMeta._();

  factory GetMyNotificationsResponseMeta([
    void updates(GetMyNotificationsResponseMetaBuilder b),
  ]) = _$GetMyNotificationsResponseMeta;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetMyNotificationsResponseMetaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetMyNotificationsResponseMeta> get serializer =>
      _$GetMyNotificationsResponseMetaSerializer();
}

class _$GetMyNotificationsResponseMetaSerializer
    implements PrimitiveSerializer<GetMyNotificationsResponseMeta> {
  @override
  final Iterable<Type> types = const [
    GetMyNotificationsResponseMeta,
    _$GetMyNotificationsResponseMeta,
  ];

  @override
  final String wireName = r'GetMyNotificationsResponseMeta';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetMyNotificationsResponseMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'next';
    yield object.next == null
        ? null
        : serializers.serialize(
            object.next,
            specifiedType: const FullType.nullable(GetMyNotificationsQueryKey),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetMyNotificationsResponseMeta object, {
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
    required GetMyNotificationsResponseMetaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'next':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(
                      GetMyNotificationsQueryKey,
                    ),
                  )
                  as GetMyNotificationsQueryKey?;
          if (valueDes == null) continue;
          result.next.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetMyNotificationsResponseMeta deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetMyNotificationsResponseMetaBuilder();
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
