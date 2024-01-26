import 'package:json_annotation/json_annotation.dart';

part 'month_intensity_graph_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class MonthIntensityGraphModel {
  final int? id;
  final int? level;
  final String? type;
  final String? xvalue;

  MonthIntensityGraphModel({
    this.id,
    this.type,
    this.level,
    this.xvalue,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory MonthIntensityGraphModel.fromJson(Map<String, dynamic> json) =>
      _$MonthIntensityGraphModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MonthIntensityGraphModelToJson(this);
}
