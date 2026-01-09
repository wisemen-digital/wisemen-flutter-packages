//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/permission.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_permission_index_permission_response.g.dart';

/// ViewPermissionIndexPermissionResponse
///
/// Properties:
/// * [name]
/// * [key]
/// * [description]
@BuiltValue()
abstract class ViewPermissionIndexPermissionResponse
    implements
        Built<
          ViewPermissionIndexPermissionResponse,
          ViewPermissionIndexPermissionResponseBuilder
        > {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'key')
  Permission get key;
  // enum keyEnum {  all_permissions,  contact.create,  contact.read,  contact.update,  contact.delete,  event-log.read,  file.read,  file.create,  jobs.read.index,  jobs.read.detail,  notification.read.own,  notification.read.config,  notification.update.read,  notification.update.unread,  notification.preferences.update.channel,  notification.preferences.update.preset,  notification.preferences.update.types,  notification.preferences.read.own,  notification.migrate-type,  notification.send-test,  role.read,  role.create,  role.update,  role.delete,  role.cache.clear,  send_push_notification,  typesense,  user.read,  user.create,  user.update,  user.delete,  };

  @BuiltValueField(wireName: r'description')
  String get description;

  ViewPermissionIndexPermissionResponse._();

  factory ViewPermissionIndexPermissionResponse([
    void updates(ViewPermissionIndexPermissionResponseBuilder b),
  ]) = _$ViewPermissionIndexPermissionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewPermissionIndexPermissionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewPermissionIndexPermissionResponse> get serializer =>
      _$ViewPermissionIndexPermissionResponseSerializer();
}

class _$ViewPermissionIndexPermissionResponseSerializer
    implements PrimitiveSerializer<ViewPermissionIndexPermissionResponse> {
  @override
  final Iterable<Type> types = const [
    ViewPermissionIndexPermissionResponse,
    _$ViewPermissionIndexPermissionResponse,
  ];

  @override
  final String wireName = r'ViewPermissionIndexPermissionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewPermissionIndexPermissionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'key';
    yield serializers.serialize(
      object.key,
      specifiedType: const FullType(Permission),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewPermissionIndexPermissionResponse object, {
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
    required ViewPermissionIndexPermissionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.name = valueDes;
          break;
        case r'key':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(Permission),
                  )
                  as Permission;
          result.key = valueDes;
          break;
        case r'description':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewPermissionIndexPermissionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewPermissionIndexPermissionResponseBuilder();
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
