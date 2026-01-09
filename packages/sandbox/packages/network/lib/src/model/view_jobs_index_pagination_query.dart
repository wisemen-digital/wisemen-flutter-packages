//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/view_jobs_index_query_key.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_jobs_index_pagination_query.g.dart';

/// ViewJobsIndexPaginationQuery
///
/// Properties:
/// * [limit]
/// * [key]
@BuiltValue()
abstract class ViewJobsIndexPaginationQuery
    implements
        Built<
          ViewJobsIndexPaginationQuery,
          ViewJobsIndexPaginationQueryBuilder
        > {
  @BuiltValueField(wireName: r'limit')
  num get limit;

  @BuiltValueField(wireName: r'key')
  ViewJobsIndexQueryKey? get key;

  ViewJobsIndexPaginationQuery._();

  factory ViewJobsIndexPaginationQuery([
    void updates(ViewJobsIndexPaginationQueryBuilder b),
  ]) = _$ViewJobsIndexPaginationQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobsIndexPaginationQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobsIndexPaginationQuery> get serializer =>
      _$ViewJobsIndexPaginationQuerySerializer();
}

class _$ViewJobsIndexPaginationQuerySerializer
    implements PrimitiveSerializer<ViewJobsIndexPaginationQuery> {
  @override
  final Iterable<Type> types = const [
    ViewJobsIndexPaginationQuery,
    _$ViewJobsIndexPaginationQuery,
  ];

  @override
  final String wireName = r'ViewJobsIndexPaginationQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobsIndexPaginationQuery object, {
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
        specifiedType: const FullType.nullable(ViewJobsIndexQueryKey),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewJobsIndexPaginationQuery object, {
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
    required ViewJobsIndexPaginationQueryBuilder result,
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
                    specifiedType: const FullType.nullable(
                      ViewJobsIndexQueryKey,
                    ),
                  )
                  as ViewJobsIndexQueryKey?;
          if (valueDes == null) continue;
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
  ViewJobsIndexPaginationQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobsIndexPaginationQueryBuilder();
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
