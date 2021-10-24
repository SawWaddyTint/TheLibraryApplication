import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/persistance/hive_constants.dart';

part 'book_overview_result.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_BOOK_OVERVIEW_RESULT_VO,
    adapterName: "BookOverviewResultVOAdapter")
class BookOverviewResultVO {
  @JsonKey(name: "bestsellers_date")
  @HiveField(0)
  String? bestSellersDate;

  @JsonKey(name: "published_date")
  @HiveField(1)
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  @HiveField(2)
  String? publishedDateDescription;

  @JsonKey(name: "previous_published_date")
  @HiveField(3)
  String? previousPublishedDate;

  @JsonKey(name: "next_published_date")
  @HiveField(4)
  String? nextPublishedDate;

  @JsonKey(name: "list_image")
  @HiveField(5)
  String? listImage;

  @JsonKey(name: "lists")
  @HiveField(6)
  List<BookListVO>? lists;

  BookOverviewResultVO(
    this.bestSellersDate,
    this.publishedDate,
    this.publishedDateDescription,
    this.previousPublishedDate,
    this.nextPublishedDate,
    this.listImage,
    this.lists,
  );

  factory BookOverviewResultVO.fromJson(Map<String, dynamic> json) =>
      _$BookOverviewResultVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() => _$BookOverviewResultVOToJson(
      this); // Object to Json  #return type is Json Map
}
