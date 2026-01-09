//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/sort_direction.dart';
import 'package:openapi/src/model/view_contact_index_sort_query_key.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_contact_index_sort_query.g.dart';

/// ViewContactIndexSortQuery
///
/// Properties:
/// * [key]
/// * [order]
@BuiltValue()
abstract class ViewContactIndexSortQuery
    implements
        Built<ViewContactIndexSortQuery, ViewContactIndexSortQueryBuilder> {
  @BuiltValueField(wireName: r'key')
  ViewContactIndexSortQueryKey get key;
  // enum keyEnum {  name,  };

  @BuiltValueField(wireName: r'order')
  SortDirection get order;
  // enum orderEnum {  asc,  desc,  };

  ViewContactIndexSortQuery._();

  factory ViewContactIndexSortQuery([
    void updates(ViewContactIndexSortQueryBuilder b),
  ]) = _$ViewContactIndexSortQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewContactIndexSortQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewContactIndexSortQuery> get serializer =>
      _$ViewContactIndexSortQuerySerializer();
}

class _$ViewContactIndexSortQuerySerializer
    implements PrimitiveSerializer<ViewContactIndexSortQuery> {
  @override
  final Iterable<Type> types = const [
    ViewContactIndexSortQuery,
    _$ViewContactIndexSortQuery,
  ];

  @override
  final String wireName = r'ViewContactIndexSortQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewContactIndexSortQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'key';
    yield serializers.serialize(
      object.key,
      specifiedType: const FullType(ViewContactIndexSortQueryKey),
    );
    yield r'order';
    yield serializers.serialize(
      object.order,
      specifiedType: const FullType(SortDirection),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewContactIndexSortQuery object, {
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
    required ViewContactIndexSortQueryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'key':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(ViewContactIndexSortQueryKey),
                  )
                  as ViewContactIndexSortQueryKey;
          result.key = valueDes;
          break;
        case r'order':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(SortDirection),
                  )
                  as SortDirection;
          result.order = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewContactIndexSortQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewContactIndexSortQueryBuilder();
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
