//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/monetary_dto.dart';
import 'package:openapi/src/model/address_command.dart';
import 'package:openapi/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_contact_command.g.dart';

/// CreateContactCommand
///
/// Properties:
/// * [firstName]
/// * [lastName]
/// * [email]
/// * [phone]
/// * [address]
/// * [fileUuid]
/// * [avatarUuid]
/// * [discount]
/// * [balance]
/// * [birthDate]
@BuiltValue()
abstract class CreateContactCommand
    implements Built<CreateContactCommand, CreateContactCommandBuilder> {
  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'address')
  AddressCommand? get address;

  @BuiltValueField(wireName: r'fileUuid')
  String? get fileUuid;

  @BuiltValueField(wireName: r'avatarUuid')
  String? get avatarUuid;

  @BuiltValueField(wireName: r'discount')
  MonetaryDto? get discount;

  @BuiltValueField(wireName: r'balance')
  MonetaryDto? get balance;

  @BuiltValueField(wireName: r'birthDate')
  Date get birthDate;

  CreateContactCommand._();

  factory CreateContactCommand([void updates(CreateContactCommandBuilder b)]) =
      _$CreateContactCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateContactCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateContactCommand> get serializer =>
      _$CreateContactCommandSerializer();
}

class _$CreateContactCommandSerializer
    implements PrimitiveSerializer<CreateContactCommand> {
  @override
  final Iterable<Type> types = const [
    CreateContactCommand,
    _$CreateContactCommand,
  ];

  @override
  final String wireName = r'CreateContactCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateContactCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'firstName';
    yield object.firstName == null
        ? null
        : serializers.serialize(
            object.firstName,
            specifiedType: const FullType.nullable(String),
          );
    yield r'lastName';
    yield object.lastName == null
        ? null
        : serializers.serialize(
            object.lastName,
            specifiedType: const FullType.nullable(String),
          );
    yield r'email';
    yield object.email == null
        ? null
        : serializers.serialize(
            object.email,
            specifiedType: const FullType.nullable(String),
          );
    yield r'phone';
    yield object.phone == null
        ? null
        : serializers.serialize(
            object.phone,
            specifiedType: const FullType.nullable(String),
          );
    yield r'address';
    yield object.address == null
        ? null
        : serializers.serialize(
            object.address,
            specifiedType: const FullType.nullable(AddressCommand),
          );
    yield r'fileUuid';
    yield object.fileUuid == null
        ? null
        : serializers.serialize(
            object.fileUuid,
            specifiedType: const FullType.nullable(String),
          );
    yield r'avatarUuid';
    yield object.avatarUuid == null
        ? null
        : serializers.serialize(
            object.avatarUuid,
            specifiedType: const FullType.nullable(String),
          );
    yield r'discount';
    yield object.discount == null
        ? null
        : serializers.serialize(
            object.discount,
            specifiedType: const FullType.nullable(MonetaryDto),
          );
    yield r'balance';
    yield object.balance == null
        ? null
        : serializers.serialize(
            object.balance,
            specifiedType: const FullType.nullable(MonetaryDto),
          );
    yield r'birthDate';
    yield serializers.serialize(
      object.birthDate,
      specifiedType: const FullType(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateContactCommand object, {
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
    required CreateContactCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'firstName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.lastName = valueDes;
          break;
        case r'email':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'phone':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.phone = valueDes;
          break;
        case r'address':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(AddressCommand),
                  )
                  as AddressCommand?;
          if (valueDes == null) continue;
          result.address.replace(valueDes);
          break;
        case r'fileUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.fileUuid = valueDes;
          break;
        case r'avatarUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.avatarUuid = valueDes;
          break;
        case r'discount':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(MonetaryDto),
                  )
                  as MonetaryDto?;
          if (valueDes == null) continue;
          result.discount.replace(valueDes);
          break;
        case r'balance':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(MonetaryDto),
                  )
                  as MonetaryDto?;
          if (valueDes == null) continue;
          result.balance.replace(valueDes);
          break;
        case r'birthDate':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(Date),
                  )
                  as Date;
          result.birthDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateContactCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateContactCommandBuilder();
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
