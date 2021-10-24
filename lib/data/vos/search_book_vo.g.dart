// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_book_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchBookVOAdapter extends TypeAdapter<SearchBookVO> {
  @override
  final int typeId = 9;

  @override
  SearchBookVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchBookVO(
      fields[0] as String?,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as VolumeInfoVO?,
      fields[5] as SaleInfoVO?,
      fields[6] as AccessInfoVO?,
      fields[7] as SearchInfoVO?,
    );
  }

  @override
  void write(BinaryWriter writer, SearchBookVO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.kind)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.etag)
      ..writeByte(3)
      ..write(obj.selfLink)
      ..writeByte(4)
      ..write(obj.volumeInfo)
      ..writeByte(5)
      ..write(obj.saleInfo)
      ..writeByte(6)
      ..write(obj.accessInfo)
      ..writeByte(7)
      ..write(obj.searchInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchBookVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBookVO _$SearchBookVOFromJson(Map<String, dynamic> json) => SearchBookVO(
      json['kind'] as String?,
      json['id'] as String,
      json['etag'] as String?,
      json['selfLink'] as String?,
      json['volumeInfo'] == null
          ? null
          : VolumeInfoVO.fromJson(json['volumeInfo'] as Map<String, dynamic>),
      json['saleInfo'] == null
          ? null
          : SaleInfoVO.fromJson(json['saleInfo'] as Map<String, dynamic>),
      json['accessInfo'] == null
          ? null
          : AccessInfoVO.fromJson(json['accessInfo'] as Map<String, dynamic>),
      json['searchInfo'] == null
          ? null
          : SearchInfoVO.fromJson(json['searchInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchBookVOToJson(SearchBookVO instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.etag,
      'selfLink': instance.selfLink,
      'volumeInfo': instance.volumeInfo,
      'saleInfo': instance.saleInfo,
      'accessInfo': instance.accessInfo,
      'searchInfo': instance.searchInfo,
    };
