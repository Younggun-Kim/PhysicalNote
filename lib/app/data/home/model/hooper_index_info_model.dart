import 'package:json_annotation/json_annotation.dart';

part 'hooper_index_info_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class HooperIndexInfoModel {
  final int? id;
  final String? fatigue;
  final String? muscleSoreness;
  final String? sleep;
  final String? stress;
  final String? recordDate;
  final int? fatigueValue;
  final int? hooperIndex;
  final int? muscleSorenessValue;
  final int? sleepValue;
  final int? stressValue;

  HooperIndexInfoModel({
    this.id,
    this.fatigue,
    this.muscleSoreness,
    this.sleep,
    this.stress,
    this.recordDate,
    this.fatigueValue,
    this.hooperIndex,
    this.muscleSorenessValue,
    this.sleepValue,
    this.stressValue,

  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory HooperIndexInfoModel.fromJson(Map<String, dynamic> json) =>
      _$HooperIndexInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HooperIndexInfoModelToJson(this);
}
