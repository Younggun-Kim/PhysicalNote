// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskInfoModel _$RiskInfoModelFromJson(Map<String, dynamic> json) =>
    RiskInfoModel(
      id: json['id'] as int?,
      injuryLevel: json['injuryLevel'] as int?,
      injuryPercent: json['injuryPercent'] as int?,
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$RiskInfoModelToJson(RiskInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'injuryLevel': instance.injuryLevel,
      'injuryPercent': instance.injuryPercent,
      'recordDate': instance.recordDate,
    };
