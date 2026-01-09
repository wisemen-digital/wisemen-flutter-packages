//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'test_notification_content.g.dart';

/// TestNotificationContent
///
/// Properties:
/// * [message]
@BuiltValue()
abstract class TestNotificationContent
    implements Built<TestNotificationContent, TestNotificationContentBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  TestNotificationContent._();

  factory TestNotificationContent([
    void updates(TestNotificationContentBuilder b),
  ]) = _$TestNotificationContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TestNotificationContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TestNotificationContent> get serializer =>
      _$TestNotificationContentSerializer();
}

class _$TestNotificationContentSerializer
    implements PrimitiveSerializer<TestNotificationContent> {
  @override
  final Iterable<Type> types = const [
    TestNotificationContent,
    _$TestNotificationContent,
  ];

  @override
  final String wireName = r'TestNotificationContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TestNotificationContent object, {
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
    TestNotificationContent object, {
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
    required TestNotificationContentBuilder result,
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
  TestNotificationContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TestNotificationContentBuilder();
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
