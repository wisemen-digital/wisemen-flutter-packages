//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_collection_index_response.g.dart';

/// ViewCollectionIndexResponse
///
/// Properties:
/// * [collections]
@BuiltValue()
abstract class ViewCollectionIndexResponse
    implements
        Built<ViewCollectionIndexResponse, ViewCollectionIndexResponseBuilder> {
  @BuiltValueField(wireName: r'collections')
  BuiltList<ViewCollectionIndexResponseCollectionsEnum> get collections;
  // enum collectionsEnum {  user,  contact,  };

  ViewCollectionIndexResponse._();

  factory ViewCollectionIndexResponse([
    void updates(ViewCollectionIndexResponseBuilder b),
  ]) = _$ViewCollectionIndexResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewCollectionIndexResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewCollectionIndexResponse> get serializer =>
      _$ViewCollectionIndexResponseSerializer();
}

class _$ViewCollectionIndexResponseSerializer
    implements PrimitiveSerializer<ViewCollectionIndexResponse> {
  @override
  final Iterable<Type> types = const [
    ViewCollectionIndexResponse,
    _$ViewCollectionIndexResponse,
  ];

  @override
  final String wireName = r'ViewCollectionIndexResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewCollectionIndexResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'collections';
    yield serializers.serialize(
      object.collections,
      specifiedType: const FullType(BuiltList, [
        FullType(ViewCollectionIndexResponseCollectionsEnum),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewCollectionIndexResponse object, {
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
    required ViewCollectionIndexResponseBuilder result,
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
                      FullType(ViewCollectionIndexResponseCollectionsEnum),
                    ]),
                  )
                  as BuiltList<ViewCollectionIndexResponseCollectionsEnum>;
          result.collections.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewCollectionIndexResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewCollectionIndexResponseBuilder();
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

class ViewCollectionIndexResponseCollectionsEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user')
  static const ViewCollectionIndexResponseCollectionsEnum user =
      _$viewCollectionIndexResponseCollectionsEnum_user;
  @BuiltValueEnumConst(wireName: r'contact')
  static const ViewCollectionIndexResponseCollectionsEnum contact =
      _$viewCollectionIndexResponseCollectionsEnum_contact;

  static Serializer<ViewCollectionIndexResponseCollectionsEnum>
  get serializer => _$viewCollectionIndexResponseCollectionsEnumSerializer;

  const ViewCollectionIndexResponseCollectionsEnum._(String name) : super(name);

  static BuiltSet<ViewCollectionIndexResponseCollectionsEnum> get values =>
      _$viewCollectionIndexResponseCollectionsEnumValues;
  static ViewCollectionIndexResponseCollectionsEnum valueOf(String name) =>
      _$viewCollectionIndexResponseCollectionsEnumValueOf(name);
}
