//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_test_notification_command.g.dart';

/// SendTestNotificationCommand
///
/// Properties:
/// * [message]
@BuiltValue()
abstract class SendTestNotificationCommand
    implements
        Built<SendTestNotificationCommand, SendTestNotificationCommandBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  SendTestNotificationCommand._();

  factory SendTestNotificationCommand([
    void updates(SendTestNotificationCommandBuilder b),
  ]) = _$SendTestNotificationCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendTestNotificationCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendTestNotificationCommand> get serializer =>
      _$SendTestNotificationCommandSerializer();
}

class _$SendTestNotificationCommandSerializer
    implements PrimitiveSerializer<SendTestNotificationCommand> {
  @override
  final Iterable<Type> types = const [
    SendTestNotificationCommand,
    _$SendTestNotificationCommand,
  ];

  @override
  final String wireName = r'SendTestNotificationCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendTestNotificationCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SendTestNotificationCommand object, {
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
    required SendTestNotificationCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendTestNotificationCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendTestNotificationCommandBuilder();
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
