import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';
import 'package:physical_note/app/ui/page/history/wellness/history_wellness_controller.dart';
import 'package:physical_note/app/ui/page/history/wellness/item/history_wellness_item.dart';

extension HistoryWellnessItemUiMapper on HistoryWellnessController {
  /// 웰리니스 목록 아이템 매핑
  HistoryWellnessItemUiState? historyWellnessItemUiStateFrom(
      GetWellnessResponseModel model) {
    final id = model.id;
    final recordDate = model.recordDate;

    if (id == null || recordDate == null) {
      return null;
    }

    return HistoryWellnessItemUiState(
      id: id,
      recordDate: recordDate,
      sleep: model.sleep,
      stress: model.stress,
      fatigue: model.fatigue,
      muscleSoreness: model.muscleSoreness,
      urine: model.urine,
      emptyStomachWeight: model.emptyStomachWeight,
      bodyFat: model.bodyFat,
    );
  }
}
