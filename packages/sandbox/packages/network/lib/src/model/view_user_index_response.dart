//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/paginated_offset_response_meta.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/user_index_view.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_user_index_response.g.dart';

/// ViewUserIndexResponse
///
/// Properties:
/// * [items] - The items for the current page
/// * [meta]
@BuiltValue()
abstract class ViewUserIndexResponse
    implements Built<ViewUserIndexResponse, ViewUserIndexResponseBuilder> {
  /// The items for the current page
  @BuiltValueField(wireName: r'items')
  BuiltList<UserIndexView> get items;

  @BuiltValueField(wireName: r'meta')
  PaginatedOffsetResponseMeta get meta;

  ViewUserIndexResponse._();

  factory ViewUserIndexResponse([
    void updates(ViewUserIndexResponseBuilder b),
  ]) = _$ViewUserIndexResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewUserIndexResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewUserIndexResponse> get serializer =>
      _$ViewUserIndexResponseSerializer();
}

class _$ViewUserIndexResponseSerializer
    implements PrimitiveSerializer<ViewUserIndexResponse> {
  @override
  final Iterable<Type> types = const [
    ViewUserIndexResponse,
    _$ViewUserIndexResponse,
  ];

  @override
  final String wireName = r'ViewUserIndexResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewUserIndexResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(UserIndexView)]),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(PaginatedOffsetResponseMeta),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewUserIndexResponse object, {
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
    required ViewUserIndexResponseBuilder result,
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
                      FullType(UserIndexView),
                    ]),
                  )
                  as BuiltList<UserIndexView>;
          result.items.replace(valueDes);
          break;
        case r'meta':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(PaginatedOffsetResponseMeta),
                  )
                  as PaginatedOffsetResponseMeta;
          result.meta.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewUserIndexResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewUserIndexResponseBuilder();
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
