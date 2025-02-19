// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutInfoModel _$WorkoutInfoModelFromJson(Map<String, dynamic> json) =>
    WorkoutInfoModel(
      recordDate: json['recordDate'] as String?,
      todayWorkoutTime: json['todayWorkoutTime'] as String?,
      yesterdayCompareTime: json['yesterdayCompareTime'] as String?,
      thisWeekWorkoutRoad: (json['thisWeekWorkoutRoad'] as num?)?.toInt(),
      thisWeekWorkoutRoadString: json['thisWeekWorkoutRoadString'] as String?,
      lastWeekWorkoutRoad: (json['lastWeekWorkoutRoad'] as num?)?.toInt(),
      lastWeekWorkoutRoadString: json['lastWeekWorkoutRoadString'] as String?,
      lastFourWeekWorkoutRoad:
          (json['lastFourWeekWorkoutRoad'] as num?)?.toInt(),
      lastFourWeekWorkoutRoadString:
          json['lastFourWeekWorkoutRoadString'] as String?,
      lastEightWeekWorkoutRoad:
          (json['lastEightWeekWorkoutRoad'] as num?)?.toInt(),
      lastEightWeekWorkoutRoadString:
          json['lastEightWeekWorkoutRoadString'] as String?,
      isWorkoutSportNotificationRead:
          json['isWorkoutSportNotificationRead'] as bool?,
      isWorkoutPhysicalNotificationRead:
          json['isWorkoutPhysicalNotificationRead'] as bool?,
    );

Map<String, dynamic> _$WorkoutInfoModelToJson(WorkoutInfoModel instance) =>
    <String, dynamic>{
      'recordDate': instance.recordDate,
      'todayWorkoutTime': instance.todayWorkoutTime,
      'yesterdayCompareTime': instance.yesterdayCompareTime,
      'thisWeekWorkoutRoad': instance.thisWeekWorkoutRoad,
      'thisWeekWorkoutRoadString': instance.thisWeekWorkoutRoadString,
      'lastWeekWorkoutRoad': instance.lastWeekWorkoutRoad,
      'lastWeekWorkoutRoadString': instance.lastWeekWorkoutRoadString,
      'lastFourWeekWorkoutRoad': instance.lastFourWeekWorkoutRoad,
      'lastFourWeekWorkoutRoadString': instance.lastFourWeekWorkoutRoadString,
      'lastEightWeekWorkoutRoad': instance.lastEightWeekWorkoutRoad,
      'lastEightWeekWorkoutRoadString': instance.lastEightWeekWorkoutRoadString,
      'isWorkoutSportNotificationRead': instance.isWorkoutSportNotificationRead,
      'isWorkoutPhysicalNotificationRead':
          instance.isWorkoutPhysicalNotificationRead,
    };
