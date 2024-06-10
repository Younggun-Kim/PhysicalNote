// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injury_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InjuryResponseModel _$InjuryResponseModelFromJson(Map<String, dynamic> json) =>
    InjuryResponseModel(
      id: json['id'] as int?,
      injuryType: json['injuryType'] as String?,
      distinctionType: json['distinctionType'] as String?,
      bodyType: json['bodyType'] as String?,
      bodyPart: json['bodyPart'] as String?,
      muscleType: json['muscleType'] as String?,
      injuryLevelType: json['injuryLevelType'] as String?,
      injuryLevelString: json['injuryLevelString'] as String?,
      painCharacteristicList: (json['painCharacteristicList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      painTimes: (json['painTimes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      comment: json['comment'] as String?,
      recordDate: json['recordDate'] as String?,
      recoveryYn: json['recoveryYn'] as bool?,
    );

Map<String, dynamic> _$InjuryResponseModelToJson(
        InjuryResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'injuryType': instance.injuryType,
      'distinctionType': instance.distinctionType,
      'bodyType': instance.bodyType,
      'bodyPart': instance.bodyPart,
      'muscleType': instance.muscleType,
      'injuryLevelType': instance.injuryLevelType,
      'injuryLevelString': instance.injuryLevelString,
      'painCharacteristicList': instance.painCharacteristicList,
      'painTimes': instance.painTimes,
      'comment': instance.comment,
      'recordDate': instance.recordDate,
      'recoveryYn': instance.recoveryYn,
    };
