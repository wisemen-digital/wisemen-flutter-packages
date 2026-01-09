//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/migrate_notification_types_v1400_response_errors_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'migrate_notification_types_v1400_response.g.dart';

/// MigrateNotificationTypesV1400Response
///
/// Properties:
/// * [traceId]
/// * [errors]
@BuiltValue()
abstract class MigrateNotificationTypesV1400Response
    implements
        Built<
          MigrateNotificationTypesV1400Response,
          MigrateNotificationTypesV1400ResponseBuilder
        > {
  @BuiltValueField(wireName: r'traceId')
  String? get traceId;

  @BuiltValueField(wireName: r'errors')
  BuiltList<MigrateNotificationTypesV1400ResponseErrorsInner>? get errors;

  MigrateNotificationTypesV1400Response._();

  factory MigrateNotificationTypesV1400Response([
    void updates(MigrateNotificationTypesV1400ResponseBuilder b),
  ]) = _$MigrateNotificationTypesV1400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MigrateNotificationTypesV1400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MigrateNotificationTypesV1400Response> get serializer =>
      _$MigrateNotificationTypesV1400ResponseSerializer();
}

class _$MigrateNotificationTypesV1400ResponseSerializer
    implements PrimitiveSerializer<MigrateNotificationTypesV1400Response> {
  @override
  final Iterable<Type> types = const [
    MigrateNotificationTypesV1400Response,
    _$MigrateNotificationTypesV1400Response,
  ];

  @override
  final String wireName = r'MigrateNotificationTypesV1400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MigrateNotificationTypesV1400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.traceId != null) {
      yield r'traceId';
      yield serializers.serialize(
        object.traceId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.errors != null) {
      yield r'errors';
      yield serializers.serialize(
        object.errors,
        specifiedType: const FullType(BuiltList, [
          FullType(MigrateNotificationTypesV1400ResponseErrorsInner),
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MigrateNotificationTypesV1400Response object, {
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
    required MigrateNotificationTypesV1400ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'traceId':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.traceId = valueDes;
          break;
        case r'errors':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(
                        MigrateNotificationTypesV1400ResponseErrorsInner,
                      ),
                    ]),
                  )
                  as BuiltList<
                    MigrateNotificationTypesV1400ResponseErrorsInner
                  >;
          result.errors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MigrateNotificationTypesV1400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MigrateNotificationTypesV1400ResponseBuilder();
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
