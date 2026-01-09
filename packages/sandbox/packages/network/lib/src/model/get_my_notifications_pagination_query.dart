//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/get_my_notifications_query_key.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_my_notifications_pagination_query.g.dart';

/// GetMyNotificationsPaginationQuery
///
/// Properties:
/// * [limit]
/// * [key]
@BuiltValue()
abstract class GetMyNotificationsPaginationQuery
    implements
        Built<
          GetMyNotificationsPaginationQuery,
          GetMyNotificationsPaginationQueryBuilder
        > {
  @BuiltValueField(wireName: r'limit')
  num get limit;

  @BuiltValueField(wireName: r'key')
  GetMyNotificationsQueryKey? get key;

  GetMyNotificationsPaginationQuery._();

  factory GetMyNotificationsPaginationQuery([
    void updates(GetMyNotificationsPaginationQueryBuilder b),
  ]) = _$GetMyNotificationsPaginationQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetMyNotificationsPaginationQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetMyNotificationsPaginationQuery> get serializer =>
      _$GetMyNotificationsPaginationQuerySerializer();
}

class _$GetMyNotificationsPaginationQuerySerializer
    implements PrimitiveSerializer<GetMyNotificationsPaginationQuery> {
  @override
  final Iterable<Type> types = const [
    GetMyNotificationsPaginationQuery,
    _$GetMyNotificationsPaginationQuery,
  ];

  @override
  final String wireName = r'GetMyNotificationsPaginationQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetMyNotificationsPaginationQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'limit';
    yield serializers.serialize(
      object.limit,
      specifiedType: const FullType(num),
    );
    if (object.key != null) {
      yield r'key';
      yield serializers.serialize(
        object.key,
        specifiedType: const FullType(GetMyNotificationsQueryKey),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetMyNotificationsPaginationQuery object, {
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
    required GetMyNotificationsPaginationQueryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'limit':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.limit = valueDes;
          break;
        case r'key':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(GetMyNotificationsQueryKey),
                  )
                  as GetMyNotificationsQueryKey;
          result.key.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetMyNotificationsPaginationQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetMyNotificationsPaginationQueryBuilder();
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
