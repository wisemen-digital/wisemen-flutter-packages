//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/search_collections_response_item_entity.dart';
import 'package:openapi/src/model/global_search_collection_name.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_collections_response_item.g.dart';

/// SearchCollectionsResponseItem
///
/// Properties:
/// * [collection]
/// * [entity]
/// * [textMatch]
@BuiltValue()
abstract class SearchCollectionsResponseItem
    implements
        Built<
          SearchCollectionsResponseItem,
          SearchCollectionsResponseItemBuilder
        > {
  @BuiltValueField(wireName: r'collection')
  GlobalSearchCollectionName get collection;
  // enum collectionEnum {  user,  contact,  };

  @BuiltValueField(wireName: r'entity')
  SearchCollectionsResponseItemEntity get entity;

  @BuiltValueField(wireName: r'text_match')
  num get textMatch;

  SearchCollectionsResponseItem._();

  factory SearchCollectionsResponseItem([
    void updates(SearchCollectionsResponseItemBuilder b),
  ]) = _$SearchCollectionsResponseItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchCollectionsResponseItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchCollectionsResponseItem> get serializer =>
      _$SearchCollectionsResponseItemSerializer();
}

class _$SearchCollectionsResponseItemSerializer
    implements PrimitiveSerializer<SearchCollectionsResponseItem> {
  @override
  final Iterable<Type> types = const [
    SearchCollectionsResponseItem,
    _$SearchCollectionsResponseItem,
  ];

  @override
  final String wireName = r'SearchCollectionsResponseItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchCollectionsResponseItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'collection';
    yield serializers.serialize(
      object.collection,
      specifiedType: const FullType(GlobalSearchCollectionName),
    );
    yield r'entity';
    yield serializers.serialize(
      object.entity,
      specifiedType: const FullType(SearchCollectionsResponseItemEntity),
    );
    yield r'text_match';
    yield serializers.serialize(
      object.textMatch,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchCollectionsResponseItem object, {
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
    required SearchCollectionsResponseItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'collection':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(GlobalSearchCollectionName),
                  )
                  as GlobalSearchCollectionName;
          result.collection = valueDes;
          break;
        case r'entity':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      SearchCollectionsResponseItemEntity,
                    ),
                  )
                  as SearchCollectionsResponseItemEntity;
          result.entity.replace(valueDes);
          break;
        case r'text_match':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.textMatch = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchCollectionsResponseItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchCollectionsResponseItemBuilder();
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
