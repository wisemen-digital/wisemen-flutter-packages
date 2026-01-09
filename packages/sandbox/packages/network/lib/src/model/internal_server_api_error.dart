//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'internal_server_api_error.g.dart';

/// InternalServerApiError
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class InternalServerApiError
    implements Built<InternalServerApiError, InternalServerApiErrorBuilder> {
  /// a human-readable explanation specific to this occurrence of the problem
  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  InternalServerApiErrorStatusEnum get status;
  // enum statusEnum {  500,  };

  @BuiltValueField(wireName: r'code')
  InternalServerApiErrorCodeEnum get code;
  // enum codeEnum {  internal_server_error,  };

  InternalServerApiError._();

  factory InternalServerApiError([
    void updates(InternalServerApiErrorBuilder b),
  ]) = _$InternalServerApiError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InternalServerApiErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InternalServerApiError> get serializer =>
      _$InternalServerApiErrorSerializer();
}

class _$InternalServerApiErrorSerializer
    implements PrimitiveSerializer<InternalServerApiError> {
  @override
  final Iterable<Type> types = const [
    InternalServerApiError,
    _$InternalServerApiError,
  ];

  @override
  final String wireName = r'InternalServerApiError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InternalServerApiError object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.detail != null) {
      yield r'detail';
      yield serializers.serialize(
        object.detail,
        specifiedType: const FullType(String),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(InternalServerApiErrorStatusEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(InternalServerApiErrorCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InternalServerApiError object, {
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
    required InternalServerApiErrorBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'detail':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.detail = valueDes;
          break;
        case r'status':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      InternalServerApiErrorStatusEnum,
                    ),
                  )
                  as InternalServerApiErrorStatusEnum;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      InternalServerApiErrorCodeEnum,
                    ),
                  )
                  as InternalServerApiErrorCodeEnum;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InternalServerApiError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InternalServerApiErrorBuilder();
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

class InternalServerApiErrorStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'500')
  static const InternalServerApiErrorStatusEnum n500 =
      _$internalServerApiErrorStatusEnum_n500;

  static Serializer<InternalServerApiErrorStatusEnum> get serializer =>
      _$internalServerApiErrorStatusEnumSerializer;

  const InternalServerApiErrorStatusEnum._(String name) : super(name);

  static BuiltSet<InternalServerApiErrorStatusEnum> get values =>
      _$internalServerApiErrorStatusEnumValues;
  static InternalServerApiErrorStatusEnum valueOf(String name) =>
      _$internalServerApiErrorStatusEnumValueOf(name);
}

class InternalServerApiErrorCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'internal_server_error')
  static const InternalServerApiErrorCodeEnum internalServerError =
      _$internalServerApiErrorCodeEnum_internalServerError;

  static Serializer<InternalServerApiErrorCodeEnum> get serializer =>
      _$internalServerApiErrorCodeEnumSerializer;

  const InternalServerApiErrorCodeEnum._(String name) : super(name);

  static BuiltSet<InternalServerApiErrorCodeEnum> get values =>
      _$internalServerApiErrorCodeEnumValues;
  static InternalServerApiErrorCodeEnum valueOf(String name) =>
      _$internalServerApiErrorCodeEnumValueOf(name);
}
