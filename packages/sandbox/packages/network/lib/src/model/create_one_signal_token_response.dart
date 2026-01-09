//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_one_signal_token_response.g.dart';

/// CreateOneSignalTokenResponse
///
/// Properties:
/// * [token]
/// * [userUuid]
@BuiltValue()
abstract class CreateOneSignalTokenResponse
    implements
        Built<
          CreateOneSignalTokenResponse,
          CreateOneSignalTokenResponseBuilder
        > {
  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'userUuid')
  String get userUuid;

  CreateOneSignalTokenResponse._();

  factory CreateOneSignalTokenResponse([
    void updates(CreateOneSignalTokenResponseBuilder b),
  ]) = _$CreateOneSignalTokenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateOneSignalTokenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateOneSignalTokenResponse> get serializer =>
      _$CreateOneSignalTokenResponseSerializer();
}

class _$CreateOneSignalTokenResponseSerializer
    implements PrimitiveSerializer<CreateOneSignalTokenResponse> {
  @override
  final Iterable<Type> types = const [
    CreateOneSignalTokenResponse,
    _$CreateOneSignalTokenResponse,
  ];

  @override
  final String wireName = r'CreateOneSignalTokenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateOneSignalTokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'userUuid';
    yield serializers.serialize(
      object.userUuid,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateOneSignalTokenResponse object, {
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
    required CreateOneSignalTokenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.token = valueDes;
          break;
        case r'userUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.userUuid = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateOneSignalTokenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateOneSignalTokenResponseBuilder();
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
