import 'package:json_annotation/json_annotation.dart';
import 'package:physical_note/app/data/feedback/model/today_workout_item_model.dart';

import 'home_today_workout_item_model.dart';
import 'hooper_index_info_model.dart';
import 'injury_info_model.dart';
import 'intensity_info_model.dart';
import 'month_intensity_graph_model.dart';
import 'risk_info_model.dart';
import 'urine_info_model.dart';
import 'user_simple_info_model.dart';
import 'week_intensity_graph_model.dart';
import 'workout_info_model.dart';


part 'get_home_response_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class GetHomeResponseModel {
  final HooperIndexInfoModel? hooperIndexInfo;
  final List<IntensityInfoModel>? intensityInfo;
  final List<MonthIntensityGraphModel>? monthIntensityGraph;
  final String? recordDate;
  final RiskInfoModel? riskInfo;
  final UrineInfoModel? urineInfo;
  final UserSimpleInfoModel? userSimpleInfo;
  final List<WeekIntensityGraphModel>? weekIntensityGraph;
  final WorkoutInfoModel? workoutInfo;
  final List<InjuryInfoModel>? injuryInfo;
  final List<HomeTodayWorkoutItemModel>? todayWorkoutList;

  GetHomeResponseModel({
    this.hooperIndexInfo,
    this.intensityInfo,
    this.monthIntensityGraph,
    this.recordDate,
    this.riskInfo,
    this.urineInfo,
    this.userSimpleInfo,
    this.weekIntensityGraph,
    this.workoutInfo,
    this.injuryInfo,
    this.todayWorkoutList,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetHomeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetHomeResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetHomeResponseModelToJson(this);
}
