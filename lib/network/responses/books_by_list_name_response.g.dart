// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_by_list_name_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksByListNameResponse _$BooksByListNameResponseFromJson(
        Map<String, dynamic> json) =>
    BooksByListNameResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      json['last_modified'] as String?,
      json['results'] == null
          ? null
          : BooksByListNameVO.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BooksByListNameResponseToJson(
        BooksByListNameResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'last_modified': instance.lastModified,
      'results': instance.results,
    };
