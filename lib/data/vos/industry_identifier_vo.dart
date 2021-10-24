import 'package:json_annotation/json_annotation.dart';

part 'industry_identifier_vo.g.dart';

@JsonSerializable()
class IndustryIdentifierVO {
  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "identifier")
  String? identifier;

  IndustryIdentifierVO(
    this.type,
    this.identifier,
  );

  factory IndustryIdentifierVO.fromJson(Map<String, dynamic> json) =>
      _$IndustryIdentifierVOFromJson(json);

  Map<String, dynamic> toJson() => _$IndustryIdentifierVOToJson(this);
}
