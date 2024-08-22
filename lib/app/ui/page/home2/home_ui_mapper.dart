import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/config/constant/urine_status_type.dart';
import 'package:physical_note/app/data/home/model/home_model.dart';
import 'package:physical_note/app/data/home/model/home_today_workout_item_model.dart';
import 'package:physical_note/app/data/home/model/injury_info_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home2/home_controller.dart';
import 'package:physical_note/app/ui/page/home2/items/injury/home_injury_item_ui_state.dart';
import 'package:physical_note/app/utils/extensions/list_extension.dart';

import 'items/today_training/home_today_training_item_ui_state.dart';

extension HomeUiMapper on HomeController {
  void setScreen(GetHomeResponseModel? model) {
    /// 유저
    userImage.value = model?.userSimpleInfo?.profile;
    userName.value = model?.userSimpleInfo?.name;
    userTeamAndCoach.value = model?.userSimpleInfo?.teamCoachName;

    /// 오늘의 훈련
    todayTrainingItems.value = _todayTrainingList(
      model?.todayWorkoutList,
    );

    /// 부상위험도
    riskDescription.value = _riskDescription(model?.riskInfo?.injuryLevel);
    riskValue.value = model?.riskInfo?.injuryLevel;
    riskPercent.value = model?.riskInfo?.injuryPercent;

    /// 웰리니스 - 후퍼인덱스
    hooperIndexAverage.value = model?.hooperIndexInfo?.hooperIndex;
    hooperIndexSleep.value = model?.hooperIndexInfo?.sleepValue;
    hooperIndexStress.value = model?.hooperIndexInfo?.stressValue;
    hooperIndexFatigue.value = model?.hooperIndexInfo?.fatigueValue;
    hooperIndexMuscleSoreness.value =
        model?.hooperIndexInfo?.muscleSorenessValue;

    /// 웰리니스 - 소변검사
    urine.value = UrineStatusType.typeFrom(model?.urineInfo?.urine);
    urineDescription.value = _urineDescription(model?.urineInfo);

    /// 웰리니스 - 공복몸무게
    emptyWeight.value = model?.urineInfo?.weight;
    differenceWeight.value = model?.urineInfo?.differenceFat;

    /// 웰리니스 - 체지방
    bmi.value = model?.urineInfo?.bodyFat;

    /// 운동강도
    // TODO: 시간 기준 필요
    intensityTime.value = _intensityTime(model?.intensityInfo);
    intensitySports.value = _intensityTypeValue(
      model?.intensityInfo,
      IntensityType.sports,
    );
    intensityPhysical.value = _intensityTypeValue(
      model?.intensityInfo,
      IntensityType.physical,
    );

    /// 부상현황
    // injuryList.value =[];
    injuryList.value = _injuryList(model?.injuryInfo);
  }

  /// 오늘의 훈련
  List<HomeTodayTrainingItemUiState> _todayTrainingList(
      List<HomeTodayWorkoutItemModel>? modelList) {
    if (modelList == null || modelList.isEmpty) {
      return [];
    }

    return modelList.compactMap((model) {
      final id = model.id;

      if (id == null) {
        return null;
      }

      return HomeTodayTrainingItemUiState(
        id: id,
        imageUrl: model.images?.first,
        name: model.workoutName,
        place: model.address,
        time: model.workoutTime,
      );
    }).toList();
  }

  /// 부상위험도 설명
  String _riskDescription(int? level) {
    if (level == null) {
      return StringRes.beCarefulWorkingOutToday.tr;
    } else if (level < 7) {
      return StringRes.risk7LessThan.tr;
    } else if (level >= 7 && level < 14) {
      return StringRes.risk7To14.tr;
    } else if (level >= 14 && level < 21) {
      return StringRes.risk14To21.tr;
    } else {
      return StringRes.risk21More.tr;
    }
  }

  /// 소변 데이터를 설명으로 변경
  String _urineDescription(UrineInfoModel? urineData) {
    final urine = UrineStatusType.typeFrom(urineData?.urine ?? '');
    final differenceFat = urineData?.differenceFat;

    if (urine == UrineStatusType.none || differenceFat == null) {
      return StringRes.dataNotAvailable.tr;
    }

    final differenceFatNum = double.parse(
      differenceFat.replaceAll(RegExp(r'[^\d.-]'), ''),
    );

    final isPositiveUrine = urine.isPositive();

    if (differenceFatNum >= 2) {
      return isPositiveUrine
          ? StringRes.urineWeightOverMoistureGood.tr
          : StringRes.urineWeightOverMoistureBad.tr;
    } else if (differenceFatNum <= -2) {
      return isPositiveUrine
          ? StringRes.urineWeightLessMoistureGood.tr
          : StringRes.urineWeightLessMoistureBad.tr;
    } else {
      return isPositiveUrine
          ? StringRes.urineWeightGoodMoistureGood.tr
          : StringRes.urineWeightGoodMoistureBad.tr;
    }
  }

  /// 운동강도 - 시간
  String? _intensityTime(List<IntensityInfoModel>? model) {
    return model
        ?.firstWhereOrNull((intensity) => intensity.recordDate != null)
        ?.recordDate;
  }

  /// 운동강도 - 타입에 따른 값 업ㄷ기
  double _intensityTypeValue(
    List<IntensityInfoModel>? model,
    IntensityType type,
  ) {
    final typeName = type.toKor;

    return model
            ?.firstWhereOrNull((intensity) => intensity.type == typeName)
            ?.level
            ?.toDouble() ??
        0;
  }

  /// 부상현황
  List<HomeInjuryItemUiState> _injuryList(List<InjuryInfoModel>? model) {
    return model?.compactMap(
          (injury) {
            final injuryLevel = InjuryLevelType.from(injury.injuryLevelType);
            final muscle = MuscleType.from(injury.muscleType);
            final injuryType = InjuryType.from(injury.injuryType);
            final comment = injury.comment;

            if (injuryType == InjuryType.disease) {
              if (injuryType == null || comment == null) {
                return null;
              }

              return HomeInjuryItemUiState(
                injuryLevel: null,
                muscle: null,
                injury: injuryType,
                comment: comment,
              );
            } else {
              if (injuryType == null || muscle == null || injuryLevel == null) {
                return null;

              }
              return HomeInjuryItemUiState(
                injuryLevel: injuryLevel,
                muscle: muscle,
                injury: injuryType,
                comment: '',
              );
            }
          },
        ).toList() ??
        [];
  }
}
