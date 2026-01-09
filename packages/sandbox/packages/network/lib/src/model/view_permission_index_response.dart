//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/view_permission_index_group_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_permission_index_response.g.dart';

/// ViewPermissionIndexResponse
///
/// Properties:
/// * [groups]
@BuiltValue()
abstract class ViewPermissionIndexResponse
    implements
        Built<ViewPermissionIndexResponse, ViewPermissionIndexResponseBuilder> {
  @BuiltValueField(wireName: r'groups')
  BuiltList<ViewPermissionIndexGroupResponse> get groups;

  ViewPermissionIndexResponse._();

  factory ViewPermissionIndexResponse([
    void updates(ViewPermissionIndexResponseBuilder b),
  ]) = _$ViewPermissionIndexResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewPermissionIndexResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewPermissionIndexResponse> get serializer =>
      _$ViewPermissionIndexResponseSerializer();
}

class _$ViewPermissionIndexResponseSerializer
    implements PrimitiveSerializer<ViewPermissionIndexResponse> {
  @override
  final Iterable<Type> types = const [
    ViewPermissionIndexResponse,
    _$ViewPermissionIndexResponse,
  ];

  @override
  final String wireName = r'ViewPermissionIndexResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewPermissionIndexResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'groups';
    yield serializers.serialize(
      object.groups,
      specifiedType: const FullType(BuiltList, [
        FullType(ViewPermissionIndexGroupResponse),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewPermissionIndexResponse object, {
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
    required ViewPermissionIndexResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'groups':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(ViewPermissionIndexGroupResponse),
                    ]),
                  )
                  as BuiltList<ViewPermissionIndexGroupResponse>;
          result.groups.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewPermissionIndexResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewPermissionIndexResponseBuilder();
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
