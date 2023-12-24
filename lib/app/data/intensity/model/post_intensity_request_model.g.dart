// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_intensity_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostIntensityRequestModel _$PostIntensityRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostIntensityRequestModel(
      intensityLevel: json['intensityLevel'] as int?,
      workoutTime: json['workoutTime'] as String?,
      workoutType: json['workoutType'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$PostIntensityRequestModelToJson(
        PostIntensityRequestModel instance) =>
    <String, dynamic>{
      'intensityLevel': instance.intensityLevel,
      'workoutTime': instance.workoutTime,
      'workoutType': instance.workoutType,
      'recordDate': instance.recordDate,
    };
