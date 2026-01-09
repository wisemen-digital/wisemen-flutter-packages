//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_user_roles_command.g.dart';

/// SetUserRolesCommand
///
/// Properties:
/// * [roleUuids]
@BuiltValue()
abstract class SetUserRolesCommand
    implements Built<SetUserRolesCommand, SetUserRolesCommandBuilder> {
  @BuiltValueField(wireName: r'roleUuids')
  BuiltList<String> get roleUuids;

  SetUserRolesCommand._();

  factory SetUserRolesCommand([void updates(SetUserRolesCommandBuilder b)]) =
      _$SetUserRolesCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetUserRolesCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetUserRolesCommand> get serializer =>
      _$SetUserRolesCommandSerializer();
}

class _$SetUserRolesCommandSerializer
    implements PrimitiveSerializer<SetUserRolesCommand> {
  @override
  final Iterable<Type> types = const [
    SetUserRolesCommand,
    _$SetUserRolesCommand,
  ];

  @override
  final String wireName = r'SetUserRolesCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetUserRolesCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roleUuids';
    yield serializers.serialize(
      object.roleUuids,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SetUserRolesCommand object, {
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
    required SetUserRolesCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roleUuids':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(String),
                    ]),
                  )
                  as BuiltList<String>;
          result.roleUuids.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SetUserRolesCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetUserRolesCommandBuilder();
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
