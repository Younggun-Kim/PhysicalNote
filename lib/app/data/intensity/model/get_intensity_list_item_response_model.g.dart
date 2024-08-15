// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_intensity_list_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetIntensityListItemResponseModel _$GetIntensityListItemResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetIntensityListItemResponseModel(
      date: json['date'] as String?,
      workoutType: json['workoutType'] as String?,
      physical: json['physical'] == null
          ? null
          : IntensityWorkoutResponseModel.fromJson(
              json['physical'] as Map<String, dynamic>),
      sports: json['sports'] == null
          ? null
          : IntensityWorkoutResponseModel.fromJson(
              json['sports'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetIntensityListItemResponseModelToJson(
        GetIntensityListItemResponseModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'workoutType': instance.workoutType,
      'physical': instance.physical,
      'sports': instance.sports,
    };
