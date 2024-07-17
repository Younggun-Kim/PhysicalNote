// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_feedback_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFeedbackResponseModel _$GetFeedbackResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetFeedbackResponseModel(
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      todayFeedBack: json['todayFeedBack'] as String?,
      coachPhoneNo: json['coachPhoneNo'] as String?,
      importantInfo: (json['importantInfo'] as List<dynamic>?)
          ?.map((e) => FeedbackImportantInfoItemModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      todayWorkoutList: (json['todayWorkoutList'] as List<dynamic>?)
          ?.map(
              (e) => TodayWorkoutItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFeedbackResponseModelToJson(
        GetFeedbackResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'todayFeedBack': instance.todayFeedBack,
      'coachPhoneNo': instance.coachPhoneNo,
      'importantInfo': instance.importantInfo,
      'todayWorkoutList': instance.todayWorkoutList,
    };
