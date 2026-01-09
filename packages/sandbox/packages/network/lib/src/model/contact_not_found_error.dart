//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contact_not_found_error.g.dart';

/// ContactNotFoundError
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class ContactNotFoundError
    implements Built<ContactNotFoundError, ContactNotFoundErrorBuilder> {
  /// a human-readable explanation specific to this occurrence of the problem
  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  ContactNotFoundErrorStatusEnum get status;
  // enum statusEnum {  404,  };

  @BuiltValueField(wireName: r'code')
  ContactNotFoundErrorCodeEnum get code;
  // enum codeEnum {  contact_not_found,  };

  ContactNotFoundError._();

  factory ContactNotFoundError([void updates(ContactNotFoundErrorBuilder b)]) =
      _$ContactNotFoundError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContactNotFoundErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContactNotFoundError> get serializer =>
      _$ContactNotFoundErrorSerializer();
}

class _$ContactNotFoundErrorSerializer
    implements PrimitiveSerializer<ContactNotFoundError> {
  @override
  final Iterable<Type> types = const [
    ContactNotFoundError,
    _$ContactNotFoundError,
  ];

  @override
  final String wireName = r'ContactNotFoundError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContactNotFoundError object, {
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
      specifiedType: const FullType(ContactNotFoundErrorStatusEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(ContactNotFoundErrorCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ContactNotFoundError object, {
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
    required ContactNotFoundErrorBuilder result,
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
                      ContactNotFoundErrorStatusEnum,
                    ),
                  )
                  as ContactNotFoundErrorStatusEnum;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(ContactNotFoundErrorCodeEnum),
                  )
                  as ContactNotFoundErrorCodeEnum;
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
  ContactNotFoundError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContactNotFoundErrorBuilder();
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

class ContactNotFoundErrorStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const ContactNotFoundErrorStatusEnum n404 =
      _$contactNotFoundErrorStatusEnum_n404;

  static Serializer<ContactNotFoundErrorStatusEnum> get serializer =>
      _$contactNotFoundErrorStatusEnumSerializer;

  const ContactNotFoundErrorStatusEnum._(String name) : super(name);

  static BuiltSet<ContactNotFoundErrorStatusEnum> get values =>
      _$contactNotFoundErrorStatusEnumValues;
  static ContactNotFoundErrorStatusEnum valueOf(String name) =>
      _$contactNotFoundErrorStatusEnumValueOf(name);
}

class ContactNotFoundErrorCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'contact_not_found')
  static const ContactNotFoundErrorCodeEnum contactNotFound =
      _$contactNotFoundErrorCodeEnum_contactNotFound;

  static Serializer<ContactNotFoundErrorCodeEnum> get serializer =>
      _$contactNotFoundErrorCodeEnumSerializer;

  const ContactNotFoundErrorCodeEnum._(String name) : super(name);

  static BuiltSet<ContactNotFoundErrorCodeEnum> get values =>
      _$contactNotFoundErrorCodeEnumValues;
  static ContactNotFoundErrorCodeEnum valueOf(String name) =>
      _$contactNotFoundErrorCodeEnumValueOf(name);
}
