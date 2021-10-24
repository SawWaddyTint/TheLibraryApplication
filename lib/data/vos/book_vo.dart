import 'package:TheLibraryApplication/data/vos/buy_links_vo.dart';
import 'package:TheLibraryApplication/data/vos/isbns_vo.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/persistance/hive_constants.dart';

part 'book_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BOOK_VO, adapterName: "BookVOAdapter")
class BookVO {
  @JsonKey(name: "age_group")
  @HiveField(0)
  String? ageGroup;

  @JsonKey(name: "amazon_product_url")
  @HiveField(1)
  String? amazonProductUrl;

  @JsonKey(name: "article_chapter_link")
  @HiveField(2)
  String? articleChapterLink;

  @JsonKey(name: "author")
  @HiveField(3)
  String? author;

  @JsonKey(name: "book_image")
  @HiveField(4)
  String? bookImage;

  @JsonKey(name: "book_image_width")
  @HiveField(5)
  int? bookImageWidth;

  @JsonKey(name: "book_image_height")
  @HiveField(6)
  int? bookImageHeight;

  @JsonKey(name: "book_review_link")
  @HiveField(7)
  String? bookReviewLink;

  @JsonKey(name: "contributor")
  @HiveField(8)
  String? contributor;

  @JsonKey(name: "contributor_note")
  @HiveField(9)
  String? contributorNote;

  @JsonKey(name: "created_date")
  @HiveField(10)
  String? createdDate;

  @JsonKey(name: "description")
  @HiveField(11)
  String? description;

  @JsonKey(name: "first_chapter_link")
  @HiveField(12)
  String? firstChapterLink;

  @JsonKey(name: "price")
  @HiveField(13)
  String? price;

  @JsonKey(name: "primary_isbn10")
  @HiveField(14)
  String primaryIsbn10;

  @JsonKey(name: "primary_isbn13")
  @HiveField(15)
  String? primaryIsbn13;

  @JsonKey(name: "book_uri")
  @HiveField(16)
  String? bookUri;

  @JsonKey(name: "publisher")
  @HiveField(17)
  String? publisher;

  @JsonKey(name: "rank")
  @HiveField(18)
  int? rank;

  @JsonKey(name: "rank_last_week")
  @HiveField(19)
  int? rankLastWeek;

  @JsonKey(name: "sunday_review_link")
  @HiveField(20)
  String? sundayReviewLink;

  @JsonKey(name: "title")
  @HiveField(21)
  String? title;

  @JsonKey(name: "updated_date")
  @HiveField(22)
  String? updateDate;

  @JsonKey(name: "weeks_on_list")
  @HiveField(23)
  int? weeksOnList;

  @JsonKey(name: "buy_links")
  @HiveField(24)
  List<BuyLinksVO>? buyLinks;

  @JsonKey(name: "asterisk")
  @HiveField(25)
  int? asterisk;
  @JsonKey(name: "isbns")
  @HiveField(26)
  List<IsbnsVO>? isbns;

  BookVO(
      this.ageGroup,
      this.amazonProductUrl,
      this.articleChapterLink,
      this.author,
      this.bookImage,
      this.bookImageWidth,
      this.bookImageHeight,
      this.bookReviewLink,
      this.contributor,
      this.contributorNote,
      this.createdDate,
      this.description,
      this.firstChapterLink,
      this.price,
      this.primaryIsbn10,
      this.primaryIsbn13,
      this.bookUri,
      this.publisher,
      this.rank,
      this.rankLastWeek,
      this.sundayReviewLink,
      this.title,
      this.updateDate,
      this.weeksOnList,
      this.buyLinks,
      this.asterisk,
      this.isbns);

  factory BookVO.fromJson(Map<String, dynamic> json) =>
      _$BookVOFromJson(json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$BookVOToJson(this); // Object to Json  #return type is Json Map

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookVO &&
          runtimeType == other.runtimeType &&
          primaryIsbn10 == other.primaryIsbn10 &&
          title == other.title;

  @override
  int get hashCode => primaryIsbn10.hashCode ^ title.hashCode;
}
