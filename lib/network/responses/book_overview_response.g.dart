// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_overview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookOverviewResponse _$BookOverviewResponseFromJson(
        Map<String, dynamic> json) =>
    BookOverviewResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      json['results'] == null
          ? null
          : BookOverviewResultVO.fromJson(
              json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookOverviewResponseToJson(
        BookOverviewResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'results': instance.results,
    };
