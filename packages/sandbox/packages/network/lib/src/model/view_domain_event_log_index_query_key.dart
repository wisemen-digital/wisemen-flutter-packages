//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_domain_event_log_index_query_key.g.dart';

/// ViewDomainEventLogIndexQueryKey
///
/// Properties:
/// * [createdAt]
/// * [uuid]
@BuiltValue()
abstract class ViewDomainEventLogIndexQueryKey
    implements
        Built<
          ViewDomainEventLogIndexQueryKey,
          ViewDomainEventLogIndexQueryKeyBuilder
        > {
  @BuiltValueField(wireName: r'createdAt')
  String get createdAt;

  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  ViewDomainEventLogIndexQueryKey._();

  factory ViewDomainEventLogIndexQueryKey([
    void updates(ViewDomainEventLogIndexQueryKeyBuilder b),
  ]) = _$ViewDomainEventLogIndexQueryKey;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewDomainEventLogIndexQueryKeyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewDomainEventLogIndexQueryKey> get serializer =>
      _$ViewDomainEventLogIndexQueryKeySerializer();
}

class _$ViewDomainEventLogIndexQueryKeySerializer
    implements PrimitiveSerializer<ViewDomainEventLogIndexQueryKey> {
  @override
  final Iterable<Type> types = const [
    ViewDomainEventLogIndexQueryKey,
    _$ViewDomainEventLogIndexQueryKey,
  ];

  @override
  final String wireName = r'ViewDomainEventLogIndexQueryKey';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewDomainEventLogIndexQueryKey object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(String),
    );
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewDomainEventLogIndexQueryKey object, {
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
    required ViewDomainEventLogIndexQueryKeyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'createdAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.createdAt = valueDes;
          break;
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
  ViewDomainEventLogIndexQueryKey deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewDomainEventLogIndexQueryKeyBuilder();
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
