// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_injury_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostInjuryResponseModel _$PostInjuryResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostInjuryResponseModel(
      id: (json['id'] as num?)?.toInt(),
      injuryType: json['injuryType'] as String?,
      distinctionType: json['distinctionType'] as String?,
      bodyType: json['bodyType'] as String?,
      bodyPart: json['bodyPart'] as String?,
      muscleType: json['muscleType'] as String?,
      injuryLevel: json['injuryLevel'] as String?,
      painCharacteristicList: (json['painCharacteristicList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      painTime: (json['painTime'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      comment: json['comment'] as String?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$PostInjuryResponseModelToJson(
        PostInjuryResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
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
