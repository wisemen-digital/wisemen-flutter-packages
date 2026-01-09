//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/view_domain_event_log_index_query_key.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_domain_event_log_index_pagination_query.g.dart';

/// ViewDomainEventLogIndexPaginationQuery
///
/// Properties:
/// * [limit]
/// * [key]
@BuiltValue()
abstract class ViewDomainEventLogIndexPaginationQuery
    implements
        Built<
          ViewDomainEventLogIndexPaginationQuery,
          ViewDomainEventLogIndexPaginationQueryBuilder
        > {
  @BuiltValueField(wireName: r'limit')
  num get limit;

  @BuiltValueField(wireName: r'key')
  ViewDomainEventLogIndexQueryKey? get key;

  ViewDomainEventLogIndexPaginationQuery._();

  factory ViewDomainEventLogIndexPaginationQuery([
    void updates(ViewDomainEventLogIndexPaginationQueryBuilder b),
  ]) = _$ViewDomainEventLogIndexPaginationQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewDomainEventLogIndexPaginationQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewDomainEventLogIndexPaginationQuery> get serializer =>
      _$ViewDomainEventLogIndexPaginationQuerySerializer();
}

class _$ViewDomainEventLogIndexPaginationQuerySerializer
    implements PrimitiveSerializer<ViewDomainEventLogIndexPaginationQuery> {
  @override
  final Iterable<Type> types = const [
    ViewDomainEventLogIndexPaginationQuery,
    _$ViewDomainEventLogIndexPaginationQuery,
  ];

  @override
  final String wireName = r'ViewDomainEventLogIndexPaginationQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewDomainEventLogIndexPaginationQuery object, {
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
        specifiedType: const FullType.nullable(ViewDomainEventLogIndexQueryKey),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewDomainEventLogIndexPaginationQuery object, {
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
    required ViewDomainEventLogIndexPaginationQueryBuilder result,
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
                      ViewDomainEventLogIndexQueryKey,
                    ),
                  )
                  as ViewDomainEventLogIndexQueryKey?;
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
  ViewDomainEventLogIndexPaginationQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewDomainEventLogIndexPaginationQueryBuilder();
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
