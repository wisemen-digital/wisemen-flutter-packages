//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/monetary_dto.dart';
import 'package:openapi/src/model/address_command.dart';
import 'package:openapi/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_contact_command.g.dart';

/// UpdateContactCommand
///
/// Properties:
/// * [firstName]
/// * [lastName]
/// * [email]
/// * [phone]
/// * [isActive]
/// * [address]
/// * [fileUuid]
/// * [avatarUuid]
/// * [discount]
/// * [balance]
/// * [birthDate]
@BuiltValue()
abstract class UpdateContactCommand
    implements Built<UpdateContactCommand, UpdateContactCommandBuilder> {
  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'isActive')
  bool get isActive;

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

  UpdateContactCommand._();

  factory UpdateContactCommand([void updates(UpdateContactCommandBuilder b)]) =
      _$UpdateContactCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateContactCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateContactCommand> get serializer =>
      _$UpdateContactCommandSerializer();
}

class _$UpdateContactCommandSerializer
    implements PrimitiveSerializer<UpdateContactCommand> {
  @override
  final Iterable<Type> types = const [
    UpdateContactCommand,
    _$UpdateContactCommand,
  ];

  @override
  final String wireName = r'UpdateContactCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateContactCommand object, {
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
    yield r'isActive';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
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
    UpdateContactCommand object, {
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
    required UpdateContactCommandBuilder result,
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
        case r'isActive':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.isActive = valueDes;
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
  UpdateContactCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateContactCommandBuilder();
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
