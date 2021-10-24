// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_by_list_name_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksByListNameVOAdapter extends TypeAdapter<BooksByListNameVO> {
  @override
  final int typeId = 5;

  @override
  BooksByListNameVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BooksByListNameVO(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as int?,
      fields[9] as String?,
      (fields[10] as List?)?.cast<BookVO>(),
      (fields[11] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BooksByListNameVO obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.listName)
      ..writeByte(1)
      ..write(obj.listNameEncoded)
      ..writeByte(2)
      ..write(obj.bestsellersDate)
      ..writeByte(3)
      ..write(obj.publishedDate)
      ..writeByte(4)
      ..write(obj.publishedDateDescription)
      ..writeByte(5)
      ..write(obj.nextPublishedDate)
      ..writeByte(6)
      ..write(obj.previousPublishedDate)
      ..writeByte(7)
      ..write(obj.displayName)
      ..writeByte(8)
      ..write(obj.normalListEndsAt)
      ..writeByte(9)
      ..write(obj.updated)
      ..writeByte(10)
      ..write(obj.books)
      ..writeByte(11)
      ..write(obj.corrections);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksByListNameVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksByListNameVO _$BooksByListNameVOFromJson(Map<String, dynamic> json) =>
    BooksByListNameVO(
      json['list_name'] as String?,
      json['list_name_encoded'] as String?,
      json['bestsellers_date'] as String?,
      json['published_date'] as String?,
      json['published_date_description'] as String?,
      json['next_published_date'] as String?,
      json['previous_published_date'] as String?,
      json['display_name'] as String?,
      json['normal_list_ends_at'] as int?,
      json['updated'] as String?,
      (json['books'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['corrections'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BooksByListNameVOToJson(BooksByListNameVO instance) =>
    <String, dynamic>{
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'bestsellers_date': instance.bestsellersDate,
      'published_date': instance.publishedDate,
      'published_date_description': instance.publishedDateDescription,
      'next_published_date': instance.nextPublishedDate,
      'previous_published_date': instance.previousPublishedDate,
      'display_name': instance.displayName,
      'normal_list_ends_at': instance.normalListEndsAt,
      'updated': instance.updated,
      'books': instance.books,
      'corrections': instance.corrections,
    };
