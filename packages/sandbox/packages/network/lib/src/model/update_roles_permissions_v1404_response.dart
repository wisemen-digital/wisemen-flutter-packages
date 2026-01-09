//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/update_roles_permissions_v1404_response_errors_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_roles_permissions_v1404_response.g.dart';

/// UpdateRolesPermissionsV1404Response
///
/// Properties:
/// * [traceId]
/// * [errors]
@BuiltValue()
abstract class UpdateRolesPermissionsV1404Response
    implements
        Built<
          UpdateRolesPermissionsV1404Response,
          UpdateRolesPermissionsV1404ResponseBuilder
        > {
  @BuiltValueField(wireName: r'traceId')
  String? get traceId;

  @BuiltValueField(wireName: r'errors')
  BuiltList<UpdateRolesPermissionsV1404ResponseErrorsInner>? get errors;

  UpdateRolesPermissionsV1404Response._();

  factory UpdateRolesPermissionsV1404Response([
    void updates(UpdateRolesPermissionsV1404ResponseBuilder b),
  ]) = _$UpdateRolesPermissionsV1404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRolesPermissionsV1404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRolesPermissionsV1404Response> get serializer =>
      _$UpdateRolesPermissionsV1404ResponseSerializer();
}

class _$UpdateRolesPermissionsV1404ResponseSerializer
    implements PrimitiveSerializer<UpdateRolesPermissionsV1404Response> {
  @override
  final Iterable<Type> types = const [
    UpdateRolesPermissionsV1404Response,
    _$UpdateRolesPermissionsV1404Response,
  ];

  @override
  final String wireName = r'UpdateRolesPermissionsV1404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRolesPermissionsV1404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.traceId != null) {
      yield r'traceId';
      yield serializers.serialize(
        object.traceId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.errors != null) {
      yield r'errors';
      yield serializers.serialize(
        object.errors,
        specifiedType: const FullType(BuiltList, [
          FullType(UpdateRolesPermissionsV1404ResponseErrorsInner),
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateRolesPermissionsV1404Response object, {
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
    required UpdateRolesPermissionsV1404ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'traceId':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.traceId = valueDes;
          break;
        case r'errors':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(UpdateRolesPermissionsV1404ResponseErrorsInner),
                    ]),
                  )
                  as BuiltList<UpdateRolesPermissionsV1404ResponseErrorsInner>;
          result.errors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateRolesPermissionsV1404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRolesPermissionsV1404ResponseBuilder();
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
