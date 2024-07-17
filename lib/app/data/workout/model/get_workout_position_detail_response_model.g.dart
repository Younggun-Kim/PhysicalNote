// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_workout_position_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWorkoutPositionDetailResponseModel
    _$GetWorkoutPositionDetailResponseModelFromJson(
            Map<String, dynamic> json) =>
        GetWorkoutPositionDetailResponseModel(
          id: (json['id'] as num).toInt(),
          workoutId: (json['workoutId'] as num).toInt(),
          name: json['name'] as String,
        );

Map<String, dynamic> _$GetWorkoutPositionDetailResponseModelToJson(
        GetWorkoutPositionDetailResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workoutId': instance.workoutId,
      'name': instance.name,
    };
