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
      fatigue: json['fatigue'] as int,
      muscleSoreness: json['muscleSoreness'] as int,
      sleep: json['sleep'] as int,
      stress: json['stress'] as int,
      urine: json['urine'] as int,
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
