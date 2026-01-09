//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/view_role_detail_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_user_detail_response.g.dart';

/// ViewUserDetailResponse
///
/// Properties:
/// * [uuid]
/// * [email]
/// * [firstName]
/// * [lastName]
/// * [roles]
@BuiltValue()
abstract class ViewUserDetailResponse
    implements Built<ViewUserDetailResponse, ViewUserDetailResponseBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'roles')
  BuiltList<ViewRoleDetailResponse> get roles;

  ViewUserDetailResponse._();

  factory ViewUserDetailResponse([
    void updates(ViewUserDetailResponseBuilder b),
  ]) = _$ViewUserDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewUserDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewUserDetailResponse> get serializer =>
      _$ViewUserDetailResponseSerializer();
}

class _$ViewUserDetailResponseSerializer
    implements PrimitiveSerializer<ViewUserDetailResponse> {
  @override
  final Iterable<Type> types = const [
    ViewUserDetailResponse,
    _$ViewUserDetailResponse,
  ];

  @override
  final String wireName = r'ViewUserDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewUserDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
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
    yield r'roles';
    yield serializers.serialize(
      object.roles,
      specifiedType: const FullType(BuiltList, [
        FullType(ViewRoleDetailResponse),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewUserDetailResponse object, {
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
    required ViewUserDetailResponseBuilder result,
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
        case r'email':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.email = valueDes;
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
        case r'roles':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(ViewRoleDetailResponse),
                    ]),
                  )
                  as BuiltList<ViewRoleDetailResponse>;
          result.roles.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewUserDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewUserDetailResponseBuilder();
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
