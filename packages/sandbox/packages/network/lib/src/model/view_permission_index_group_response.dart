//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/view_permission_index_permission_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_permission_index_group_response.g.dart';

/// ViewPermissionIndexGroupResponse
///
/// Properties:
/// * [name]
/// * [permissions]
@BuiltValue()
abstract class ViewPermissionIndexGroupResponse
    implements
        Built<
          ViewPermissionIndexGroupResponse,
          ViewPermissionIndexGroupResponseBuilder
        > {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'permissions')
  BuiltList<ViewPermissionIndexPermissionResponse> get permissions;

  ViewPermissionIndexGroupResponse._();

  factory ViewPermissionIndexGroupResponse([
    void updates(ViewPermissionIndexGroupResponseBuilder b),
  ]) = _$ViewPermissionIndexGroupResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewPermissionIndexGroupResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewPermissionIndexGroupResponse> get serializer =>
      _$ViewPermissionIndexGroupResponseSerializer();
}

class _$ViewPermissionIndexGroupResponseSerializer
    implements PrimitiveSerializer<ViewPermissionIndexGroupResponse> {
  @override
  final Iterable<Type> types = const [
    ViewPermissionIndexGroupResponse,
    _$ViewPermissionIndexGroupResponse,
  ];

  @override
  final String wireName = r'ViewPermissionIndexGroupResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewPermissionIndexGroupResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(BuiltList, [
        FullType(ViewPermissionIndexPermissionResponse),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewPermissionIndexGroupResponse object, {
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
    required ViewPermissionIndexGroupResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.name = valueDes;
          break;
        case r'permissions':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(ViewPermissionIndexPermissionResponse),
                    ]),
                  )
                  as BuiltList<ViewPermissionIndexPermissionResponse>;
          result.permissions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewPermissionIndexGroupResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewPermissionIndexGroupResponseBuilder();
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
