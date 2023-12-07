import 'package:json_annotation/json_annotation.dart';

part 'workout_info_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class WorkoutInfoModel {
  final int? id;
  final int? comparisonRoad;
  final int? comparisonTime;
  final int? workoutRoad;
  final String? workoutTime;
  final String? recordDate;

  WorkoutInfoModel({
    this.id,
    this.comparisonRoad,
    this.comparisonTime,
    this.workoutRoad,
    this.workoutTime,
    this.recordDate,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory WorkoutInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WorkoutInfoModelToJson(this);
}
