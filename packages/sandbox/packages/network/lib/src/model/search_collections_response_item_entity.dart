//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/search_collection_user_response.dart';
import 'package:openapi/src/model/search_collection_contact_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'search_collections_response_item_entity.g.dart';

/// SearchCollectionsResponseItemEntity
///
/// Properties:
/// * [uuid]
/// * [name]
/// * [email]
/// * [isActive]
/// * [phone]
/// * [address]
@BuiltValue()
abstract class SearchCollectionsResponseItemEntity
    implements
        Built<
          SearchCollectionsResponseItemEntity,
          SearchCollectionsResponseItemEntityBuilder
        > {
  /// One Of [SearchCollectionContactResponse], [SearchCollectionUserResponse]
  OneOf get oneOf;

  SearchCollectionsResponseItemEntity._();

  factory SearchCollectionsResponseItemEntity([
    void updates(SearchCollectionsResponseItemEntityBuilder b),
  ]) = _$SearchCollectionsResponseItemEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchCollectionsResponseItemEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchCollectionsResponseItemEntity> get serializer =>
      _$SearchCollectionsResponseItemEntitySerializer();
}

class _$SearchCollectionsResponseItemEntitySerializer
    implements PrimitiveSerializer<SearchCollectionsResponseItemEntity> {
  @override
  final Iterable<Type> types = const [
    SearchCollectionsResponseItemEntity,
    _$SearchCollectionsResponseItemEntity,
  ];

  @override
  final String wireName = r'SearchCollectionsResponseItemEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchCollectionsResponseItemEntity object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    SearchCollectionsResponseItemEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(
      oneOf.value,
      specifiedType: FullType(oneOf.valueType),
    )!;
  }

  @override
  SearchCollectionsResponseItemEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchCollectionsResponseItemEntityBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [
      FullType(SearchCollectionUserResponse),
      FullType(SearchCollectionContactResponse),
    ]);
    oneOfDataSrc = serialized;
    result.oneOf =
        serializers.deserialize(oneOfDataSrc, specifiedType: targetType)
            as OneOf;
    return result.build();
  }
}
