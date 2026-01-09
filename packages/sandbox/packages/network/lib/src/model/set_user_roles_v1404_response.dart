//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/set_user_roles_v1404_response_errors_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_user_roles_v1404_response.g.dart';

/// SetUserRolesV1404Response
///
/// Properties:
/// * [traceId]
/// * [errors]
@BuiltValue()
abstract class SetUserRolesV1404Response
    implements
        Built<SetUserRolesV1404Response, SetUserRolesV1404ResponseBuilder> {
  @BuiltValueField(wireName: r'traceId')
  String? get traceId;

  @BuiltValueField(wireName: r'errors')
  BuiltList<SetUserRolesV1404ResponseErrorsInner>? get errors;

  SetUserRolesV1404Response._();

  factory SetUserRolesV1404Response([
    void updates(SetUserRolesV1404ResponseBuilder b),
  ]) = _$SetUserRolesV1404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetUserRolesV1404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetUserRolesV1404Response> get serializer =>
      _$SetUserRolesV1404ResponseSerializer();
}

class _$SetUserRolesV1404ResponseSerializer
    implements PrimitiveSerializer<SetUserRolesV1404Response> {
  @override
  final Iterable<Type> types = const [
    SetUserRolesV1404Response,
    _$SetUserRolesV1404Response,
  ];

  @override
  final String wireName = r'SetUserRolesV1404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetUserRolesV1404Response object, {
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
          FullType(SetUserRolesV1404ResponseErrorsInner),
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SetUserRolesV1404Response object, {
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
    required SetUserRolesV1404ResponseBuilder result,
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
                      FullType(SetUserRolesV1404ResponseErrorsInner),
                    ]),
                  )
                  as BuiltList<SetUserRolesV1404ResponseErrorsInner>;
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
  SetUserRolesV1404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetUserRolesV1404ResponseBuilder();
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
