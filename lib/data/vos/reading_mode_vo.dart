import 'package:json_annotation/json_annotation.dart';

part 'reading_mode_vo.g.dart';

@JsonSerializable()
class ReadingModeVO {
  @JsonKey(name: "text")
  bool? text;

  @JsonKey(name: "image")
  bool? image;

  ReadingModeVO(
    this.text,
    this.image,
  );

  factory ReadingModeVO.fromJson(Map<String, dynamic> json) =>
      _$ReadingModeVOFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingModeVOToJson(this);
}
