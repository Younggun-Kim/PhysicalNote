// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urine_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrineInfoModel _$UrineInfoModelFromJson(Map<String, dynamic> json) =>
    UrineInfoModel(
      id: json['id'] as int?,
      differenceFat: json['differenceFat'] as int?,
      weight: json['weight'] as int?,
      urine: json['urine'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$UrineInfoModelToJson(UrineInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'differenceFat': instance.differenceFat,
      'weight': instance.weight,
      'urine': instance.urine,
      'recordDate': instance.recordDate,
    };
