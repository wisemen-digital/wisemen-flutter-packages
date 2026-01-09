//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_collection_user_response.g.dart';

/// SearchCollectionUserResponse
///
/// Properties:
/// * [uuid]
/// * [name]
/// * [email]
@BuiltValue()
abstract class SearchCollectionUserResponse
    implements
        Built<
          SearchCollectionUserResponse,
          SearchCollectionUserResponseBuilder
        > {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'email')
  String get email;

  SearchCollectionUserResponse._();

  factory SearchCollectionUserResponse([
    void updates(SearchCollectionUserResponseBuilder b),
  ]) = _$SearchCollectionUserResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchCollectionUserResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchCollectionUserResponse> get serializer =>
      _$SearchCollectionUserResponseSerializer();
}

class _$SearchCollectionUserResponseSerializer
    implements PrimitiveSerializer<SearchCollectionUserResponse> {
  @override
  final Iterable<Type> types = const [
    SearchCollectionUserResponse,
    _$SearchCollectionUserResponse,
  ];

  @override
  final String wireName = r'SearchCollectionUserResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchCollectionUserResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchCollectionUserResponse object, {
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
    required SearchCollectionUserResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'uuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.uuid = valueDes;
          break;
        case r'name':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.name = valueDes;
          break;
        case r'email':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchCollectionUserResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchCollectionUserResponseBuilder();
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
