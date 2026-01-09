//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_not_found_error.g.dart';

/// UserNotFoundError
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class UserNotFoundError
    implements Built<UserNotFoundError, UserNotFoundErrorBuilder> {
  /// a human-readable explanation specific to this occurrence of the problem
  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  UserNotFoundErrorStatusEnum get status;
  // enum statusEnum {  404,  };

  @BuiltValueField(wireName: r'code')
  UserNotFoundErrorCodeEnum get code;
  // enum codeEnum {  user_not_found,  };

  UserNotFoundError._();

  factory UserNotFoundError([void updates(UserNotFoundErrorBuilder b)]) =
      _$UserNotFoundError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserNotFoundErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserNotFoundError> get serializer =>
      _$UserNotFoundErrorSerializer();
}

class _$UserNotFoundErrorSerializer
    implements PrimitiveSerializer<UserNotFoundError> {
  @override
  final Iterable<Type> types = const [UserNotFoundError, _$UserNotFoundError];

  @override
  final String wireName = r'UserNotFoundError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserNotFoundError object, {
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
      specifiedType: const FullType(UserNotFoundErrorStatusEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(UserNotFoundErrorCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserNotFoundError object, {
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
    required UserNotFoundErrorBuilder result,
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
                    specifiedType: const FullType(UserNotFoundErrorStatusEnum),
                  )
                  as UserNotFoundErrorStatusEnum;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(UserNotFoundErrorCodeEnum),
                  )
                  as UserNotFoundErrorCodeEnum;
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
  UserNotFoundError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserNotFoundErrorBuilder();
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

class UserNotFoundErrorStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const UserNotFoundErrorStatusEnum n404 =
      _$userNotFoundErrorStatusEnum_n404;

  static Serializer<UserNotFoundErrorStatusEnum> get serializer =>
      _$userNotFoundErrorStatusEnumSerializer;

  const UserNotFoundErrorStatusEnum._(String name) : super(name);

  static BuiltSet<UserNotFoundErrorStatusEnum> get values =>
      _$userNotFoundErrorStatusEnumValues;
  static UserNotFoundErrorStatusEnum valueOf(String name) =>
      _$userNotFoundErrorStatusEnumValueOf(name);
}

class UserNotFoundErrorCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user_not_found')
  static const UserNotFoundErrorCodeEnum userNotFound =
      _$userNotFoundErrorCodeEnum_userNotFound;

  static Serializer<UserNotFoundErrorCodeEnum> get serializer =>
      _$userNotFoundErrorCodeEnumSerializer;

  const UserNotFoundErrorCodeEnum._(String name) : super(name);

  static BuiltSet<UserNotFoundErrorCodeEnum> get values =>
      _$userNotFoundErrorCodeEnumValues;
  static UserNotFoundErrorCodeEnum valueOf(String name) =>
      _$userNotFoundErrorCodeEnumValueOf(name);
}
