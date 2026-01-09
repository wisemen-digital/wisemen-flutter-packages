//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/role_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_role_index_response.g.dart';

/// ViewRoleIndexResponse
///
/// Properties:
/// * [items]
@BuiltValue()
abstract class ViewRoleIndexResponse
    implements Built<ViewRoleIndexResponse, ViewRoleIndexResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<RoleResponse> get items;

  ViewRoleIndexResponse._();

  factory ViewRoleIndexResponse([
    void updates(ViewRoleIndexResponseBuilder b),
  ]) = _$ViewRoleIndexResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewRoleIndexResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewRoleIndexResponse> get serializer =>
      _$ViewRoleIndexResponseSerializer();
}

class _$ViewRoleIndexResponseSerializer
    implements PrimitiveSerializer<ViewRoleIndexResponse> {
  @override
  final Iterable<Type> types = const [
    ViewRoleIndexResponse,
    _$ViewRoleIndexResponse,
  ];

  @override
  final String wireName = r'ViewRoleIndexResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewRoleIndexResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(RoleResponse)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewRoleIndexResponse object, {
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
    required ViewRoleIndexResponseBuilder result,
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
                      FullType(RoleResponse),
                    ]),
                  )
                  as BuiltList<RoleResponse>;
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
  ViewRoleIndexResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewRoleIndexResponseBuilder();
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
