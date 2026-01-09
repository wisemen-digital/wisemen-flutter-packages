//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_index_role_view.g.dart';

/// UserIndexRoleView
///
/// Properties:
/// * [uuid]
/// * [name]
@BuiltValue()
abstract class UserIndexRoleView
    implements Built<UserIndexRoleView, UserIndexRoleViewBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'name')
  String get name;

  UserIndexRoleView._();

  factory UserIndexRoleView([void updates(UserIndexRoleViewBuilder b)]) =
      _$UserIndexRoleView;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserIndexRoleViewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserIndexRoleView> get serializer =>
      _$UserIndexRoleViewSerializer();
}

class _$UserIndexRoleViewSerializer
    implements PrimitiveSerializer<UserIndexRoleView> {
  @override
  final Iterable<Type> types = const [UserIndexRoleView, _$UserIndexRoleView];

  @override
  final String wireName = r'UserIndexRoleView';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserIndexRoleView object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserIndexRoleView object, {
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
    required UserIndexRoleViewBuilder result,
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
        case r'name':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserIndexRoleView deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserIndexRoleViewBuilder();
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
