import 'package:json_annotation/json_annotation.dart';

part 'workout_info_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class WorkoutInfoModel {
  /// 기록 날짜
  final String? recordDate;

  /// 운동 시간.
  final String? todayWorkoutTime;

  /// 어제 운동 시간 비교 수치.
  final String? yesterdayCompareTime;

  /// 운동 부하 수치.
  final int? thisWeekWorkoutRoad;

  /// 운동 부하 정도
  final String? thisWeekWorkoutRoadString;

  /// 지난주 운동 부하 수치
  final int? lastWeekWorkoutRoad;

  /// 지난주 운동 부하 정도
  final String? lastWeekWorkoutRoadString;

  /// 지난 4주 운동 부하 수치
  final int? lastFourWeekWorkoutRoad;

  /// 지난 4주 운동 부하 정도
  final String? lastFourWeekWorkoutRoadString;

  /// 지난 8주 운동 부하 수치
  final int? lastEightWeekWorkoutRoad;

  /// 지난 8주 운동 부하 정도.
  final String? lastEightWeekWorkoutRoadString;

  WorkoutInfoModel({
    this.recordDate,
    this.todayWorkoutTime,
    this.yesterdayCompareTime,
    this.thisWeekWorkoutRoad,
    this.thisWeekWorkoutRoadString,
    this.lastWeekWorkoutRoad,
    this.lastWeekWorkoutRoadString,
    this.lastFourWeekWorkoutRoad,
    this.lastFourWeekWorkoutRoadString,
    this.lastEightWeekWorkoutRoad,
    this.lastEightWeekWorkoutRoadString,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory WorkoutInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WorkoutInfoModelToJson(this);
}
