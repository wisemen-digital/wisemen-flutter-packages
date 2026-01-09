//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_my_notifications_filter_query.g.dart';

/// GetMyNotificationsFilterQuery
///
/// Properties:
/// * [onlyUnread]
@BuiltValue()
abstract class GetMyNotificationsFilterQuery
    implements
        Built<
          GetMyNotificationsFilterQuery,
          GetMyNotificationsFilterQueryBuilder
        > {
  @BuiltValueField(wireName: r'onlyUnread')
  String? get onlyUnread;

  GetMyNotificationsFilterQuery._();

  factory GetMyNotificationsFilterQuery([
    void updates(GetMyNotificationsFilterQueryBuilder b),
  ]) = _$GetMyNotificationsFilterQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetMyNotificationsFilterQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetMyNotificationsFilterQuery> get serializer =>
      _$GetMyNotificationsFilterQuerySerializer();
}

class _$GetMyNotificationsFilterQuerySerializer
    implements PrimitiveSerializer<GetMyNotificationsFilterQuery> {
  @override
  final Iterable<Type> types = const [
    GetMyNotificationsFilterQuery,
    _$GetMyNotificationsFilterQuery,
  ];

  @override
  final String wireName = r'GetMyNotificationsFilterQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetMyNotificationsFilterQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.onlyUnread != null) {
      yield r'onlyUnread';
      yield serializers.serialize(
        object.onlyUnread,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetMyNotificationsFilterQuery object, {
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
    required GetMyNotificationsFilterQueryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'onlyUnread':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.onlyUnread = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetMyNotificationsFilterQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetMyNotificationsFilterQueryBuilder();
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
