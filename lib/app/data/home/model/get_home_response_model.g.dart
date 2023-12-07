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
      riskInfoModel: json['riskInfoModel'] == null
          ? null
          : RiskInfoModel.fromJson(
              json['riskInfoModel'] as Map<String, dynamic>),
      urineInfoModel: json['urineInfoModel'] == null
          ? null
          : UrineInfoModel.fromJson(
              json['urineInfoModel'] as Map<String, dynamic>),
      userSimpleInfo: json['userSimpleInfo'] == null
          ? null
          : UserSimpleInfoModel.fromJson(
              json['userSimpleInfo'] as Map<String, dynamic>),
      weekIntensityGraph: json['weekIntensityGraph'] == null
          ? null
          : WeekIntensityGraphModel.fromJson(
              json['weekIntensityGraph'] as Map<String, dynamic>),
      workoutInfo: json['workoutInfo'] == null
          ? null
          : WorkoutInfoModel.fromJson(
              json['workoutInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetHomeResponseModelToJson(
        GetHomeResponseModel instance) =>
    <String, dynamic>{
      'hooperIndexInfo': instance.hooperIndexInfo,
      'intensityInfo': instance.intensityInfo,
      'monthIntensityGraph': instance.monthIntensityGraph,
      'recordDate': instance.recordDate,
      'riskInfoModel': instance.riskInfoModel,
      'urineInfoModel': instance.urineInfoModel,
      'userSimpleInfo': instance.userSimpleInfo,
      'weekIntensityGraph': instance.weekIntensityGraph,
      'workoutInfo': instance.workoutInfo,
    };
