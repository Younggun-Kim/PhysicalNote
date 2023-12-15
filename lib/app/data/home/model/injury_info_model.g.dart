// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injury_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InjuryInfoModel _$InjuryInfoModelFromJson(Map<String, dynamic> json) =>
    InjuryInfoModel(
      id: json['id'] as int?,
      injuryType: json['injuryType'] as String?,
      muscleType: json['muscleType'] as String?,
      recordType: json['recordType'] as String?,
      injuryLevelType: json['injuryLevelType'] as String?,
      injuryLevelString: json['injuryLevelString'] as String?,
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$InjuryInfoModelToJson(InjuryInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'injuryType': instance.injuryType,
      'muscleType': instance.muscleType,
      'recordType': instance.recordType,
      'injuryLevelType': instance.injuryLevelType,
      'injuryLevelString': instance.injuryLevelString,
      'comment': instance.comment,
    };
