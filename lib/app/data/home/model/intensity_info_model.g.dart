// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intensity_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntensityInfoModel _$IntensityInfoModelFromJson(Map<String, dynamic> json) =>
    IntensityInfoModel(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      level: (json['level'] as num?)?.toInt(),
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$IntensityInfoModelToJson(IntensityInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'type': instance.type,
      'recordDate': instance.recordDate,
    };
