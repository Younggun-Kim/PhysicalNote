import 'package:json_annotation/json_annotation.dart';

part 'risk_info_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class RiskInfoModel {
  final int? id;
  final int? injuryLevel;
  final int? injuryPercent;
  final String? recordDate;

  RiskInfoModel({
    this.id,
    this.injuryLevel,
    this.injuryPercent,
    this.recordDate,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory RiskInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RiskInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RiskInfoModelToJson(this);
}
