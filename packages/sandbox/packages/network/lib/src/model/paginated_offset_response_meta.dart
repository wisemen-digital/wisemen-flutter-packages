//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'paginated_offset_response_meta.g.dart';

/// PaginatedOffsetResponseMeta
///
/// Properties:
/// * [total] - the total amount of items that exist
/// * [offset] - the amount of items skipped
/// * [limit] - the amount of items per response
@BuiltValue()
abstract class PaginatedOffsetResponseMeta
    implements
        Built<PaginatedOffsetResponseMeta, PaginatedOffsetResponseMetaBuilder> {
  /// the total amount of items that exist
  @BuiltValueField(wireName: r'total')
  num get total;

  /// the amount of items skipped
  @BuiltValueField(wireName: r'offset')
  num get offset;

  /// the amount of items per response
  @BuiltValueField(wireName: r'limit')
  num get limit;

  PaginatedOffsetResponseMeta._();

  factory PaginatedOffsetResponseMeta([
    void updates(PaginatedOffsetResponseMetaBuilder b),
  ]) = _$PaginatedOffsetResponseMeta;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaginatedOffsetResponseMetaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaginatedOffsetResponseMeta> get serializer =>
      _$PaginatedOffsetResponseMetaSerializer();
}

class _$PaginatedOffsetResponseMetaSerializer
    implements PrimitiveSerializer<PaginatedOffsetResponseMeta> {
  @override
  final Iterable<Type> types = const [
    PaginatedOffsetResponseMeta,
    _$PaginatedOffsetResponseMeta,
  ];

  @override
  final String wireName = r'PaginatedOffsetResponseMeta';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaginatedOffsetResponseMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(num),
    );
    yield r'offset';
    yield serializers.serialize(
      object.offset,
      specifiedType: const FullType(num),
    );
    yield r'limit';
    yield serializers.serialize(
      object.limit,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaginatedOffsetResponseMeta object, {
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
    required PaginatedOffsetResponseMetaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.total = valueDes;
          break;
        case r'offset':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.offset = valueDes;
          break;
        case r'limit':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.limit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaginatedOffsetResponseMeta deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaginatedOffsetResponseMetaBuilder();
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
