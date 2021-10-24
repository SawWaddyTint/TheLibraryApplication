// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInfoVO _$SaleInfoVOFromJson(Map<String, dynamic> json) => SaleInfoVO(
      json['country'] as String?,
      json['saleability'] as String?,
      json['isEbook'] as bool?,
    );

Map<String, dynamic> _$SaleInfoVOToJson(SaleInfoVO instance) =>
    <String, dynamic>{
      'country': instance.country,
      'saleability': instance.saleAbility,
      'isEbook': instance.isEbook,
    };
