//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/search_collections_response_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_collections_response.g.dart';

/// SearchCollectionsResponse
///
/// Properties:
/// * [items]
@BuiltValue()
abstract class SearchCollectionsResponse
    implements
        Built<SearchCollectionsResponse, SearchCollectionsResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<SearchCollectionsResponseItem> get items;

  SearchCollectionsResponse._();

  factory SearchCollectionsResponse([
    void updates(SearchCollectionsResponseBuilder b),
  ]) = _$SearchCollectionsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchCollectionsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchCollectionsResponse> get serializer =>
      _$SearchCollectionsResponseSerializer();
}

class _$SearchCollectionsResponseSerializer
    implements PrimitiveSerializer<SearchCollectionsResponse> {
  @override
  final Iterable<Type> types = const [
    SearchCollectionsResponse,
    _$SearchCollectionsResponse,
  ];

  @override
  final String wireName = r'SearchCollectionsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchCollectionsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [
        FullType(SearchCollectionsResponseItem),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchCollectionsResponse object, {
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
    required SearchCollectionsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(SearchCollectionsResponseItem),
                    ]),
                  )
                  as BuiltList<SearchCollectionsResponseItem>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchCollectionsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchCollectionsResponseBuilder();
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
