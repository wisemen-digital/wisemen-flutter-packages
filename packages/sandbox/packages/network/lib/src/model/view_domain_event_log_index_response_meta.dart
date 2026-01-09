//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/view_domain_event_log_index_query_key.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_domain_event_log_index_response_meta.g.dart';

/// ViewDomainEventLogIndexResponseMeta
///
/// Properties:
/// * [next]
@BuiltValue()
abstract class ViewDomainEventLogIndexResponseMeta
    implements
        Built<
          ViewDomainEventLogIndexResponseMeta,
          ViewDomainEventLogIndexResponseMetaBuilder
        > {
  @BuiltValueField(wireName: r'next')
  ViewDomainEventLogIndexQueryKey? get next;

  ViewDomainEventLogIndexResponseMeta._();

  factory ViewDomainEventLogIndexResponseMeta([
    void updates(ViewDomainEventLogIndexResponseMetaBuilder b),
  ]) = _$ViewDomainEventLogIndexResponseMeta;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewDomainEventLogIndexResponseMetaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewDomainEventLogIndexResponseMeta> get serializer =>
      _$ViewDomainEventLogIndexResponseMetaSerializer();
}

class _$ViewDomainEventLogIndexResponseMetaSerializer
    implements PrimitiveSerializer<ViewDomainEventLogIndexResponseMeta> {
  @override
  final Iterable<Type> types = const [
    ViewDomainEventLogIndexResponseMeta,
    _$ViewDomainEventLogIndexResponseMeta,
  ];

  @override
  final String wireName = r'ViewDomainEventLogIndexResponseMeta';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewDomainEventLogIndexResponseMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'next';
    yield object.next == null
        ? null
        : serializers.serialize(
            object.next,
            specifiedType: const FullType.nullable(
              ViewDomainEventLogIndexQueryKey,
            ),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewDomainEventLogIndexResponseMeta object, {
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
    required ViewDomainEventLogIndexResponseMetaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'next':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(
                      ViewDomainEventLogIndexQueryKey,
                    ),
                  )
                  as ViewDomainEventLogIndexQueryKey?;
          if (valueDes == null) continue;
          result.next.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewDomainEventLogIndexResponseMeta deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewDomainEventLogIndexResponseMetaBuilder();
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
