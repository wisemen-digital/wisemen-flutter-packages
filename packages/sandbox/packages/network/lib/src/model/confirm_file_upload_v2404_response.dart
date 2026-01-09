//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/confirm_file_upload_v2404_response_errors_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'confirm_file_upload_v2404_response.g.dart';

/// ConfirmFileUploadV2404Response
///
/// Properties:
/// * [traceId]
/// * [errors]
@BuiltValue()
abstract class ConfirmFileUploadV2404Response
    implements
        Built<
          ConfirmFileUploadV2404Response,
          ConfirmFileUploadV2404ResponseBuilder
        > {
  @BuiltValueField(wireName: r'traceId')
  String? get traceId;

  @BuiltValueField(wireName: r'errors')
  BuiltList<ConfirmFileUploadV2404ResponseErrorsInner>? get errors;

  ConfirmFileUploadV2404Response._();

  factory ConfirmFileUploadV2404Response([
    void updates(ConfirmFileUploadV2404ResponseBuilder b),
  ]) = _$ConfirmFileUploadV2404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmFileUploadV2404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmFileUploadV2404Response> get serializer =>
      _$ConfirmFileUploadV2404ResponseSerializer();
}

class _$ConfirmFileUploadV2404ResponseSerializer
    implements PrimitiveSerializer<ConfirmFileUploadV2404Response> {
  @override
  final Iterable<Type> types = const [
    ConfirmFileUploadV2404Response,
    _$ConfirmFileUploadV2404Response,
  ];

  @override
  final String wireName = r'ConfirmFileUploadV2404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmFileUploadV2404Response object, {
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
          FullType(ConfirmFileUploadV2404ResponseErrorsInner),
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfirmFileUploadV2404Response object, {
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
    required ConfirmFileUploadV2404ResponseBuilder result,
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
                      FullType(ConfirmFileUploadV2404ResponseErrorsInner),
                    ]),
                  )
                  as BuiltList<ConfirmFileUploadV2404ResponseErrorsInner>;
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
  ConfirmFileUploadV2404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmFileUploadV2404ResponseBuilder();
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
