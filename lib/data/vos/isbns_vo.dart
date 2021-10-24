import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/persistance/hive_constants.dart';

part 'isbns_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ISBNS_VO, adapterName: "IsbnsVOAdapter")
class IsbnsVO {
  @JsonKey(name: "isbn10")
  @HiveField(0)
  String? isbn10;

  @JsonKey(name: "isbn13")
  @HiveField(1)
  String? isbn13;
  IsbnsVO(
    this.isbn10,
    this.isbn13,
  );
  factory IsbnsVO.fromJson(Map<String, dynamic> json) =>
      _$IsbnsVOFromJson(json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$IsbnsVOToJson(this); // Object to Json  #return type is Json Map
}
