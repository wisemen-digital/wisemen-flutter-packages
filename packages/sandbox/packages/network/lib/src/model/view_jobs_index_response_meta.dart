//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/view_jobs_index_query_key.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_jobs_index_response_meta.g.dart';

/// ViewJobsIndexResponseMeta
///
/// Properties:
/// * [next]
@BuiltValue()
abstract class ViewJobsIndexResponseMeta
    implements
        Built<ViewJobsIndexResponseMeta, ViewJobsIndexResponseMetaBuilder> {
  @BuiltValueField(wireName: r'next')
  ViewJobsIndexQueryKey? get next;

  ViewJobsIndexResponseMeta._();

  factory ViewJobsIndexResponseMeta([
    void updates(ViewJobsIndexResponseMetaBuilder b),
  ]) = _$ViewJobsIndexResponseMeta;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobsIndexResponseMetaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobsIndexResponseMeta> get serializer =>
      _$ViewJobsIndexResponseMetaSerializer();
}

class _$ViewJobsIndexResponseMetaSerializer
    implements PrimitiveSerializer<ViewJobsIndexResponseMeta> {
  @override
  final Iterable<Type> types = const [
    ViewJobsIndexResponseMeta,
    _$ViewJobsIndexResponseMeta,
  ];

  @override
  final String wireName = r'ViewJobsIndexResponseMeta';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobsIndexResponseMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'next';
    yield object.next == null
        ? null
        : serializers.serialize(
            object.next,
            specifiedType: const FullType.nullable(ViewJobsIndexQueryKey),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewJobsIndexResponseMeta object, {
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
    required ViewJobsIndexResponseMetaBuilder result,
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
                      ViewJobsIndexQueryKey,
                    ),
                  )
                  as ViewJobsIndexQueryKey?;
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
  ViewJobsIndexResponseMeta deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobsIndexResponseMetaBuilder();
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
