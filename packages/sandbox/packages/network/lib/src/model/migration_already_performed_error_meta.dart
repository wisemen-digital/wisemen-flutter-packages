//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/notification_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'migration_already_performed_error_meta.g.dart';

/// MigrationAlreadyPerformedErrorMeta
///
/// Properties:
/// * [type]
@BuiltValue()
abstract class MigrationAlreadyPerformedErrorMeta
    implements
        Built<
          MigrationAlreadyPerformedErrorMeta,
          MigrationAlreadyPerformedErrorMetaBuilder
        > {
  @BuiltValueField(wireName: r'type')
  BuiltList<NotificationType> get type;

  MigrationAlreadyPerformedErrorMeta._();

  factory MigrationAlreadyPerformedErrorMeta([
    void updates(MigrationAlreadyPerformedErrorMetaBuilder b),
  ]) = _$MigrationAlreadyPerformedErrorMeta;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MigrationAlreadyPerformedErrorMetaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MigrationAlreadyPerformedErrorMeta> get serializer =>
      _$MigrationAlreadyPerformedErrorMetaSerializer();
}

class _$MigrationAlreadyPerformedErrorMetaSerializer
    implements PrimitiveSerializer<MigrationAlreadyPerformedErrorMeta> {
  @override
  final Iterable<Type> types = const [
    MigrationAlreadyPerformedErrorMeta,
    _$MigrationAlreadyPerformedErrorMeta,
  ];

  @override
  final String wireName = r'MigrationAlreadyPerformedErrorMeta';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MigrationAlreadyPerformedErrorMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(BuiltList, [FullType(NotificationType)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MigrationAlreadyPerformedErrorMeta object, {
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
    required MigrationAlreadyPerformedErrorMetaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(NotificationType),
                    ]),
                  )
                  as BuiltList<NotificationType>;
          result.type.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MigrationAlreadyPerformedErrorMeta deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MigrationAlreadyPerformedErrorMetaBuilder();
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
