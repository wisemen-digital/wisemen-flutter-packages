//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/view_domain_event_log_index_response_meta.dart';
import 'package:openapi/src/model/view_domain_event_log_index_response_items_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_domain_event_log_index_response.g.dart';

/// ViewDomainEventLogIndexResponse
///
/// Properties:
/// * [items]
/// * [meta]
@BuiltValue()
abstract class ViewDomainEventLogIndexResponse
    implements
        Built<
          ViewDomainEventLogIndexResponse,
          ViewDomainEventLogIndexResponseBuilder
        > {
  @BuiltValueField(wireName: r'items')
  BuiltList<ViewDomainEventLogIndexResponseItemsInner> get items;

  @BuiltValueField(wireName: r'meta')
  ViewDomainEventLogIndexResponseMeta get meta;

  ViewDomainEventLogIndexResponse._();

  factory ViewDomainEventLogIndexResponse([
    void updates(ViewDomainEventLogIndexResponseBuilder b),
  ]) = _$ViewDomainEventLogIndexResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewDomainEventLogIndexResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewDomainEventLogIndexResponse> get serializer =>
      _$ViewDomainEventLogIndexResponseSerializer();
}

class _$ViewDomainEventLogIndexResponseSerializer
    implements PrimitiveSerializer<ViewDomainEventLogIndexResponse> {
  @override
  final Iterable<Type> types = const [
    ViewDomainEventLogIndexResponse,
    _$ViewDomainEventLogIndexResponse,
  ];

  @override
  final String wireName = r'ViewDomainEventLogIndexResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewDomainEventLogIndexResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [
        FullType(ViewDomainEventLogIndexResponseItemsInner),
      ]),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(ViewDomainEventLogIndexResponseMeta),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewDomainEventLogIndexResponse object, {
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
    required ViewDomainEventLogIndexResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(ViewDomainEventLogIndexResponseItemsInner),
                    ]),
                  )
                  as BuiltList<ViewDomainEventLogIndexResponseItemsInner>;
          result.items.replace(valueDes);
          break;
        case r'meta':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      ViewDomainEventLogIndexResponseMeta,
                    ),
                  )
                  as ViewDomainEventLogIndexResponseMeta;
          result.meta.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewDomainEventLogIndexResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewDomainEventLogIndexResponseBuilder();
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
