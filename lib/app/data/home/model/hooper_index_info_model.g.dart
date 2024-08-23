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
      fatigueValue: (json['fatigueValue'] as num?)?.toInt(),
      hooperIndex: (json['hooperIndex'] as num?)?.toInt(),
      muscleSorenessValue: (json['muscleSorenessValue'] as num?)?.toInt(),
      sleepValue: (json['sleepValue'] as num?)?.toInt(),
      stressValue: (json['stressValue'] as num?)?.toInt(),
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
      'fatigueValue': instance.fatigueValue,
      'hooperIndex': instance.hooperIndex,
      'muscleSorenessValue': instance.muscleSorenessValue,
      'sleepValue': instance.sleepValue,
      'stressValue': instance.stressValue,
    };
