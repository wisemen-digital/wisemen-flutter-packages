//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/delete_contact_v1404_response_errors_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_contact_v1404_response.g.dart';

/// DeleteContactV1404Response
///
/// Properties:
/// * [traceId]
/// * [errors]
@BuiltValue()
abstract class DeleteContactV1404Response
    implements
        Built<DeleteContactV1404Response, DeleteContactV1404ResponseBuilder> {
  @BuiltValueField(wireName: r'traceId')
  String? get traceId;

  @BuiltValueField(wireName: r'errors')
  BuiltList<DeleteContactV1404ResponseErrorsInner>? get errors;

  DeleteContactV1404Response._();

  factory DeleteContactV1404Response([
    void updates(DeleteContactV1404ResponseBuilder b),
  ]) = _$DeleteContactV1404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteContactV1404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteContactV1404Response> get serializer =>
      _$DeleteContactV1404ResponseSerializer();
}

class _$DeleteContactV1404ResponseSerializer
    implements PrimitiveSerializer<DeleteContactV1404Response> {
  @override
  final Iterable<Type> types = const [
    DeleteContactV1404Response,
    _$DeleteContactV1404Response,
  ];

  @override
  final String wireName = r'DeleteContactV1404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteContactV1404Response object, {
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
          FullType(DeleteContactV1404ResponseErrorsInner),
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteContactV1404Response object, {
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
    required DeleteContactV1404ResponseBuilder result,
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
                      FullType(DeleteContactV1404ResponseErrorsInner),
                    ]),
                  )
                  as BuiltList<DeleteContactV1404ResponseErrorsInner>;
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
  DeleteContactV1404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteContactV1404ResponseBuilder();
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
