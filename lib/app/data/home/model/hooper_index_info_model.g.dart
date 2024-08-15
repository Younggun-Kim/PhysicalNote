// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hooper_index_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HooperIndexInfoModel _$HooperIndexInfoModelFromJson(
        Map<String, dynamic> json) =>
    HooperIndexInfoModel(
      id: (json['id'] as num?)?.toInt(),
      fatigue: json['fatigue'] as String?,
      muscleSoreness: json['muscleSoreness'] as String?,
      sleep: json['sleep'] as String?,
      stress: json['stress'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$HooperIndexInfoModelToJson(
        HooperIndexInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fatigue': instance.fatigue,
      'muscleSoreness': instance.muscleSoreness,
      'sleep': instance.sleep,
      'stress': instance.stress,
      'recordDate': instance.recordDate,
    };
