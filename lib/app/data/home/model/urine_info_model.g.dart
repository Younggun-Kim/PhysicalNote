// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urine_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrineInfoModel _$UrineInfoModelFromJson(Map<String, dynamic> json) =>
    UrineInfoModel(
      id: (json['id'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      differenceFat: json['differenceFat'] as String?,
      urine: json['urine'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$UrineInfoModelToJson(UrineInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'differenceFat': instance.differenceFat,
      'urine': instance.urine,
      'recordDate': instance.recordDate,
    };
