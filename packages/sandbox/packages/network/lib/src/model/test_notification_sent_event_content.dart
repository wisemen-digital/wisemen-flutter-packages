//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'test_notification_sent_event_content.g.dart';

/// TestNotificationSentEventContent
///
/// Properties:
/// * [message]
@BuiltValue()
abstract class TestNotificationSentEventContent
    implements
        Built<
          TestNotificationSentEventContent,
          TestNotificationSentEventContentBuilder
        > {
  @BuiltValueField(wireName: r'message')
  String get message;

  TestNotificationSentEventContent._();

  factory TestNotificationSentEventContent([
    void updates(TestNotificationSentEventContentBuilder b),
  ]) = _$TestNotificationSentEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TestNotificationSentEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TestNotificationSentEventContent> get serializer =>
      _$TestNotificationSentEventContentSerializer();
}

class _$TestNotificationSentEventContentSerializer
    implements PrimitiveSerializer<TestNotificationSentEventContent> {
  @override
  final Iterable<Type> types = const [
    TestNotificationSentEventContent,
    _$TestNotificationSentEventContent,
  ];

  @override
  final String wireName = r'TestNotificationSentEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TestNotificationSentEventContent object, {
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
    TestNotificationSentEventContent object, {
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
    required TestNotificationSentEventContentBuilder result,
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
  TestNotificationSentEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TestNotificationSentEventContentBuilder();
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
