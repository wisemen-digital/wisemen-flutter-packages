//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/translations.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_push_notification_command.g.dart';

/// SendPushNotificationCommand
///
/// Properties:
/// * [name]
/// * [title]
/// * [description]
/// * [userUuids]
@BuiltValue()
abstract class SendPushNotificationCommand
    implements
        Built<SendPushNotificationCommand, SendPushNotificationCommandBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'title')
  Translations get title;

  @BuiltValueField(wireName: r'description')
  Translations get description;

  @BuiltValueField(wireName: r'userUuids')
  BuiltList<String> get userUuids;

  SendPushNotificationCommand._();

  factory SendPushNotificationCommand([
    void updates(SendPushNotificationCommandBuilder b),
  ]) = _$SendPushNotificationCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendPushNotificationCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendPushNotificationCommand> get serializer =>
      _$SendPushNotificationCommandSerializer();
}

class _$SendPushNotificationCommandSerializer
    implements PrimitiveSerializer<SendPushNotificationCommand> {
  @override
  final Iterable<Type> types = const [
    SendPushNotificationCommand,
    _$SendPushNotificationCommand,
  ];

  @override
  final String wireName = r'SendPushNotificationCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendPushNotificationCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(Translations),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(Translations),
    );
    yield r'userUuids';
    yield serializers.serialize(
      object.userUuids,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SendPushNotificationCommand object, {
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
    required SendPushNotificationCommandBuilder result,
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
        case r'title':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(Translations),
                  )
                  as Translations;
          result.title.replace(valueDes);
          break;
        case r'description':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(Translations),
                  )
                  as Translations;
          result.description.replace(valueDes);
          break;
        case r'userUuids':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(String),
                    ]),
                  )
                  as BuiltList<String>;
          result.userUuids.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendPushNotificationCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendPushNotificationCommandBuilder();
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
