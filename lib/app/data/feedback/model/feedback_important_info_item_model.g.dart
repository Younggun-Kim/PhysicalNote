// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_important_info_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackImportantInfoItemModel _$FeedbackImportantInfoItemModelFromJson(
        Map<String, dynamic> json) =>
    FeedbackImportantInfoItemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      recordDate: json['recordDate'] as String?,
      workoutTime: json['workoutTime'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$FeedbackImportantInfoItemModelToJson(
        FeedbackImportantInfoItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'recordDate': instance.recordDate,
      'workoutTime': instance.workoutTime,
      'address': instance.address,
    };
