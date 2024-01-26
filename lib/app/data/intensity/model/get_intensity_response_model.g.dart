// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_intensity_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetIntensityListResponseModel _$GetIntensityListResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetIntensityListResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              GetIntensityResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetIntensityListResponseModelToJson(
        GetIntensityListResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

GetIntensityResponseModel _$GetIntensityResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetIntensityResponseModel(
      id: json['id'] as int?,
      intensityType: json['intensityType'] as int?,
      workoutTime: json['workoutTime'] as String?,
      workoutType: json['workoutType'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$GetIntensityResponseModelToJson(
        GetIntensityResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intensityType': instance.intensityType,
      'workoutTime': instance.workoutTime,
      'workoutType': instance.workoutType,
      'recordDate': instance.recordDate,
    };
