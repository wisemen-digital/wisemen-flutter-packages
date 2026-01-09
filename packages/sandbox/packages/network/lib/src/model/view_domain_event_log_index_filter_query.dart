//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/subject_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_domain_event_log_index_filter_query.g.dart';

/// ViewDomainEventLogIndexFilterQuery
///
/// Properties:
/// * [subjectType]
/// * [subjectId]
/// * [userUuid]
@BuiltValue()
abstract class ViewDomainEventLogIndexFilterQuery
    implements
        Built<
          ViewDomainEventLogIndexFilterQuery,
          ViewDomainEventLogIndexFilterQueryBuilder
        > {
  @BuiltValueField(wireName: r'subjectType')
  SubjectType? get subjectType;
  // enum subjectTypeEnum {  contact,  file,  role,  user,  };

  @BuiltValueField(wireName: r'subjectId')
  String? get subjectId;

  @BuiltValueField(wireName: r'userUuid')
  String? get userUuid;

  ViewDomainEventLogIndexFilterQuery._();

  factory ViewDomainEventLogIndexFilterQuery([
    void updates(ViewDomainEventLogIndexFilterQueryBuilder b),
  ]) = _$ViewDomainEventLogIndexFilterQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewDomainEventLogIndexFilterQueryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewDomainEventLogIndexFilterQuery> get serializer =>
      _$ViewDomainEventLogIndexFilterQuerySerializer();
}

class _$ViewDomainEventLogIndexFilterQuerySerializer
    implements PrimitiveSerializer<ViewDomainEventLogIndexFilterQuery> {
  @override
  final Iterable<Type> types = const [
    ViewDomainEventLogIndexFilterQuery,
    _$ViewDomainEventLogIndexFilterQuery,
  ];

  @override
  final String wireName = r'ViewDomainEventLogIndexFilterQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewDomainEventLogIndexFilterQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.subjectType != null) {
      yield r'subjectType';
      yield serializers.serialize(
        object.subjectType,
        specifiedType: const FullType(SubjectType),
      );
    }
    if (object.subjectId != null) {
      yield r'subjectId';
      yield serializers.serialize(
        object.subjectId,
        specifiedType: const FullType(String),
      );
    }
    if (object.userUuid != null) {
      yield r'userUuid';
      yield serializers.serialize(
        object.userUuid,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewDomainEventLogIndexFilterQuery object, {
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
    required ViewDomainEventLogIndexFilterQueryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'subjectType':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(SubjectType),
                  )
                  as SubjectType;
          result.subjectType = valueDes;
          break;
        case r'subjectId':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.subjectId = valueDes;
          break;
        case r'userUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.userUuid = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewDomainEventLogIndexFilterQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewDomainEventLogIndexFilterQueryBuilder();
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
