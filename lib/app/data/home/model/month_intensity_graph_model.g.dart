// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_intensity_graph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthIntensityGraphModel _$MonthIntensityGraphModelFromJson(
        Map<String, dynamic> json) =>
    MonthIntensityGraphModel(
      id: json['id'] as int?,
      type: json['type'] as String?,
      level: json['level'] as int?,
      xvalue: json['xvalue'] as String?,
    );

Map<String, dynamic> _$MonthIntensityGraphModelToJson(
        MonthIntensityGraphModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'type': instance.type,
      'xvalue': instance.xvalue,
    };
