import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';
import 'package:physical_note/app/ui/page/wellness_detail/item/hooper_index_ui_state.dart';
import 'package:physical_note/app/ui/page/wellness_detail/wellness_detail.dart';

extension WellenssDetaiUiMapper on WellnessDetailController {
  /// 웰리니스 매퍼
  void setWellness(GetWellnessResponseModel? data) {
    hooperIndexUiState.value = HooperIndexUiState(
      sleep: _convertAndClampToRange(data?.sleep ?? 1),
      stress: _convertAndClampToRange(data?.stress ?? 1),
      fatigue: _convertAndClampToRange(data?.fatigue ?? 1),
      muscleSoreness: _convertAndClampToRange(data?.muscleSoreness ?? 1),
    );
    urineTable.value = _convertUrineTable(data?.urine ?? 0);
    urineWeight.value = data?.emptyStomachWeight?.toString() ?? "";
    urineBmi.value = data?.bodyFat?.toString() ?? "";
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

  /// 소변검사표 값으로 변환
  int _convertUrineTable(int x) {
    const int minLimit = 1;
    const int maxLimit = 7;

    int result = x;

    // 범위 제한
    if (result < minLimit) {
      result = minLimit;
    } else if (result > maxLimit) {
      result = maxLimit;
    }

    return result;
  }
}
