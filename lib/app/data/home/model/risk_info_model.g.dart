// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskInfoModel _$RiskInfoModelFromJson(Map<String, dynamic> json) =>
    RiskInfoModel(
      id: (json['id'] as num?)?.toInt(),
      injuryLevel: (json['injuryLevel'] as num?)?.toInt(),
      injuryPercent: (json['injuryPercent'] as num?)?.toInt(),
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$RiskInfoModelToJson(RiskInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'injuryLevel': instance.injuryLevel,
      'injuryPercent': instance.injuryPercent,
      'recordDate': instance.recordDate,
    };
