//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'migrate_notification_types_command.g.dart';

/// MigrateNotificationTypesCommand
///
/// Properties:
/// * [types]
@BuiltValue()
abstract class MigrateNotificationTypesCommand
    implements
        Built<
          MigrateNotificationTypesCommand,
          MigrateNotificationTypesCommandBuilder
        > {
  @BuiltValueField(wireName: r'types')
  BuiltList<NotificationType> get types;

  MigrateNotificationTypesCommand._();

  factory MigrateNotificationTypesCommand([
    void updates(MigrateNotificationTypesCommandBuilder b),
  ]) = _$MigrateNotificationTypesCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MigrateNotificationTypesCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MigrateNotificationTypesCommand> get serializer =>
      _$MigrateNotificationTypesCommandSerializer();
}

class _$MigrateNotificationTypesCommandSerializer
    implements PrimitiveSerializer<MigrateNotificationTypesCommand> {
  @override
  final Iterable<Type> types = const [
    MigrateNotificationTypesCommand,
    _$MigrateNotificationTypesCommand,
  ];

  @override
  final String wireName = r'MigrateNotificationTypesCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MigrateNotificationTypesCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'types';
    yield serializers.serialize(
      object.types,
      specifiedType: const FullType(BuiltList, [FullType(NotificationType)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MigrateNotificationTypesCommand object, {
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
    required MigrateNotificationTypesCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'types':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(NotificationType),
                    ]),
                  )
                  as BuiltList<NotificationType>;
          result.types.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MigrateNotificationTypesCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MigrateNotificationTypesCommandBuilder();
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
