//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/migrate_collections_v1500_response_errors_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'migrate_collections_v1500_response.g.dart';

/// MigrateCollectionsV1500Response
///
/// Properties:
/// * [traceId]
/// * [errors]
@BuiltValue()
abstract class MigrateCollectionsV1500Response
    implements
        Built<
          MigrateCollectionsV1500Response,
          MigrateCollectionsV1500ResponseBuilder
        > {
  @BuiltValueField(wireName: r'traceId')
  String? get traceId;

  @BuiltValueField(wireName: r'errors')
  BuiltList<MigrateCollectionsV1500ResponseErrorsInner>? get errors;

  MigrateCollectionsV1500Response._();

  factory MigrateCollectionsV1500Response([
    void updates(MigrateCollectionsV1500ResponseBuilder b),
  ]) = _$MigrateCollectionsV1500Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MigrateCollectionsV1500ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MigrateCollectionsV1500Response> get serializer =>
      _$MigrateCollectionsV1500ResponseSerializer();
}

class _$MigrateCollectionsV1500ResponseSerializer
    implements PrimitiveSerializer<MigrateCollectionsV1500Response> {
  @override
  final Iterable<Type> types = const [
    MigrateCollectionsV1500Response,
    _$MigrateCollectionsV1500Response,
  ];

  @override
  final String wireName = r'MigrateCollectionsV1500Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MigrateCollectionsV1500Response object, {
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
          FullType(MigrateCollectionsV1500ResponseErrorsInner),
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MigrateCollectionsV1500Response object, {
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
    required MigrateCollectionsV1500ResponseBuilder result,
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
                      FullType(MigrateCollectionsV1500ResponseErrorsInner),
                    ]),
                  )
                  as BuiltList<MigrateCollectionsV1500ResponseErrorsInner>;
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
  MigrateCollectionsV1500Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MigrateCollectionsV1500ResponseBuilder();
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
