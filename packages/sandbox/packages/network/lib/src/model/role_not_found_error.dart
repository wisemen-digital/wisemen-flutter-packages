//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_not_found_error.g.dart';

/// RoleNotFoundError
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class RoleNotFoundError
    implements Built<RoleNotFoundError, RoleNotFoundErrorBuilder> {
  /// a human-readable explanation specific to this occurrence of the problem
  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  RoleNotFoundErrorStatusEnum get status;
  // enum statusEnum {  404,  };

  @BuiltValueField(wireName: r'code')
  RoleNotFoundErrorCodeEnum get code;
  // enum codeEnum {  role_not_found,  };

  RoleNotFoundError._();

  factory RoleNotFoundError([void updates(RoleNotFoundErrorBuilder b)]) =
      _$RoleNotFoundError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleNotFoundErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleNotFoundError> get serializer =>
      _$RoleNotFoundErrorSerializer();
}

class _$RoleNotFoundErrorSerializer
    implements PrimitiveSerializer<RoleNotFoundError> {
  @override
  final Iterable<Type> types = const [RoleNotFoundError, _$RoleNotFoundError];

  @override
  final String wireName = r'RoleNotFoundError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleNotFoundError object, {
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
      specifiedType: const FullType(RoleNotFoundErrorStatusEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(RoleNotFoundErrorCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleNotFoundError object, {
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
    required RoleNotFoundErrorBuilder result,
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
                    specifiedType: const FullType(RoleNotFoundErrorStatusEnum),
                  )
                  as RoleNotFoundErrorStatusEnum;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(RoleNotFoundErrorCodeEnum),
                  )
                  as RoleNotFoundErrorCodeEnum;
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
  RoleNotFoundError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleNotFoundErrorBuilder();
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

class RoleNotFoundErrorStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const RoleNotFoundErrorStatusEnum n404 =
      _$roleNotFoundErrorStatusEnum_n404;

  static Serializer<RoleNotFoundErrorStatusEnum> get serializer =>
      _$roleNotFoundErrorStatusEnumSerializer;

  const RoleNotFoundErrorStatusEnum._(String name) : super(name);

  static BuiltSet<RoleNotFoundErrorStatusEnum> get values =>
      _$roleNotFoundErrorStatusEnumValues;
  static RoleNotFoundErrorStatusEnum valueOf(String name) =>
      _$roleNotFoundErrorStatusEnumValueOf(name);
}

class RoleNotFoundErrorCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'role_not_found')
  static const RoleNotFoundErrorCodeEnum roleNotFound =
      _$roleNotFoundErrorCodeEnum_roleNotFound;

  static Serializer<RoleNotFoundErrorCodeEnum> get serializer =>
      _$roleNotFoundErrorCodeEnumSerializer;

  const RoleNotFoundErrorCodeEnum._(String name) : super(name);

  static BuiltSet<RoleNotFoundErrorCodeEnum> get values =>
      _$roleNotFoundErrorCodeEnumValues;
  static RoleNotFoundErrorCodeEnum valueOf(String name) =>
      _$roleNotFoundErrorCodeEnumValueOf(name);
}
