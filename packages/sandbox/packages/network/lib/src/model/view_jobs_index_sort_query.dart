//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/view_jobs_index_sort_query_key.dart';
import 'package:openapi/src/model/sort_direction.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_jobs_index_sort_query.g.dart';

/// ViewJobsIndexSortQuery
///
/// Properties:
/// * [key]
/// * [order]
@BuiltValue()
abstract class ViewJobsIndexSortQuery
    implements Built<ViewJobsIndexSortQuery, ViewJobsIndexSortQueryBuilder> {
  @BuiltValueField(wireName: r'key')
  ViewJobsIndexSortQueryKey get key;
  // enum keyEnum {  createdAt,  };

  @BuiltValueField(wireName: r'order')
  SortDirection get order;
  // enum orderEnum {  asc,  desc,  };

  ViewJobsIndexSortQuery._();

  factory ViewJobsIndexSortQuery([
    void updates(ViewJobsIndexSortQueryBuilder b),
  ]) = _$ViewJobsIndexSortQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobsIndexSortQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobsIndexSortQuery> get serializer =>
      _$ViewJobsIndexSortQuerySerializer();
}

class _$ViewJobsIndexSortQuerySerializer
    implements PrimitiveSerializer<ViewJobsIndexSortQuery> {
  @override
  final Iterable<Type> types = const [
    ViewJobsIndexSortQuery,
    _$ViewJobsIndexSortQuery,
  ];

  @override
  final String wireName = r'ViewJobsIndexSortQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobsIndexSortQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'key';
    yield serializers.serialize(
      object.key,
      specifiedType: const FullType(ViewJobsIndexSortQueryKey),
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
    ViewJobsIndexSortQuery object, {
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
    required ViewJobsIndexSortQueryBuilder result,
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
                    specifiedType: const FullType(ViewJobsIndexSortQueryKey),
                  )
                  as ViewJobsIndexSortQueryKey;
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
  ViewJobsIndexSortQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobsIndexSortQueryBuilder();
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
