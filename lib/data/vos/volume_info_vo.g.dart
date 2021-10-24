// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeInfoVO _$VolumeInfoVOFromJson(Map<String, dynamic> json) => VolumeInfoVO(
      json['title'] as String?,
      json['subtitle'] as String?,
      (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['publisher'] as String?,
      json['publishedDate'] as String?,
      json['description'] as String?,
      (json['industryIdentifiers'] as List<dynamic>?)
          ?.map((e) => IndustryIdentifierVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['readingModes'] == null
          ? null
          : ReadingModeVO.fromJson(
              json['readingModes'] as Map<String, dynamic>),
      json['pageCount'] as int?,
      json['printType'] as String?,
      json['maturityRating'] as String?,
      json['allowAnonLogging'] as bool?,
      json['contentVersion'] as String?,
      json['panelizationSummary'] == null
          ? null
          : PanelizationSummaryVO.fromJson(
              json['panelizationSummary'] as Map<String, dynamic>),
      (json['categories'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['imageLinks'] == null
          ? null
          : ImageLinkVO.fromJson(json['imageLinks'] as Map<String, dynamic>),
      json['language'] as String?,
      json['previewLink'] as String?,
      json['infoLink'] as String?,
      json['canonicalVolumeLink'] as String?,
    );

Map<String, dynamic> _$VolumeInfoVOToJson(VolumeInfoVO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'industryIdentifiers': instance.industryIdentifiers,
      'readingModes': instance.readingModes,
      'pageCount': instance.pageCount,
      'printType': instance.printType,
      'maturityRating': instance.maturityRating,
      'allowAnonLogging': instance.allowAnonLogging,
      'contentVersion': instance.contentVersion,
      'panelizationSummary': instance.panelizationSummary,
      'categories': instance.categories,
      'imageLinks': instance.imageLinks,
      'language': instance.language,
      'previewLink': instance.previewLink,
      'infoLink': instance.infoLink,
      'canonicalVolumeLink': instance.canonicalVolumeLink,
    };
