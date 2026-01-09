//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/view_notification_types_config_group_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_notification_types_config_response.g.dart';

/// GetNotificationTypesConfigResponse
///
/// Properties:
/// * [groups]
@BuiltValue()
abstract class GetNotificationTypesConfigResponse
    implements
        Built<
          GetNotificationTypesConfigResponse,
          GetNotificationTypesConfigResponseBuilder
        > {
  @BuiltValueField(wireName: r'groups')
  BuiltList<ViewNotificationTypesConfigGroupResponse> get groups;

  GetNotificationTypesConfigResponse._();

  factory GetNotificationTypesConfigResponse([
    void updates(GetNotificationTypesConfigResponseBuilder b),
  ]) = _$GetNotificationTypesConfigResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetNotificationTypesConfigResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetNotificationTypesConfigResponse> get serializer =>
      _$GetNotificationTypesConfigResponseSerializer();
}

class _$GetNotificationTypesConfigResponseSerializer
    implements PrimitiveSerializer<GetNotificationTypesConfigResponse> {
  @override
  final Iterable<Type> types = const [
    GetNotificationTypesConfigResponse,
    _$GetNotificationTypesConfigResponse,
  ];

  @override
  final String wireName = r'GetNotificationTypesConfigResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetNotificationTypesConfigResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'groups';
    yield serializers.serialize(
      object.groups,
      specifiedType: const FullType(BuiltList, [
        FullType(ViewNotificationTypesConfigGroupResponse),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetNotificationTypesConfigResponse object, {
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
    required GetNotificationTypesConfigResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'groups':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(ViewNotificationTypesConfigGroupResponse),
                    ]),
                  )
                  as BuiltList<ViewNotificationTypesConfigGroupResponse>;
          result.groups.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetNotificationTypesConfigResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetNotificationTypesConfigResponseBuilder();
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
