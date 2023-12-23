import 'package:physical_note/app/data/intensity/model/get_intensity_response_model.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/data/wellness/data_wellness_hooper_index_ui_state.dart';

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
  void setIntensity(GetIntensityResponseModel? data) {

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

}
