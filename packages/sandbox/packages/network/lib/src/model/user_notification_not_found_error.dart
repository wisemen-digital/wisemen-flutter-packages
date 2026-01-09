//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_notification_not_found_error.g.dart';

/// UserNotificationNotFoundError
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class UserNotificationNotFoundError
    implements
        Built<
          UserNotificationNotFoundError,
          UserNotificationNotFoundErrorBuilder
        > {
  /// a human-readable explanation specific to this occurrence of the problem
  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  UserNotificationNotFoundErrorStatusEnum get status;
  // enum statusEnum {  404,  };

  @BuiltValueField(wireName: r'code')
  UserNotificationNotFoundErrorCodeEnum get code;
  // enum codeEnum {  user_notification_not_found,  };

  UserNotificationNotFoundError._();

  factory UserNotificationNotFoundError([
    void updates(UserNotificationNotFoundErrorBuilder b),
  ]) = _$UserNotificationNotFoundError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserNotificationNotFoundErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserNotificationNotFoundError> get serializer =>
      _$UserNotificationNotFoundErrorSerializer();
}

class _$UserNotificationNotFoundErrorSerializer
    implements PrimitiveSerializer<UserNotificationNotFoundError> {
  @override
  final Iterable<Type> types = const [
    UserNotificationNotFoundError,
    _$UserNotificationNotFoundError,
  ];

  @override
  final String wireName = r'UserNotificationNotFoundError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserNotificationNotFoundError object, {
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
      specifiedType: const FullType(UserNotificationNotFoundErrorStatusEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(UserNotificationNotFoundErrorCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserNotificationNotFoundError object, {
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
    required UserNotificationNotFoundErrorBuilder result,
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
                      UserNotificationNotFoundErrorStatusEnum,
                    ),
                  )
                  as UserNotificationNotFoundErrorStatusEnum;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      UserNotificationNotFoundErrorCodeEnum,
                    ),
                  )
                  as UserNotificationNotFoundErrorCodeEnum;
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
  UserNotificationNotFoundError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserNotificationNotFoundErrorBuilder();
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

class UserNotificationNotFoundErrorStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const UserNotificationNotFoundErrorStatusEnum n404 =
      _$userNotificationNotFoundErrorStatusEnum_n404;

  static Serializer<UserNotificationNotFoundErrorStatusEnum> get serializer =>
      _$userNotificationNotFoundErrorStatusEnumSerializer;

  const UserNotificationNotFoundErrorStatusEnum._(String name) : super(name);

  static BuiltSet<UserNotificationNotFoundErrorStatusEnum> get values =>
      _$userNotificationNotFoundErrorStatusEnumValues;
  static UserNotificationNotFoundErrorStatusEnum valueOf(String name) =>
      _$userNotificationNotFoundErrorStatusEnumValueOf(name);
}

class UserNotificationNotFoundErrorCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user_notification_not_found')
  static const UserNotificationNotFoundErrorCodeEnum userNotificationNotFound =
      _$userNotificationNotFoundErrorCodeEnum_userNotificationNotFound;

  static Serializer<UserNotificationNotFoundErrorCodeEnum> get serializer =>
      _$userNotificationNotFoundErrorCodeEnumSerializer;

  const UserNotificationNotFoundErrorCodeEnum._(String name) : super(name);

  static BuiltSet<UserNotificationNotFoundErrorCodeEnum> get values =>
      _$userNotificationNotFoundErrorCodeEnumValues;
  static UserNotificationNotFoundErrorCodeEnum valueOf(String name) =>
      _$userNotificationNotFoundErrorCodeEnumValueOf(name);
}
