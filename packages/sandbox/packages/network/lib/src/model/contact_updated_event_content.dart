//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contact_updated_event_content.g.dart';

/// ContactUpdatedEventContent
///
/// Properties:
/// * [uuid]
@BuiltValue()
abstract class ContactUpdatedEventContent
    implements
        Built<ContactUpdatedEventContent, ContactUpdatedEventContentBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  ContactUpdatedEventContent._();

  factory ContactUpdatedEventContent([
    void updates(ContactUpdatedEventContentBuilder b),
  ]) = _$ContactUpdatedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContactUpdatedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContactUpdatedEventContent> get serializer =>
      _$ContactUpdatedEventContentSerializer();
}

class _$ContactUpdatedEventContentSerializer
    implements PrimitiveSerializer<ContactUpdatedEventContent> {
  @override
  final Iterable<Type> types = const [
    ContactUpdatedEventContent,
    _$ContactUpdatedEventContent,
  ];

  @override
  final String wireName = r'ContactUpdatedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContactUpdatedEventContent object, {
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
    ContactUpdatedEventContent object, {
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
    required ContactUpdatedEventContentBuilder result,
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
  ContactUpdatedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContactUpdatedEventContentBuilder();
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
