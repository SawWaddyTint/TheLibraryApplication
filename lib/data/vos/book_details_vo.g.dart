// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_details_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookDetailsVOAdapter extends TypeAdapter<BookDetailsVO> {
  @override
  final int typeId = 7;

  @override
  BookDetailsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookDetailsVO(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as String?,
      fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookDetailsVO obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.contributor)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.contributorNote)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.ageGroup)
      ..writeByte(7)
      ..write(obj.publisher)
      ..writeByte(8)
      ..write(obj.primaryIsbn13)
      ..writeByte(9)
      ..write(obj.primaryIsbn10);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookDetailsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDetailsVO _$BookDetailsVOFromJson(Map<String, dynamic> json) =>
    BookDetailsVO(
      json['title'] as String?,
      json['description'] as String?,
      json['contributor'] as String?,
      json['author'] as String?,
      json['contributor_note'] as String?,
      json['price'] as String?,
      json['age_group'] as String?,
      json['publisher'] as String?,
      json['primary_isbn13'] as String?,
      json['primary_isbn10'] as String?,
    );

Map<String, dynamic> _$BookDetailsVOToJson(BookDetailsVO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'contributor': instance.contributor,
      'author': instance.author,
      'contributor_note': instance.contributorNote,
      'price': instance.price,
      'age_group': instance.ageGroup,
      'publisher': instance.publisher,
      'primary_isbn13': instance.primaryIsbn13,
      'primary_isbn10': instance.primaryIsbn10,
    };
