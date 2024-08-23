// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intensity_workout_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntensityWorkoutResponseModel _$IntensityWorkoutResponseModelFromJson(
        Map<String, dynamic> json) =>
    IntensityWorkoutResponseModel(
      formattedWorkoutTime: json['formattedWorkoutTime'] as String?,
      intensityLevel: (json['intensityLevel'] as num?)?.toInt(),
      workoutTime: json['workoutTime'] as String?,
    );

Map<String, dynamic> _$IntensityWorkoutResponseModelToJson(
        IntensityWorkoutResponseModel instance) =>
    <String, dynamic>{
      'formattedWorkoutTime': instance.formattedWorkoutTime,
      'intensityLevel': instance.intensityLevel,
      'workoutTime': instance.workoutTime,
    };
