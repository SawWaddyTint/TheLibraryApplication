// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewsVOAdapter extends TypeAdapter<ReviewsVO> {
  @override
  final int typeId = 8;

  @override
  ReviewsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewsVO(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewsVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.bookReviewLink)
      ..writeByte(1)
      ..write(obj.firstChapterLink)
      ..writeByte(2)
      ..write(obj.sundayReviewLink)
      ..writeByte(3)
      ..write(obj.articleChapterLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsVO _$ReviewsVOFromJson(Map<String, dynamic> json) => ReviewsVO(
      json['book_review_link'] as String?,
      json['first_chapter_link'] as String?,
      json['sunday_review_link'] as String?,
      json['article_chapter_link'] as String?,
    );

Map<String, dynamic> _$ReviewsVOToJson(ReviewsVO instance) => <String, dynamic>{
      'book_review_link': instance.bookReviewLink,
      'first_chapter_link': instance.firstChapterLink,
      'sunday_review_link': instance.sundayReviewLink,
      'article_chapter_link': instance.articleChapterLink,
    };
