//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/search_collections_filter_contact_query.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/global_search_collection_name.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_collections_filter_query.g.dart';

/// SearchCollectionsFilterQuery
///
/// Properties:
/// * [collections]
/// * [contact]
@BuiltValue()
abstract class SearchCollectionsFilterQuery
    implements
        Built<
          SearchCollectionsFilterQuery,
          SearchCollectionsFilterQueryBuilder
        > {
  @BuiltValueField(wireName: r'collections')
  BuiltList<GlobalSearchCollectionName>? get collections;

  @BuiltValueField(wireName: r'contact')
  SearchCollectionsFilterContactQuery? get contact;

  SearchCollectionsFilterQuery._();

  factory SearchCollectionsFilterQuery([
    void updates(SearchCollectionsFilterQueryBuilder b),
  ]) = _$SearchCollectionsFilterQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchCollectionsFilterQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchCollectionsFilterQuery> get serializer =>
      _$SearchCollectionsFilterQuerySerializer();
}

class _$SearchCollectionsFilterQuerySerializer
    implements PrimitiveSerializer<SearchCollectionsFilterQuery> {
  @override
  final Iterable<Type> types = const [
    SearchCollectionsFilterQuery,
    _$SearchCollectionsFilterQuery,
  ];

  @override
  final String wireName = r'SearchCollectionsFilterQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchCollectionsFilterQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.collections != null) {
      yield r'collections';
      yield serializers.serialize(
        object.collections,
        specifiedType: const FullType(BuiltList, [
          FullType(GlobalSearchCollectionName),
        ]),
      );
    }
    if (object.contact != null) {
      yield r'contact';
      yield serializers.serialize(
        object.contact,
        specifiedType: const FullType(SearchCollectionsFilterContactQuery),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchCollectionsFilterQuery object, {
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
    required SearchCollectionsFilterQueryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'collections':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(GlobalSearchCollectionName),
                    ]),
                  )
                  as BuiltList<GlobalSearchCollectionName>;
          result.collections.replace(valueDes);
          break;
        case r'contact':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      SearchCollectionsFilterContactQuery,
                    ),
                  )
                  as SearchCollectionsFilterContactQuery;
          result.contact.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchCollectionsFilterQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchCollectionsFilterQueryBuilder();
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
