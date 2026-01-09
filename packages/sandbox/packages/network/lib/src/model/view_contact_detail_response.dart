//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/presigned_file_response.dart';
import 'package:openapi/src/model/monetary_dto.dart';
import 'package:openapi/src/model/address_response.dart';
import 'package:openapi/src/model/date.dart';
import 'package:openapi/src/model/file_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_contact_detail_response.g.dart';

/// ViewContactDetailResponse
///
/// Properties:
/// * [uuid]
/// * [createdAt]
/// * [updatedAt]
/// * [isActive]
/// * [firstName]
/// * [lastName]
/// * [email]
/// * [phone]
/// * [address]
/// * [file]
/// * [avatar]
/// * [discount]
/// * [balance]
/// * [birthDate]
@BuiltValue()
abstract class ViewContactDetailResponse
    implements
        Built<ViewContactDetailResponse, ViewContactDetailResponseBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime get updatedAt;

  @BuiltValueField(wireName: r'isActive')
  bool get isActive;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'address')
  AddressResponse? get address;

  @BuiltValueField(wireName: r'file')
  FileResponse? get file;

  @BuiltValueField(wireName: r'avatar')
  PresignedFileResponse? get avatar;

  @BuiltValueField(wireName: r'discount')
  MonetaryDto? get discount;

  @BuiltValueField(wireName: r'balance')
  MonetaryDto? get balance;

  @BuiltValueField(wireName: r'birthDate')
  Date? get birthDate;

  ViewContactDetailResponse._();

  factory ViewContactDetailResponse([
    void updates(ViewContactDetailResponseBuilder b),
  ]) = _$ViewContactDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewContactDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewContactDetailResponse> get serializer =>
      _$ViewContactDetailResponseSerializer();
}

class _$ViewContactDetailResponseSerializer
    implements PrimitiveSerializer<ViewContactDetailResponse> {
  @override
  final Iterable<Type> types = const [
    ViewContactDetailResponse,
    _$ViewContactDetailResponse,
  ];

  @override
  final String wireName = r'ViewContactDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewContactDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'isActive';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
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
            specifiedType: const FullType.nullable(AddressResponse),
          );
    yield r'file';
    yield object.file == null
        ? null
        : serializers.serialize(
            object.file,
            specifiedType: const FullType.nullable(FileResponse),
          );
    yield r'avatar';
    yield object.avatar == null
        ? null
        : serializers.serialize(
            object.avatar,
            specifiedType: const FullType.nullable(PresignedFileResponse),
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
    yield object.birthDate == null
        ? null
        : serializers.serialize(
            object.birthDate,
            specifiedType: const FullType.nullable(Date),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewContactDetailResponse object, {
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
    required ViewContactDetailResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'uuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.uuid = valueDes;
          break;
        case r'createdAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.updatedAt = valueDes;
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
                    specifiedType: const FullType.nullable(AddressResponse),
                  )
                  as AddressResponse?;
          if (valueDes == null) continue;
          result.address.replace(valueDes);
          break;
        case r'file':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(FileResponse),
                  )
                  as FileResponse?;
          if (valueDes == null) continue;
          result.file.replace(valueDes);
          break;
        case r'avatar':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(
                      PresignedFileResponse,
                    ),
                  )
                  as PresignedFileResponse?;
          if (valueDes == null) continue;
          result.avatar.replace(valueDes);
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
                    specifiedType: const FullType.nullable(Date),
                  )
                  as Date?;
          if (valueDes == null) continue;
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
  ViewContactDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewContactDetailResponseBuilder();
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
