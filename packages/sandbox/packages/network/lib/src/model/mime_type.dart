//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mime_type.g.dart';

class MimeType extends EnumClass {
  @BuiltValueEnumConst(wireName: r'application/pdf')
  static const MimeType applicationSlashPdf = _$applicationSlashPdf;
  @BuiltValueEnumConst(wireName: r'application/msword')
  static const MimeType applicationSlashMsword = _$applicationSlashMsword;
  @BuiltValueEnumConst(
    wireName:
        r'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  )
  static const MimeType
  applicationSlashVndPeriodOpenxmlformatsOfficedocumentPeriodWordprocessingmlPeriodDocument =
      _$applicationSlashVndPeriodOpenxmlformatsOfficedocumentPeriodWordprocessingmlPeriodDocument;
  @BuiltValueEnumConst(wireName: r'application/vnd.ms-powerpoint')
  static const MimeType applicationSlashVndPeriodMsPowerpoint =
      _$applicationSlashVndPeriodMsPowerpoint;
  @BuiltValueEnumConst(
    wireName:
        r'application/vnd.openxmlformats-officedocument.presentationml.presentation',
  )
  static const MimeType
  applicationSlashVndPeriodOpenxmlformatsOfficedocumentPeriodPresentationmlPeriodPresentation =
      _$applicationSlashVndPeriodOpenxmlformatsOfficedocumentPeriodPresentationmlPeriodPresentation;
  @BuiltValueEnumConst(wireName: r'text/plain')
  static const MimeType textSlashPlain = _$textSlashPlain;
  @BuiltValueEnumConst(wireName: r'text/html')
  static const MimeType textSlashHtml = _$textSlashHtml;
  @BuiltValueEnumConst(wireName: r'text/csv')
  static const MimeType textSlashCsv = _$textSlashCsv;
  @BuiltValueEnumConst(wireName: r'image/jpeg')
  static const MimeType imageSlashJpeg = _$imageSlashJpeg;
  @BuiltValueEnumConst(wireName: r'image/png')
  static const MimeType imageSlashPng = _$imageSlashPng;
  @BuiltValueEnumConst(wireName: r'image/tiff')
  static const MimeType imageSlashTiff = _$imageSlashTiff;
  @BuiltValueEnumConst(wireName: r'image/bmp')
  static const MimeType imageSlashBmp = _$imageSlashBmp;
  @BuiltValueEnumConst(wireName: r'image/heic')
  static const MimeType imageSlashHeic = _$imageSlashHeic;
  @BuiltValueEnumConst(wireName: r'image/webp')
  static const MimeType imageSlashWebp = _$imageSlashWebp;
  @BuiltValueEnumConst(wireName: r'image/gif')
  static const MimeType imageSlashGif = _$imageSlashGif;
  @BuiltValueEnumConst(wireName: r'application/octet-stream')
  static const MimeType applicationSlashOctetStream =
      _$applicationSlashOctetStream;

  static Serializer<MimeType> get serializer => _$mimeTypeSerializer;

  const MimeType._(String name) : super(name);

  static BuiltSet<MimeType> get values => _$values;
  static MimeType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class MimeTypeMixin = Object with _$MimeTypeMixin;
