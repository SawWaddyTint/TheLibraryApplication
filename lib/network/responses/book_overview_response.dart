import 'package:TheLibraryApplication/data/vos/book_overview_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_overview_response.g.dart';

@JsonSerializable()
class BookOverviewResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "results")
  BookOverviewResultVO? results;

  BookOverviewResponse(
    this.status,
    this.copyright,
    this.numResults,
    this.results,
  );

  factory BookOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$BookOverviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookOverviewResponseToJson(this);
}
