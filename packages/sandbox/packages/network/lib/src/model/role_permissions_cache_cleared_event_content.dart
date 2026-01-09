//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_permissions_cache_cleared_event_content.g.dart';

/// RolePermissionsCacheClearedEventContent
///
/// Properties:
/// * [roleUuids]
@BuiltValue()
abstract class RolePermissionsCacheClearedEventContent
    implements
        Built<
          RolePermissionsCacheClearedEventContent,
          RolePermissionsCacheClearedEventContentBuilder
        > {
  @BuiltValueField(wireName: r'roleUuids')
  String get roleUuids;

  RolePermissionsCacheClearedEventContent._();

  factory RolePermissionsCacheClearedEventContent([
    void updates(RolePermissionsCacheClearedEventContentBuilder b),
  ]) = _$RolePermissionsCacheClearedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RolePermissionsCacheClearedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RolePermissionsCacheClearedEventContent> get serializer =>
      _$RolePermissionsCacheClearedEventContentSerializer();
}

class _$RolePermissionsCacheClearedEventContentSerializer
    implements PrimitiveSerializer<RolePermissionsCacheClearedEventContent> {
  @override
  final Iterable<Type> types = const [
    RolePermissionsCacheClearedEventContent,
    _$RolePermissionsCacheClearedEventContent,
  ];

  @override
  final String wireName = r'RolePermissionsCacheClearedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RolePermissionsCacheClearedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roleUuids';
    yield serializers.serialize(
      object.roleUuids,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RolePermissionsCacheClearedEventContent object, {
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
    required RolePermissionsCacheClearedEventContentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roleUuids':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.roleUuids = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RolePermissionsCacheClearedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RolePermissionsCacheClearedEventContentBuilder();
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
