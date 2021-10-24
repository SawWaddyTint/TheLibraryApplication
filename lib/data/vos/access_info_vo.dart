import 'package:TheLibraryApplication/data/vos/epub_vo.dart';
import 'package:TheLibraryApplication/data/vos/pdf_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'access_info_vo.g.dart';

@JsonSerializable()
class AccessInfoVO {
  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "viewability")
  String? viewAbility;

  @JsonKey(name: "embeddable")
  bool? embeddable;

  @JsonKey(name: "publicDomain")
  bool? publicDomain;

  @JsonKey(name: "textToSpeechPermission")
  String? textToSpeechPermission;

  @JsonKey(name: "epub")
  EpubVO? epub;

  @JsonKey(name: "pdf")
  PdfVO? pdf;

  @JsonKey(name: "webReaderLink")
  String? webReaderLink;

  @JsonKey(name: "accessViewStatus")
  String? accessViewStatus;

  @JsonKey(name: "quoteSharingAllowed")
  bool? quoteSharingAllowed;

  AccessInfoVO(
    this.country,
    this.viewAbility,
    this.embeddable,
    this.publicDomain,
    this.textToSpeechPermission,
    this.epub,
    this.pdf,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  );

  factory AccessInfoVO.fromJson(Map<String, dynamic> json) =>
      _$AccessInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$AccessInfoVOToJson(this);
}
