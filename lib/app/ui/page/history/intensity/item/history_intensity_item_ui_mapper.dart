import 'package:physical_note/app/data/intensity/model/get_intensity_list_item_response_model.dart';
import 'package:physical_note/app/ui/page/history/intensity/history_intensity_controller.dart';
import 'package:physical_note/app/ui/page/history/intensity/item/history_intensity_item_ui_state.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:uuid/uuid.dart';

extension HistoryIntensityItemUiMapper on HistoryIntensityController {
  /// 웰리니스 목록 아이템 매핑
  HistoryIntensityItemUiState? historyIntensityItemUiStateFrom(
      GetIntensityListItemResponseModel model) {
    const uuid = Uuid();
    final id = uuid.v4();
    final recordDate = model.date?.toDate('yyyy-MM-dd');

    if (recordDate == null) {
      return null;
    }

    if(model.sports?.workoutTime == '00:01:00') {
      logger.i(LocalizationUtil.getDateStr(
        date: model.sports?.workoutTime ?? '',
        koFormat: "HH:mm",
        enFormat: "HH:mm",
        originFormat: "HH:mm:ss",
      ));
    }

    return HistoryIntensityItemUiState(
      id: id,
      sportLevel: model.sports?.intensityLevel,
      sportTime: model.sports?.workoutTime,
      physicalLevel: model.physical?.intensityLevel,
      physicalTime: model.physical?.workoutTime,
      recordDate: recordDate,
    );
  }
}
