import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';

part 'books_by_list_name_response.g.dart';

@JsonSerializable()
class BooksByListNameResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "last_modified")
  String? lastModified;

  @JsonKey(name: "results")
  BooksByListNameVO? results;

  BooksByListNameResponse(
    this.status,
    this.copyright,
    this.numResults,
    this.lastModified,
    this.results,
  );

  factory BooksByListNameResponse.fromJson(Map<String, dynamic> json) =>
      _$BooksByListNameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BooksByListNameResponseToJson(this);
}
