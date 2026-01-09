//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'all_notifications_marked_as_read_event_content.g.dart';

/// AllNotificationsMarkedAsReadEventContent
///
/// Properties:
/// * [userUuid]
@BuiltValue()
abstract class AllNotificationsMarkedAsReadEventContent
    implements
        Built<
          AllNotificationsMarkedAsReadEventContent,
          AllNotificationsMarkedAsReadEventContentBuilder
        > {
  @BuiltValueField(wireName: r'userUuid')
  String get userUuid;

  AllNotificationsMarkedAsReadEventContent._();

  factory AllNotificationsMarkedAsReadEventContent([
    void updates(AllNotificationsMarkedAsReadEventContentBuilder b),
  ]) = _$AllNotificationsMarkedAsReadEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AllNotificationsMarkedAsReadEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AllNotificationsMarkedAsReadEventContent> get serializer =>
      _$AllNotificationsMarkedAsReadEventContentSerializer();
}

class _$AllNotificationsMarkedAsReadEventContentSerializer
    implements PrimitiveSerializer<AllNotificationsMarkedAsReadEventContent> {
  @override
  final Iterable<Type> types = const [
    AllNotificationsMarkedAsReadEventContent,
    _$AllNotificationsMarkedAsReadEventContent,
  ];

  @override
  final String wireName = r'AllNotificationsMarkedAsReadEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AllNotificationsMarkedAsReadEventContent object, {
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
    AllNotificationsMarkedAsReadEventContent object, {
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
    required AllNotificationsMarkedAsReadEventContentBuilder result,
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
  AllNotificationsMarkedAsReadEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AllNotificationsMarkedAsReadEventContentBuilder();
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
