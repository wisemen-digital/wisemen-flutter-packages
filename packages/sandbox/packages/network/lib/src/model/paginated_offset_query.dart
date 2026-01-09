//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'paginated_offset_query.g.dart';

/// PaginatedOffsetQuery
///
/// Properties:
/// * [limit]
/// * [offset]
@BuiltValue()
abstract class PaginatedOffsetQuery
    implements Built<PaginatedOffsetQuery, PaginatedOffsetQueryBuilder> {
  @BuiltValueField(wireName: r'limit')
  num get limit;

  @BuiltValueField(wireName: r'offset')
  num get offset;

  PaginatedOffsetQuery._();

  factory PaginatedOffsetQuery([void updates(PaginatedOffsetQueryBuilder b)]) =
      _$PaginatedOffsetQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaginatedOffsetQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaginatedOffsetQuery> get serializer =>
      _$PaginatedOffsetQuerySerializer();
}

class _$PaginatedOffsetQuerySerializer
    implements PrimitiveSerializer<PaginatedOffsetQuery> {
  @override
  final Iterable<Type> types = const [
    PaginatedOffsetQuery,
    _$PaginatedOffsetQuery,
  ];

  @override
  final String wireName = r'PaginatedOffsetQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaginatedOffsetQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'limit';
    yield serializers.serialize(
      object.limit,
      specifiedType: const FullType(num),
    );
    yield r'offset';
    yield serializers.serialize(
      object.offset,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaginatedOffsetQuery object, {
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
    required PaginatedOffsetQueryBuilder result,
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
        case r'offset':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.offset = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaginatedOffsetQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaginatedOffsetQueryBuilder();
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
