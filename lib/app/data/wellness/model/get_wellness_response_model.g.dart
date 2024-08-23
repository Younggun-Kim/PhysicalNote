// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wellness_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWellnessResponseModel _$GetWellnessResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetWellnessResponseModel(
      id: (json['id'] as num?)?.toInt(),
      bodyFat: (json['bodyFat'] as num?)?.toDouble(),
      emptyStomachWeight: (json['emptyStomachWeight'] as num?)?.toDouble(),
      fatigue: (json['fatigue'] as num?)?.toInt(),
      muscleSoreness: (json['muscleSoreness'] as num?)?.toInt(),
      sleep: (json['sleep'] as num?)?.toInt(),
      stress: (json['stress'] as num?)?.toInt(),
      urine: (json['urine'] as num?)?.toInt(),
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$GetWellnessResponseModelToJson(
        GetWellnessResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bodyFat': instance.bodyFat,
      'emptyStomachWeight': instance.emptyStomachWeight,
      'fatigue': instance.fatigue,
      'muscleSoreness': instance.muscleSoreness,
      'sleep': instance.sleep,
      'stress': instance.stress,
      'urine': instance.urine,
      'recordDate': instance.recordDate,
    };
