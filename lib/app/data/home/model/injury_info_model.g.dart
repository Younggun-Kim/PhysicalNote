// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injury_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InjuryInfoModel _$InjuryInfoModelFromJson(Map<String, dynamic> json) =>
    InjuryInfoModel(
      id: json['id'] as int?,
      injuryType: json['injuryType'] as String?,
      distinctionType: json['distinctionType'] as String?,
      bodyType: json['bodyType'] as String?,
      bodyPart: json['bodyPart'] as String?,
      muscleType: json['muscleType'] as String?,
      recordDate: json['recordDate'] as String?,
      injuryLevelType: json['injuryLevelType'] as String?,
      injuryLevelString: json['injuryLevelString'] as String?,
      comment: json['comment'] as String?,
      recoveryYn: json['recoveryYn'] as bool?,
      recoveryDate: json['recoveryDate'] as String?,
    );

Map<String, dynamic> _$InjuryInfoModelToJson(InjuryInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'injuryType': instance.injuryType,
      'distinctionType': instance.distinctionType,
      'bodyType': instance.bodyType,
      'bodyPart': instance.bodyPart,
      'muscleType': instance.muscleType,
      'recordDate': instance.recordDate,
      'injuryLevelType': instance.injuryLevelType,
      'injuryLevelString': instance.injuryLevelString,
      'comment': instance.comment,
      'recoveryYn': instance.recoveryYn,
      'recoveryDate': instance.recoveryDate,
    };
