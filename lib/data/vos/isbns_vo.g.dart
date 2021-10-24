// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isbns_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IsbnsVOAdapter extends TypeAdapter<IsbnsVO> {
  @override
  final int typeId = 6;

  @override
  IsbnsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IsbnsVO(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IsbnsVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isbn10)
      ..writeByte(1)
      ..write(obj.isbn13);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsbnsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsbnsVO _$IsbnsVOFromJson(Map<String, dynamic> json) => IsbnsVO(
      json['isbn10'] as String?,
      json['isbn13'] as String?,
    );

Map<String, dynamic> _$IsbnsVOToJson(IsbnsVO instance) => <String, dynamic>{
      'isbn10': instance.isbn10,
      'isbn13': instance.isbn13,
    };
