// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_intensity_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostIntensityResponseModel _$PostIntensityResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostIntensityResponseModel(
      id: (json['id'] as num?)?.toInt(),
      intensityLevel: (json['intensityLevel'] as num?)?.toInt(),
      workoutTime: json['workoutTime'] as String?,
      workoutType: json['workoutType'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$PostIntensityResponseModelToJson(
        PostIntensityResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intensityLevel': instance.intensityLevel,
      'workoutTime': instance.workoutTime,
      'workoutType': instance.workoutType,
      'recordDate': instance.recordDate,
    };
