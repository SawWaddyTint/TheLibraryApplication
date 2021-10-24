// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessInfoVO _$AccessInfoVOFromJson(Map<String, dynamic> json) => AccessInfoVO(
      json['country'] as String?,
      json['viewability'] as String?,
      json['embeddable'] as bool?,
      json['publicDomain'] as bool?,
      json['textToSpeechPermission'] as String?,
      json['epub'] == null
          ? null
          : EpubVO.fromJson(json['epub'] as Map<String, dynamic>),
      json['pdf'] == null
          ? null
          : PdfVO.fromJson(json['pdf'] as Map<String, dynamic>),
      json['webReaderLink'] as String?,
      json['accessViewStatus'] as String?,
      json['quoteSharingAllowed'] as bool?,
    );

Map<String, dynamic> _$AccessInfoVOToJson(AccessInfoVO instance) =>
    <String, dynamic>{
      'country': instance.country,
      'viewability': instance.viewAbility,
      'embeddable': instance.embeddable,
      'publicDomain': instance.publicDomain,
      'textToSpeechPermission': instance.textToSpeechPermission,
      'epub': instance.epub,
      'pdf': instance.pdf,
      'webReaderLink': instance.webReaderLink,
      'accessViewStatus': instance.accessViewStatus,
      'quoteSharingAllowed': instance.quoteSharingAllowed,
    };
