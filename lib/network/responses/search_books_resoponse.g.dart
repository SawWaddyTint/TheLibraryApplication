// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_books_resoponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBookResponse _$SearchBookResponseFromJson(Map<String, dynamic> json) =>
    SearchBookResponse(
      json['kind'] as String?,
      json['totalItems'] as int?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => SearchBookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchBookResponseToJson(SearchBookResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
