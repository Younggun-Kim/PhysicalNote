import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:physical_note/app/config/constant/urine_status_type.dart';
import 'package:physical_note/app/data/home/model/home_model.dart';
import 'package:physical_note/app/config/constant/hooper_index_status.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/home/model/home_statistics_chart_item_model.dart';
import 'package:physical_note/app/ui/page/home/model/home_statistics_chart_model.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

import 'home_constant.dart';
import 'item/home_training_balance_item/home_training_balance_type.dart';
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
    workoutTodayTime.value = data.workoutInfo?.todayWorkoutTime ?? "";
    workoutYesterdayCompareTime.value =
        data.workoutInfo?.yesterdayCompareTime ?? "";
    workoutThisWeek.value = data.workoutInfo?.thisWeekWorkoutRoad ?? 0;
    workoutThisWeekStatus.value =
        HomeTrainingBalanceType.from(data.workoutInfo?.thisWeekWorkoutRoadString);
    workoutLastWeek.value = data.workoutInfo?.lastWeekWorkoutRoad ?? 0;
    workoutLastWeekStatus.value =
        HomeTrainingBalanceType.from(data.workoutInfo?.lastWeekWorkoutRoadString);
    workoutLastFourWeek.value = data.workoutInfo?.lastFourWeekWorkoutRoad ?? 0;
    workoutLastFourWeekStatus.value = HomeTrainingBalanceType.from(
        data.workoutInfo?.lastFourWeekWorkoutRoadString);
    workoutLastEightWeek.value =
        data.workoutInfo?.lastEightWeekWorkoutRoad ?? 0;
    workoutLastEightWeekStatus.value = HomeTrainingBalanceType.from(
        data.workoutInfo?.lastEightWeekWorkoutRoadString);
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
          remoteData: data,
          type: StringRes.sports.tr,
          color: ColorRes.intensityLine1);
      final physicalChartData = _weeklyRawToHomeHomeStatisticsModel(
          remoteData: data,
          type: StringRes.physical.tr,
          color: ColorRes.homePhysicalPurple);

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

  /// 통계 - 월간 매핑.
  List<HomeStatisticsChartModel> setHomeStatisticsMonthlyFrom(
      List<MonthIntensityGraphModel>? remoteData) {
    var data = remoteData;
    if (data == null || data.isEmpty) {
      return [];
    } else {
      final sportChartData = _monthlyRawToHomeHomeStatisticsModel(
          remoteData: data,
          type: StringRes.sports.tr,
          color: ColorRes.intensityLine1);
      final physicalChartData = _monthlyRawToHomeHomeStatisticsModel(
          remoteData: data,
          type: StringRes.physical.tr,
          color: ColorRes.homePhysicalPurple);

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
  HomeStatisticsChartModel? _weeklyRawToHomeHomeStatisticsModel({
    required List<WeekIntensityGraphModel> remoteData,
    required String type,
    required Color color,
  }) {
    final dataList = remoteData
        .where((element) => element.type == type)
        .map((data) {
          final itemId = data.id;
          final x = _weeklyXValeToDouble(data.xvalue);
          if (itemId == null || x == null) {
            return null;
          } else {
            return HomeStatisticsChartItemModel(
                id: itemId, x: x, y: data.level?.toDouble() ?? 0);
          }
        })
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

  /// 주간 X Value 매핑
  double? _weeklyXValeToDouble(String? xValue) {
    if (xValue?.contains("일요일") == true) {
      return 0;
    } else if (xValue?.contains("월요일") == true) {
      return 1;
    } else if (xValue?.contains("화요일") == true) {
      return 2;
    } else if (xValue?.contains("수요일") == true) {
      return 3;
    } else if (xValue?.contains("목요일") == true) {
      return 4;
    } else if (xValue?.contains("금요일") == true) {
      return 5;
    } else if (xValue?.contains("토요일") == true) {
      return 6;
    } else {
      return null;
    }
  }

  /// 월간 차트 데이터 -> 홈 모델로 변경.
  HomeStatisticsChartModel? _monthlyRawToHomeHomeStatisticsModel({
    required List<MonthIntensityGraphModel> remoteData,
    required String type,
    required Color color,
  }) {
    final dataList = remoteData
        .where((element) => element.type == type)
        .map((data) {
          final month = myStateDate.value.month;
          final remoteDataDate = DateFormat('yyyy-MM').parse(data.xvalue ?? "");
          final remoteDataMonth = remoteDataDate.month;
          final index =
              max(0, remoteDataMonth - month + HomeConstant.monthMaxXLength);

          return HomeStatisticsChartItemModel(
              id: 0,
              x: index.toDouble(),
              y: data.level?.toDouble() ?? 0,
              xName: data.xvalue ?? "");
        })
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
