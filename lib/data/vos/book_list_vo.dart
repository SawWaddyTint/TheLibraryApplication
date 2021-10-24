import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/persistance/hive_constants.dart';

part 'book_list_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BOOK_LIST_VO, adapterName: "BookListVOAdapter")
class BookListVO {
  @JsonKey(name: "list_id")
  @HiveField(0)
  int listId;

  @JsonKey(name: "list_name")
  @HiveField(1)
  String? listName;

  @JsonKey(name: "list_name_encoded")
  @HiveField(2)
  String? listNameEncoded;

  @JsonKey(name: "display_name")
  @HiveField(3)
  String? displayName;

  @JsonKey(name: "updated")
  @HiveField(4)
  String? updated;

  @JsonKey(name: "list_image")
  @HiveField(5)
  String? listImage;

  @JsonKey(name: "list_image_width")
  @HiveField(6)
  String? listImageWidth;

  @JsonKey(name: "list_image_height")
  @HiveField(7)
  String? listImageHeight;

  @JsonKey(name: "books")
  @HiveField(8)
  List<BookVO>? books;

  BookListVO(
    this.listId,
    this.listName,
    this.listNameEncoded,
    this.displayName,
    this.updated,
    this.listImage,
    this.listImageWidth,
    this.listImageHeight,
    this.books,
  );

  factory BookListVO.fromJson(Map<String, dynamic> json) =>
      _$BookListVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$BookListVOToJson(this); // Object to Json  #return type is Json Map

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookListVO &&
          runtimeType == other.runtimeType &&
          listId == other.listId &&
          listName == other.listName;

  @override
  int get hashCode => listId.hashCode ^ listName.hashCode;
}
