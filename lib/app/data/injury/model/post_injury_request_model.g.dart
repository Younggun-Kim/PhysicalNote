// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_injury_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostInjuryRequestModel _$PostInjuryRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostInjuryRequestModel(
      injuryType: json['injuryType'] as String?,
      distinctionType: json['distinctionType'] as String?,
      bodyType: json['bodyType'] as String?,
      bodyPart: json['bodyPart'] as String?,
      muscleType: json['muscleType'] as String?,
      injuryLevel: json['injuryLevel'] as String?,
      painCharacteristicList: (json['painCharacteristicList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      painTime: json['painTime'] as String?,
      comment: json['comment'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$PostInjuryRequestModelToJson(
        PostInjuryRequestModel instance) =>
    <String, dynamic>{
      'injuryType': instance.injuryType,
      'distinctionType': instance.distinctionType,
      'bodyType': instance.bodyType,
      'bodyPart': instance.bodyPart,
      'muscleType': instance.muscleType,
      'injuryLevel': instance.injuryLevel,
      'painCharacteristicList': instance.painCharacteristicList,
      'painTime': instance.painTime,
      'comment': instance.comment,
      'recordDate': instance.recordDate,
    };
