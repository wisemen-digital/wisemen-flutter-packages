//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contact_created_event_content.g.dart';

/// ContactCreatedEventContent
///
/// Properties:
/// * [uuid]
@BuiltValue()
abstract class ContactCreatedEventContent
    implements
        Built<ContactCreatedEventContent, ContactCreatedEventContentBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  ContactCreatedEventContent._();

  factory ContactCreatedEventContent([
    void updates(ContactCreatedEventContentBuilder b),
  ]) = _$ContactCreatedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContactCreatedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContactCreatedEventContent> get serializer =>
      _$ContactCreatedEventContentSerializer();
}

class _$ContactCreatedEventContentSerializer
    implements PrimitiveSerializer<ContactCreatedEventContent> {
  @override
  final Iterable<Type> types = const [
    ContactCreatedEventContent,
    _$ContactCreatedEventContent,
  ];

  @override
  final String wireName = r'ContactCreatedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContactCreatedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ContactCreatedEventContent object, {
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
    required ContactCreatedEventContentBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContactCreatedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContactCreatedEventContentBuilder();
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
