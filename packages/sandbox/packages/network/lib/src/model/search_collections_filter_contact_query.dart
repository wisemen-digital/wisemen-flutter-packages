//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_collections_filter_contact_query.g.dart';

/// SearchCollectionsFilterContactQuery
///
/// Properties:
/// * [isActive]
@BuiltValue()
abstract class SearchCollectionsFilterContactQuery
    implements
        Built<
          SearchCollectionsFilterContactQuery,
          SearchCollectionsFilterContactQueryBuilder
        > {
  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  SearchCollectionsFilterContactQuery._();

  factory SearchCollectionsFilterContactQuery([
    void updates(SearchCollectionsFilterContactQueryBuilder b),
  ]) = _$SearchCollectionsFilterContactQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchCollectionsFilterContactQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchCollectionsFilterContactQuery> get serializer =>
      _$SearchCollectionsFilterContactQuerySerializer();
}

class _$SearchCollectionsFilterContactQuerySerializer
    implements PrimitiveSerializer<SearchCollectionsFilterContactQuery> {
  @override
  final Iterable<Type> types = const [
    SearchCollectionsFilterContactQuery,
    _$SearchCollectionsFilterContactQuery,
  ];

  @override
  final String wireName = r'SearchCollectionsFilterContactQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchCollectionsFilterContactQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.isActive != null) {
      yield r'isActive';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchCollectionsFilterContactQuery object, {
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
    required SearchCollectionsFilterContactQueryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'isActive':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchCollectionsFilterContactQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchCollectionsFilterContactQueryBuilder();
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
