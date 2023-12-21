// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wellness_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWellnessResponseModel _$GetWellnessResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetWellnessResponseModel(
      id: json['id'] as int?,
      bodyFat: (json['bodyFat'] as num?)?.toDouble(),
      emptyStomachWeight: (json['emptyStomachWeight'] as num?)?.toDouble(),
      fatigue: json['fatigue'] as int?,
      muscleSoreness: json['muscleSoreness'] as int?,
      sleep: json['sleep'] as int?,
      stress: json['stress'] as int?,
      urine: json['urine'] as int?,
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
