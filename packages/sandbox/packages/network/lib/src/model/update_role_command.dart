//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_role_command.g.dart';

/// UpdateRoleCommand
///
/// Properties:
/// * [name] - The name of the role
@BuiltValue()
abstract class UpdateRoleCommand
    implements Built<UpdateRoleCommand, UpdateRoleCommandBuilder> {
  /// The name of the role
  @BuiltValueField(wireName: r'name')
  String get name;

  UpdateRoleCommand._();

  factory UpdateRoleCommand([void updates(UpdateRoleCommandBuilder b)]) =
      _$UpdateRoleCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRoleCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRoleCommand> get serializer =>
      _$UpdateRoleCommandSerializer();
}

class _$UpdateRoleCommandSerializer
    implements PrimitiveSerializer<UpdateRoleCommand> {
  @override
  final Iterable<Type> types = const [UpdateRoleCommand, _$UpdateRoleCommand];

  @override
  final String wireName = r'UpdateRoleCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRoleCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateRoleCommand object, {
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
    required UpdateRoleCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  UpdateRoleCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRoleCommandBuilder();
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
