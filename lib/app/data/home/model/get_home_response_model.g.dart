// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_home_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHomeResponseModel _$GetHomeResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetHomeResponseModel(
      hooperIndexInfo: json['hooperIndexInfo'] == null
          ? null
          : HooperIndexInfoModel.fromJson(
              json['hooperIndexInfo'] as Map<String, dynamic>),
      intensityInfo: (json['intensityInfo'] as List<dynamic>?)
          ?.map((e) => IntensityInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthIntensityGraph: (json['monthIntensityGraph'] as List<dynamic>?)
          ?.map((e) =>
              MonthIntensityGraphModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recordDate: json['recordDate'] as String?,
      riskInfo: json['riskInfo'] == null
          ? null
          : RiskInfoModel.fromJson(json['riskInfo'] as Map<String, dynamic>),
      urineInfo: json['urineInfo'] == null
          ? null
          : UrineInfoModel.fromJson(json['urineInfo'] as Map<String, dynamic>),
      userSimpleInfo: json['userSimpleInfo'] == null
          ? null
          : UserSimpleInfoModel.fromJson(
              json['userSimpleInfo'] as Map<String, dynamic>),
      weekIntensityGraph: (json['weekIntensityGraph'] as List<dynamic>?)
          ?.map((e) =>
              WeekIntensityGraphModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      workoutInfo: json['workoutInfo'] == null
          ? null
          : WorkoutInfoModel.fromJson(
              json['workoutInfo'] as Map<String, dynamic>),
      injuryInfo: (json['injuryInfo'] as List<dynamic>?)
          ?.map((e) => InjuryInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      todayWorkoutList: (json['todayWorkoutList'] as List<dynamic>?)
          ?.map((e) =>
              HomeTodayWorkoutItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetHomeResponseModelToJson(
        GetHomeResponseModel instance) =>
    <String, dynamic>{
      'hooperIndexInfo': instance.hooperIndexInfo,
      'intensityInfo': instance.intensityInfo,
      'monthIntensityGraph': instance.monthIntensityGraph,
      'recordDate': instance.recordDate,
      'riskInfo': instance.riskInfo,
      'urineInfo': instance.urineInfo,
      'userSimpleInfo': instance.userSimpleInfo,
      'weekIntensityGraph': instance.weekIntensityGraph,
      'workoutInfo': instance.workoutInfo,
      'injuryInfo': instance.injuryInfo,
      'todayWorkoutList': instance.todayWorkoutList,
    };
