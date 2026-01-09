//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_types_migrated_event_content.g.dart';

/// NotificationTypesMigratedEventContent
///
/// Properties:
/// * [types]
@BuiltValue()
abstract class NotificationTypesMigratedEventContent
    implements
        Built<
          NotificationTypesMigratedEventContent,
          NotificationTypesMigratedEventContentBuilder
        > {
  @BuiltValueField(wireName: r'types')
  BuiltList<NotificationType> get types;

  NotificationTypesMigratedEventContent._();

  factory NotificationTypesMigratedEventContent([
    void updates(NotificationTypesMigratedEventContentBuilder b),
  ]) = _$NotificationTypesMigratedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationTypesMigratedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationTypesMigratedEventContent> get serializer =>
      _$NotificationTypesMigratedEventContentSerializer();
}

class _$NotificationTypesMigratedEventContentSerializer
    implements PrimitiveSerializer<NotificationTypesMigratedEventContent> {
  @override
  final Iterable<Type> types = const [
    NotificationTypesMigratedEventContent,
    _$NotificationTypesMigratedEventContent,
  ];

  @override
  final String wireName = r'NotificationTypesMigratedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationTypesMigratedEventContent object, {
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
    NotificationTypesMigratedEventContent object, {
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
    required NotificationTypesMigratedEventContentBuilder result,
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
  NotificationTypesMigratedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationTypesMigratedEventContentBuilder();
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
