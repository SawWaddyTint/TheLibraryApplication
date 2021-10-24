// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_overview_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookOverviewResultVOAdapter extends TypeAdapter<BookOverviewResultVO> {
  @override
  final int typeId = 4;

  @override
  BookOverviewResultVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookOverviewResultVO(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      (fields[6] as List?)?.cast<BookListVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookOverviewResultVO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.bestSellersDate)
      ..writeByte(1)
      ..write(obj.publishedDate)
      ..writeByte(2)
      ..write(obj.publishedDateDescription)
      ..writeByte(3)
      ..write(obj.previousPublishedDate)
      ..writeByte(4)
      ..write(obj.nextPublishedDate)
      ..writeByte(5)
      ..write(obj.listImage)
      ..writeByte(6)
      ..write(obj.lists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookOverviewResultVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookOverviewResultVO _$BookOverviewResultVOFromJson(
        Map<String, dynamic> json) =>
    BookOverviewResultVO(
      json['bestsellers_date'] as String?,
      json['published_date'] as String?,
      json['published_date_description'] as String?,
      json['previous_published_date'] as String?,
      json['next_published_date'] as String?,
      json['list_image'] as String?,
      (json['lists'] as List<dynamic>?)
          ?.map((e) => BookListVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookOverviewResultVOToJson(
        BookOverviewResultVO instance) =>
    <String, dynamic>{
      'bestsellers_date': instance.bestSellersDate,
      'published_date': instance.publishedDate,
      'published_date_description': instance.publishedDateDescription,
      'previous_published_date': instance.previousPublishedDate,
      'next_published_date': instance.nextPublishedDate,
      'list_image': instance.listImage,
      'lists': instance.lists,
    };
