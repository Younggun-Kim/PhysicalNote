// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutInfoModel _$WorkoutInfoModelFromJson(Map<String, dynamic> json) =>
    WorkoutInfoModel(
      id: json['id'] as int,
      comparisonRoad: json['comparisonRoad'] as int?,
      comparisonTime: json['comparisonTime'] as int?,
      workoutRoad: json['workoutRoad'] as int?,
      workoutTime: json['workoutTime'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$WorkoutInfoModelToJson(WorkoutInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comparisonRoad': instance.comparisonRoad,
      'comparisonTime': instance.comparisonTime,
      'workoutRoad': instance.workoutRoad,
      'workoutTime': instance.workoutTime,
      'recordDate': instance.recordDate,
    };
