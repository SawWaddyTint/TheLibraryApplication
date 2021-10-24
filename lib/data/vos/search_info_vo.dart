import 'package:json_annotation/json_annotation.dart';

part 'search_info_vo.g.dart';

@JsonSerializable()
class SearchInfoVO {
  @JsonKey(name: "textSnippet")
  String textSnippet;

  SearchInfoVO({
    required this.textSnippet,
  });

  factory SearchInfoVO.fromJson(Map<String, dynamic> json) =>
      _$SearchInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchInfoVOToJson(this);
}
