import 'package:flutter/material.dart';
import 'package:physical_note/app/config/constant/urine_status_type.dart';
import 'package:physical_note/app/data/home/model/home_model.dart';
import 'package:physical_note/app/config/constant/hooper_index_status.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/home/model/home_statistics_chart_item_model.dart';
import 'package:physical_note/app/ui/page/home/model/home_statistics_chart_model.dart';
import 'package:physical_note/app/utils/extensions/list_extension.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

import 'item/home_workout_intensity_chart/home_workout_intensity_chart_ui_state.dart';
import 'model/home_urine_model.dart';

extension HomeUiMapper on HomeController {
  void setScreenData(GetHomeResponseModel data) {
    userName.value = data.userSimpleInfo?.name ?? "";
    userClub.value = data.userSimpleInfo?.teamName ?? "";
    userClubCoach.value = data.userSimpleInfo?.teamCoachName ?? "";
    userImageUrl.value = data.userSimpleInfo?.profile ?? Assets.userDefault;
    hooperIndexData.value = setHooperIndexDataFrom(data.hooperIndexInfo);
    urineData.value = setHomeUrineModelFrom(data.urineInfo);
    workoutIntensityList.value =
        setHomeWorkoutIntensityChartUiStateFrom(data.intensityInfo);
    weeklyDataList.value =
        setHomeStatisticsWeeklyDataFrom(data.weekIntensityGraph);
    monthlyDataList.value =
        setHomeStatisticsMonthlyFrom(data.monthIntensityGraph);
  }

  /// 후퍼인덱스 매핑
  HooperIndexData? setHooperIndexDataFrom(HooperIndexInfoModel? remoteData) {
    final data = remoteData;

    if (data == null) {
      return null;
    }

    return HooperIndexData(
      sleep: HooperIndexStatus.changeFrom(data.sleep),
      stress: HooperIndexStatus.changeFrom(data.stress),
      fatigue: HooperIndexStatus.changeFrom(data.fatigue),
      musclePain: HooperIndexStatus.changeFrom(data.muscleSoreness),
    );
  }

  /// 소변검사 매핑
  HomeUrineModel? setHomeUrineModelFrom(UrineInfoModel? remoteData) {
    final data = remoteData;
    final urineId = data?.id;

    logger.w("remoteData : $remoteData");

    if (data == null || urineId == null) {
      return null;
    }

    return HomeUrineModel(
      id: urineId,
      weight: data.weight?.toInt() ?? 0,
      differenceFat: data.differenceFat?.toInt() ?? 0,
      urine: UrineStatusType.typeFrom(data.urine ?? ""),
    );
  }

  /// 운동강도 매핑
  List<HomeWorkoutIntensityChartUiState>
      setHomeWorkoutIntensityChartUiStateFrom(
          List<IntensityInfoModel>? remoteData) {
    var data = remoteData;

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data
          .map(
            (e) => HomeWorkoutIntensityChartUiState(
              name: e.type ?? "",
              value: e.level?.toDouble() ?? 0.0,
            ),
          )
          .toList();
    }
  }

  /// 통계 - 주간 매핑
  List<HomeStatisticsChartModel> setHomeStatisticsWeeklyDataFrom(
      List<WeekIntensityGraphModel>? remoteData) {
    var data = remoteData;
    if (data == null || data.isEmpty) {
      return [];
    } else {
      final sportChartData = _weeklyRawToHomeHomeStatisticsModel(
          remoteData: data, type: "스포츠", color: ColorRes.intensityLine1);
      final physicalChartData = _weeklyRawToHomeHomeStatisticsModel(
          remoteData: data, type: "피지컬", color: ColorRes.wellness1);

      var result = <HomeStatisticsChartModel>[];

      if (sportChartData.list.isNotEmpty) {
        result.add(sportChartData);
      }

      if (physicalChartData.list.isNotEmpty) {
        result.add(physicalChartData);
      }

      return result;
    }
  }

  /// 통계 - 월간 매핑.
  List<HomeStatisticsChartModel> setHomeStatisticsMonthlyFrom(
      List<MonthIntensityGraphModel>? remoteData) {
    var data = remoteData;
    if (data == null || data.isEmpty) {
      return [];
    } else {
      final sportChartData = _monthlyRawToHomeHomeStatisticsModel(
          remoteData: data, type: "스포츠", color: ColorRes.intensityLine1);
      final physicalChartData = _monthlyRawToHomeHomeStatisticsModel(
          remoteData: data, type: "피지컬", color: ColorRes.wellness1);

      var result = <HomeStatisticsChartModel>[];

      if (sportChartData != null) {
        result.add(sportChartData);
      }
      if (physicalChartData != null) {
        result.add(physicalChartData);
      }

      return result;
    }
  }

  /// 주간 차트 데이터 -> 홈 모델로 변경.
  HomeStatisticsChartModel _weeklyRawToHomeHomeStatisticsModel({
    required List<WeekIntensityGraphModel> remoteData,
    required String type,
    required Color color,
  }) {
    final dataList = remoteData
        .mapWithIndex(
          (WeekIntensityGraphModel data, int index) {
            var itemId = data.id;
            if (itemId == null || data.type != type) {
              return null;
            } else {
              return HomeStatisticsChartItemModel(
                id: itemId,
                x: index.toDouble(),
                y: data.level?.toDouble() ?? 0,
                xName: data.xvalue ?? "",
              );
            }
          },
        )
        .whereType<HomeStatisticsChartItemModel>()
        .toList();

    return HomeStatisticsChartModel(
      list: dataList,
      lineColor: color,
    );
  }

  /// 월간 차트 데이터 -> 홈 모델로 변경.
  HomeStatisticsChartModel? _monthlyRawToHomeHomeStatisticsModel({
    required List<MonthIntensityGraphModel> remoteData,
    required String type,
    required Color color,
  }) {
    final dataList = remoteData
        .mapWithIndex(
          (MonthIntensityGraphModel data, int index) {
            var itemId = data.id;
            if (itemId == null || data.type != type) {
              return null;
            } else {
              return HomeStatisticsChartItemModel(
                id: itemId,
                x: index.toDouble(),
                y: data.level?.toDouble() ?? 0,
                xName: data.xvalue ?? "",
              );
            }
          },
        )
        .whereType<HomeStatisticsChartItemModel>()
        .toList();

    if (dataList.isEmpty) {
      return null;
    }

    return HomeStatisticsChartModel(
      list: dataList,
      lineColor: color,
    );
  }
}
