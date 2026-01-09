//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_renamed_event_content.g.dart';

/// RoleRenamedEventContent
///
/// Properties:
/// * [roleUuid]
/// * [previousName]
/// * [newName]
@BuiltValue()
abstract class RoleRenamedEventContent
    implements Built<RoleRenamedEventContent, RoleRenamedEventContentBuilder> {
  @BuiltValueField(wireName: r'roleUuid')
  String get roleUuid;

  @BuiltValueField(wireName: r'previousName')
  String get previousName;

  @BuiltValueField(wireName: r'newName')
  String get newName;

  RoleRenamedEventContent._();

  factory RoleRenamedEventContent([
    void updates(RoleRenamedEventContentBuilder b),
  ]) = _$RoleRenamedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleRenamedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleRenamedEventContent> get serializer =>
      _$RoleRenamedEventContentSerializer();
}

class _$RoleRenamedEventContentSerializer
    implements PrimitiveSerializer<RoleRenamedEventContent> {
  @override
  final Iterable<Type> types = const [
    RoleRenamedEventContent,
    _$RoleRenamedEventContent,
  ];

  @override
  final String wireName = r'RoleRenamedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleRenamedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roleUuid';
    yield serializers.serialize(
      object.roleUuid,
      specifiedType: const FullType(String),
    );
    yield r'previousName';
    yield serializers.serialize(
      object.previousName,
      specifiedType: const FullType(String),
    );
    yield r'newName';
    yield serializers.serialize(
      object.newName,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleRenamedEventContent object, {
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
    required RoleRenamedEventContentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roleUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.roleUuid = valueDes;
          break;
        case r'previousName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.previousName = valueDes;
          break;
        case r'newName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.newName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleRenamedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleRenamedEventContentBuilder();
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
