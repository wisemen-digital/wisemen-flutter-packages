//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_contact_index_filter_query.g.dart';

/// ViewContactIndexFilterQuery
///
/// Properties:
/// * [isActive]
@BuiltValue()
abstract class ViewContactIndexFilterQuery
    implements
        Built<ViewContactIndexFilterQuery, ViewContactIndexFilterQueryBuilder> {
  @BuiltValueField(wireName: r'isActive')
  String? get isActive;

  ViewContactIndexFilterQuery._();

  factory ViewContactIndexFilterQuery([
    void updates(ViewContactIndexFilterQueryBuilder b),
  ]) = _$ViewContactIndexFilterQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewContactIndexFilterQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewContactIndexFilterQuery> get serializer =>
      _$ViewContactIndexFilterQuerySerializer();
}

class _$ViewContactIndexFilterQuerySerializer
    implements PrimitiveSerializer<ViewContactIndexFilterQuery> {
  @override
  final Iterable<Type> types = const [
    ViewContactIndexFilterQuery,
    _$ViewContactIndexFilterQuery,
  ];

  @override
  final String wireName = r'ViewContactIndexFilterQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewContactIndexFilterQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.isActive != null) {
      yield r'isActive';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewContactIndexFilterQuery object, {
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
    required ViewContactIndexFilterQueryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'isActive':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewContactIndexFilterQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewContactIndexFilterQueryBuilder();
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
