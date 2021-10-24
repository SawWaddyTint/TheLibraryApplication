import 'package:TheLibraryApplication/data/vos/image_link_vo.dart';
import 'package:TheLibraryApplication/data/vos/industry_identifier_vo.dart';

import 'package:TheLibraryApplication/data/vos/panelization_summary_vo.dart';
import 'package:TheLibraryApplication/data/vos/reading_mode_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'volume_info_vo.g.dart';

@JsonSerializable()
class VolumeInfoVO {
  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "subtitle")
  String? subtitle;

  @JsonKey(name: "authors")
  List<String>? authors;

  @JsonKey(name: "publisher")
  String? publisher;

  @JsonKey(name: "publishedDate")
  String? publishedDate;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "industryIdentifiers")
  List<IndustryIdentifierVO>? industryIdentifiers;

  @JsonKey(name: "readingModes")
  ReadingModeVO? readingModes;

  @JsonKey(name: "pageCount")
  int? pageCount;

  @JsonKey(name: "printType")
  String? printType;

  @JsonKey(name: "maturityRating")
  String? maturityRating;

  @JsonKey(name: "allowAnonLogging")
  bool? allowAnonLogging;

  @JsonKey(name: "contentVersion")
  String? contentVersion;

  @JsonKey(name: "panelizationSummary")
  PanelizationSummaryVO? panelizationSummary;

  @JsonKey(name: "categories")
  List<String>? categories;

  @JsonKey(name: "imageLinks")
  ImageLinkVO? imageLinks;

  @JsonKey(name: "language")
  String? language;

  @JsonKey(name: "previewLink")
  String? previewLink;

  @JsonKey(name: "infoLink")
  String? infoLink;

  @JsonKey(name: "canonicalVolumeLink")
  String? canonicalVolumeLink;

  VolumeInfoVO(
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printType,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.categories,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  );

  factory VolumeInfoVO.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeInfoVOToJson(this);
}
