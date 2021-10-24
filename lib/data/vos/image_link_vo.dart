import 'package:json_annotation/json_annotation.dart';

part 'image_link_vo.g.dart';

@JsonSerializable()
class ImageLinkVO {
  @JsonKey(name: "smallThumbnail")
  String? smallThumbnail;

  @JsonKey(name: "thumbnail")
  String? thumbnail;

  ImageLinkVO(
    this.smallThumbnail,
    this.thumbnail,
  );

  factory ImageLinkVO.fromJson(Map<String, dynamic> json) =>
      _$ImageLinkVOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageLinkVOToJson(this);
}
