//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_created_event_content.g.dart';

/// UserCreatedEventContent
///
/// Properties:
/// * [userUuid]
@BuiltValue()
abstract class UserCreatedEventContent
    implements Built<UserCreatedEventContent, UserCreatedEventContentBuilder> {
  @BuiltValueField(wireName: r'userUuid')
  String get userUuid;

  UserCreatedEventContent._();

  factory UserCreatedEventContent([
    void updates(UserCreatedEventContentBuilder b),
  ]) = _$UserCreatedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserCreatedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserCreatedEventContent> get serializer =>
      _$UserCreatedEventContentSerializer();
}

class _$UserCreatedEventContentSerializer
    implements PrimitiveSerializer<UserCreatedEventContent> {
  @override
  final Iterable<Type> types = const [
    UserCreatedEventContent,
    _$UserCreatedEventContent,
  ];

  @override
  final String wireName = r'UserCreatedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserCreatedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userUuid';
    yield serializers.serialize(
      object.userUuid,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserCreatedEventContent object, {
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
    required UserCreatedEventContentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  UserCreatedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserCreatedEventContentBuilder();
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
