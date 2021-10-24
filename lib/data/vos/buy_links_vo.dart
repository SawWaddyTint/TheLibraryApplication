import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:TheLibraryApplication/persistance/hive_constants.dart';

part 'buy_links_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BUY_LINKS_VO, adapterName: "BuyLinksVOAdapter")
class BuyLinksVO {
  @JsonKey(name: "name")
  @HiveField(0)
  String? name;

  @JsonKey(name: "url")
  @HiveField(1)
  String? url;
  BuyLinksVO(
    this.name,
    this.url,
  );
  factory BuyLinksVO.fromJson(Map<String, dynamic> json) =>
      _$BuyLinksVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$BuyLinksVOToJson(this); // Object to Json  #return type is Json Map
}
