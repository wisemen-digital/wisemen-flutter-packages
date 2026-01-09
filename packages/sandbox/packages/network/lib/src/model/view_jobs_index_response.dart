//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/view_jobs_index_response_meta.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/view_jobs_index_item_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_jobs_index_response.g.dart';

/// ViewJobsIndexResponse
///
/// Properties:
/// * [items]
/// * [meta]
@BuiltValue()
abstract class ViewJobsIndexResponse
    implements Built<ViewJobsIndexResponse, ViewJobsIndexResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<ViewJobsIndexItemResponse> get items;

  @BuiltValueField(wireName: r'meta')
  ViewJobsIndexResponseMeta get meta;

  ViewJobsIndexResponse._();

  factory ViewJobsIndexResponse([
    void updates(ViewJobsIndexResponseBuilder b),
  ]) = _$ViewJobsIndexResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobsIndexResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobsIndexResponse> get serializer =>
      _$ViewJobsIndexResponseSerializer();
}

class _$ViewJobsIndexResponseSerializer
    implements PrimitiveSerializer<ViewJobsIndexResponse> {
  @override
  final Iterable<Type> types = const [
    ViewJobsIndexResponse,
    _$ViewJobsIndexResponse,
  ];

  @override
  final String wireName = r'ViewJobsIndexResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobsIndexResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [
        FullType(ViewJobsIndexItemResponse),
      ]),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(ViewJobsIndexResponseMeta),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewJobsIndexResponse object, {
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
    required ViewJobsIndexResponseBuilder result,
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
                      FullType(ViewJobsIndexItemResponse),
                    ]),
                  )
                  as BuiltList<ViewJobsIndexItemResponse>;
          result.items.replace(valueDes);
          break;
        case r'meta':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(ViewJobsIndexResponseMeta),
                  )
                  as ViewJobsIndexResponseMeta;
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
  ViewJobsIndexResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobsIndexResponseBuilder();
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
