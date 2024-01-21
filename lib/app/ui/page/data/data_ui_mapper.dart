import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/config/constant/workout_type.dart';
import 'package:physical_note/app/data/injury/model/get_injury_response_model.dart';
import 'package:physical_note/app/data/intensity/model/get_intensity_response_model.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/data/wellness/data_wellness_hooper_index_ui_state.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

extension DataUiMapper on DataController {
  /// 웰리니스 매퍼
  void setWellness(GetWellnessResponseModel? data) {
    wellnessHooperIndexUiState.value = DataWellnessHooperIndexUiState(
      sleep: _convertAndClampToRange(data?.sleep ?? 1),
      stress: _convertAndClampToRange(data?.stress ?? 1),
      fatigue: _convertAndClampToRange(data?.fatigue ?? 1),
      muscleSoreness: _convertAndClampToRange(data?.muscleSoreness ?? 1),
    );
    wellnessUrineTable.value = _convertAndClampToRange(data?.urine ?? 1);
    wellnessUrineWeight.value = data?.emptyStomachWeight?.toString() ?? "";
    wellnessUrineBmi.value = data?.bodyFat.toString() ?? "";
  }

  /// 운동강도 매퍼.
  void setIntensity(GetIntensityListResponseModel? list) {
    final data = list?.data;
    if (data == null) {
      intensityHourController.jumpToItem(0);
      intensityMinuteController.jumpToItem(0);
      intensityWorkoutType.value = null;
    } else {
      final sportsData = data.firstWhereOrNull(
        (e) => e.workoutType == WorkoutType.sports.remote,
      );
      final physicalData = data.firstWhereOrNull(
        (e) => e.workoutType == WorkoutType.physical.remote,
      );

      var originSportsUiState = intensitySportsUiState.value;
      originSportsUiState.id = sportsData?.id;
      originSportsUiState.level = sportsData?.intensityType;
      originSportsUiState.hour = _convertTimeToHour(sportsData?.workoutTime);
      originSportsUiState.minute =
          _convertTimeToMinute(sportsData?.workoutTime);
      intensitySportsUiState.value = originSportsUiState;
      intensitySportsUiState.refresh();

      var originPhysicalUiState = intensityPhysicalUiState.value;
      originPhysicalUiState.id = physicalData?.id;
      originPhysicalUiState.level = physicalData?.intensityType;
      originPhysicalUiState.hour =
          _convertTimeToHour(physicalData?.workoutTime);
      originPhysicalUiState.minute =
          _convertTimeToMinute(physicalData?.workoutTime);
      intensityPhysicalUiState.value = originPhysicalUiState;
      intensityPhysicalUiState.refresh();

      /// 재선택 처리.
      intensityWorkoutType.refresh();
      updateIntensityWorkoutTime();
    }
  }

  /// 부상체크 매퍼
  void setInjury(GetInjuryResponseModel? data) {
    logger.i("부상체크 매퍼: ${data?.list}");

    injuryList.value = data?.list
            .map((e) {
              final injuryType = InjuryType.from(e.injuryType);
              final injuryLevel = InjuryLevelType.from(e.injuryLevelType);
              final muscleType = MuscleType.from(e.muscleType);

              if (injuryType == null) {
                return null;
              }
              return HomeInjuryCheckItemUiState(
                injuryType: injuryType,
                injuryLevelType: injuryLevel,
                injuryLevelTypeString: e.injuryLevelString,
                recordDate: e.recordDate,
                comment: e.comment,
                muscleType: muscleType,
              );
            })
            .whereType<HomeInjuryCheckItemUiState>()
            .toList() ??
        [];
  }

  /// 슬라이더에 맞게 변환
  double _convertAndClampToRange(int x) {
    const double minLimit = 1.0;
    const double maxLimit = 7.0;

    // int를 double로 변환
    double result = x.toDouble();

    // 범위 제한
    if (result < minLimit) {
      result = minLimit;
    } else if (result > maxLimit) {
      result = maxLimit;
    }

    return result;
  }

  /// HH:mm:ss의 시간 가져오기
  int _convertTimeToHour(String? time) {
    final splitTime = time?.split(":");
    if (splitTime != null && splitTime.isNotEmpty && splitTime.length == 3) {
      return int.tryParse(splitTime.first.toString()) ?? 0;
    } else {
      return 0;
    }
  }

  /// HH:mm:ss의 분 가져오기
  int _convertTimeToMinute(String? time) {
    final splitTime = time?.split(":");
    if (splitTime != null && splitTime.isNotEmpty && splitTime.length == 3) {
      return int.tryParse(splitTime[1].toString()) ?? 0;
    } else {
      return 0;
    }
  }
}
