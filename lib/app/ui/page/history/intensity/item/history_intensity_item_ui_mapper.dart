import 'package:physical_note/app/data/intensity/model/get_intensity_list_item_response_model.dart';
import 'package:physical_note/app/ui/page/history/intensity/history_intensity_controller.dart';
import 'package:physical_note/app/ui/page/history/intensity/item/history_intensity_item_ui_state.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
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

    return HistoryIntensityItemUiState(
      id: id,
      sportLevel: model.sports?.intensityLevel,
      sportTime: model.sports?.formattedWorkoutTime,
      physicalLevel: model.physical?.intensityLevel,
      physicalTime: model.physical?.formattedWorkoutTime,
      recordDate: recordDate,
    );
  }
}
