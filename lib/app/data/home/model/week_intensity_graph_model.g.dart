// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_intensity_graph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekIntensityGraphModel _$WeekIntensityGraphModelFromJson(
        Map<String, dynamic> json) =>
    WeekIntensityGraphModel(
      id: json['id'] as int,
      type: json['type'] as String?,
      level: json['level'] as int?,
      xvalue: json['xvalue'] as String?,
    );

Map<String, dynamic> _$WeekIntensityGraphModelToJson(
        WeekIntensityGraphModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'type': instance.type,
      'xvalue': instance.xvalue,
    };
