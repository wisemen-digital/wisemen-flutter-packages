//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/get_my_notifications_response_items_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/get_my_notifications_response_meta.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_my_notifications_response.g.dart';

/// GetMyNotificationsResponse
///
/// Properties:
/// * [items]
/// * [meta]
@BuiltValue()
abstract class GetMyNotificationsResponse
    implements
        Built<GetMyNotificationsResponse, GetMyNotificationsResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<GetMyNotificationsResponseItemsInner> get items;

  @BuiltValueField(wireName: r'meta')
  GetMyNotificationsResponseMeta get meta;

  GetMyNotificationsResponse._();

  factory GetMyNotificationsResponse([
    void updates(GetMyNotificationsResponseBuilder b),
  ]) = _$GetMyNotificationsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetMyNotificationsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetMyNotificationsResponse> get serializer =>
      _$GetMyNotificationsResponseSerializer();
}

class _$GetMyNotificationsResponseSerializer
    implements PrimitiveSerializer<GetMyNotificationsResponse> {
  @override
  final Iterable<Type> types = const [
    GetMyNotificationsResponse,
    _$GetMyNotificationsResponse,
  ];

  @override
  final String wireName = r'GetMyNotificationsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetMyNotificationsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [
        FullType(GetMyNotificationsResponseItemsInner),
      ]),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(GetMyNotificationsResponseMeta),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetMyNotificationsResponse object, {
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
    required GetMyNotificationsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(GetMyNotificationsResponseItemsInner),
                    ]),
                  )
                  as BuiltList<GetMyNotificationsResponseItemsInner>;
          result.items.replace(valueDes);
          break;
        case r'meta':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      GetMyNotificationsResponseMeta,
                    ),
                  )
                  as GetMyNotificationsResponseMeta;
          result.meta.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetMyNotificationsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetMyNotificationsResponseBuilder();
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
