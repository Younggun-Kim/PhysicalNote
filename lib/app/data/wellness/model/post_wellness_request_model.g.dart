// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_wellness_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostWellnessRequestModel _$PostWellnessRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostWellnessRequestModel(
      bodyFat: (json['bodyFat'] as num).toDouble(),
      emptyStomachWeight: (json['emptyStomachWeight'] as num).toDouble(),
      fatigue: (json['fatigue'] as num).toInt(),
      muscleSoreness: (json['muscleSoreness'] as num).toInt(),
      sleep: (json['sleep'] as num).toInt(),
      stress: (json['stress'] as num).toInt(),
      urine: (json['urine'] as num).toInt(),
      recordDate: json['recordDate'] as String,
    );

Map<String, dynamic> _$PostWellnessRequestModelToJson(
        PostWellnessRequestModel instance) =>
    <String, dynamic>{
      'bodyFat': instance.bodyFat,
      'emptyStomachWeight': instance.emptyStomachWeight,
      'fatigue': instance.fatigue,
      'muscleSoreness': instance.muscleSoreness,
      'sleep': instance.sleep,
      'stress': instance.stress,
      'urine': instance.urine,
      'recordDate': instance.recordDate,
    };
