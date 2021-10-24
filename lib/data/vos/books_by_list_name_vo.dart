import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/data/vos/book_details_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/isbns_vo.dart';
import 'package:TheLibraryApplication/data/vos/reviews_vo.dart';
import 'package:TheLibraryApplication/persistance/hive_constants.dart';

part 'books_by_list_name_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_BOOKS_BY_LIST_NAME_VO,
    adapterName: "BooksByListNameVOAdapter")
class BooksByListNameVO {
  @JsonKey(name: "list_name")
  @HiveField(0)
  String? listName;

  @JsonKey(name: "list_name_encoded")
  @HiveField(1)
  String? listNameEncoded;

  @JsonKey(name: "bestsellers_date")
  @HiveField(2)
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  @HiveField(3)
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  @HiveField(4)
  String? publishedDateDescription;

  @JsonKey(name: "next_published_date")
  @HiveField(5)
  String? nextPublishedDate;

  @JsonKey(name: "previous_published_date")
  @HiveField(6)
  String? previousPublishedDate;

  @JsonKey(name: "display_name")
  @HiveField(7)
  String? displayName;

  @JsonKey(name: "normal_list_ends_at")
  @HiveField(8)
  int? normalListEndsAt;

  @JsonKey(name: "updated")
  @HiveField(9)
  String? updated;

  @JsonKey(name: "books")
  @HiveField(10)
  List<BookVO>? books;

  @JsonKey(name: "corrections")
  @HiveField(11)
  List<String>? corrections;

  BooksByListNameVO(
    this.listName,
    this.listNameEncoded,
    this.bestsellersDate,
    this.publishedDate,
    this.publishedDateDescription,
    this.nextPublishedDate,
    this.previousPublishedDate,
    this.displayName,
    this.normalListEndsAt,
    this.updated,
    this.books,
    this.corrections,
  );

  factory BooksByListNameVO.fromJson(Map<String, dynamic> json) =>
      _$BooksByListNameVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() => _$BooksByListNameVOToJson(
      this); // Object to Json  #return type is Json Map
}
