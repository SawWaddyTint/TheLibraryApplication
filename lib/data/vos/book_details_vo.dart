import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/persistance/hive_constants.dart';

part 'book_details_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_BOOK_DETAILS_VO, adapterName: "BookDetailsVOAdapter")
class BookDetailsVO {
  @JsonKey(name: "title")
  @HiveField(0)
  String? title;

  @JsonKey(name: "description")
  @HiveField(1)
  String? description;

  @JsonKey(name: "contributor")
  @HiveField(2)
  String? contributor;

  @JsonKey(name: "author")
  @HiveField(3)
  String? author;

  @JsonKey(name: "contributor_note")
  @HiveField(4)
  String? contributorNote;

  @JsonKey(name: "price")
  @HiveField(5)
  String? price;

  @JsonKey(name: "age_group")
  @HiveField(6)
  String? ageGroup;

  @JsonKey(name: "publisher")
  @HiveField(7)
  String? publisher;

  @JsonKey(name: "primary_isbn13")
  @HiveField(8)
  String? primaryIsbn13;

  @JsonKey(name: "primary_isbn10")
  @HiveField(9)
  String? primaryIsbn10;

  BookDetailsVO(
    this.title,
    this.description,
    this.contributor,
    this.author,
    this.contributorNote,
    this.price,
    this.ageGroup,
    this.publisher,
    this.primaryIsbn13,
    this.primaryIsbn10,
  );
  factory BookDetailsVO.fromJson(Map<String, dynamic> json) =>
      _$BookDetailsVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$BookDetailsVOToJson(this); // Object to Json  #return type is Json Map
}
