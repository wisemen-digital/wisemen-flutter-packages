//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contact_deleted_event_content.g.dart';

/// ContactDeletedEventContent
///
/// Properties:
/// * [uuid]
@BuiltValue()
abstract class ContactDeletedEventContent
    implements
        Built<ContactDeletedEventContent, ContactDeletedEventContentBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  ContactDeletedEventContent._();

  factory ContactDeletedEventContent([
    void updates(ContactDeletedEventContentBuilder b),
  ]) = _$ContactDeletedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContactDeletedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContactDeletedEventContent> get serializer =>
      _$ContactDeletedEventContentSerializer();
}

class _$ContactDeletedEventContentSerializer
    implements PrimitiveSerializer<ContactDeletedEventContent> {
  @override
  final Iterable<Type> types = const [
    ContactDeletedEventContent,
    _$ContactDeletedEventContent,
  ];

  @override
  final String wireName = r'ContactDeletedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContactDeletedEventContent object, {
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
    ContactDeletedEventContent object, {
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
    required ContactDeletedEventContentBuilder result,
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
  ContactDeletedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContactDeletedEventContentBuilder();
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
