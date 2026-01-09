//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/view_notification_type_config_type_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_notification_types_config_group_response.g.dart';

/// ViewNotificationTypesConfigGroupResponse
///
/// Properties:
/// * [name]
/// * [description]
/// * [types]
@BuiltValue()
abstract class ViewNotificationTypesConfigGroupResponse
    implements
        Built<
          ViewNotificationTypesConfigGroupResponse,
          ViewNotificationTypesConfigGroupResponseBuilder
        > {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'types')
  BuiltList<ViewNotificationTypeConfigTypeResponse> get types;

  ViewNotificationTypesConfigGroupResponse._();

  factory ViewNotificationTypesConfigGroupResponse([
    void updates(ViewNotificationTypesConfigGroupResponseBuilder b),
  ]) = _$ViewNotificationTypesConfigGroupResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewNotificationTypesConfigGroupResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewNotificationTypesConfigGroupResponse> get serializer =>
      _$ViewNotificationTypesConfigGroupResponseSerializer();
}

class _$ViewNotificationTypesConfigGroupResponseSerializer
    implements PrimitiveSerializer<ViewNotificationTypesConfigGroupResponse> {
  @override
  final Iterable<Type> types = const [
    ViewNotificationTypesConfigGroupResponse,
    _$ViewNotificationTypesConfigGroupResponse,
  ];

  @override
  final String wireName = r'ViewNotificationTypesConfigGroupResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewNotificationTypesConfigGroupResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'types';
    yield serializers.serialize(
      object.types,
      specifiedType: const FullType(BuiltList, [
        FullType(ViewNotificationTypeConfigTypeResponse),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewNotificationTypesConfigGroupResponse object, {
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
    required ViewNotificationTypesConfigGroupResponseBuilder result,
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
        case r'description':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.description = valueDes;
          break;
        case r'types':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(ViewNotificationTypeConfigTypeResponse),
                    ]),
                  )
                  as BuiltList<ViewNotificationTypeConfigTypeResponse>;
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
  ViewNotificationTypesConfigGroupResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewNotificationTypesConfigGroupResponseBuilder();
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
