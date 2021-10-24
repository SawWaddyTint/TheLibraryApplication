import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';

part 'search_books_resoponse.g.dart';

@JsonSerializable()
class SearchBookResponse {
  @JsonKey(name: "kind")
  String? kind;

  @JsonKey(name: "totalItems")
  int? totalItems;

  @JsonKey(name: "items")
  List<SearchBookVO>? items;

  SearchBookResponse(
    this.kind,
    this.totalItems,
    this.items,
  );

  factory SearchBookResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchBookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBookResponseToJson(this);
}
