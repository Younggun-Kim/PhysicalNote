import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/data/injury/model/injury_response_model.dart';
import 'package:physical_note/app/ui/page/history/injury/history_injury_controller.dart';
import 'package:physical_note/app/ui/page/history/injury/item/history_injury_item_ui_state.dart';
import 'package:physical_note/app/utils/muscle_utils.dart';

extension HistoryInjuryItemUiMapper on HistoryInjuryController {
  HistoryInjuryItemUiState? historyInjuryItemUiStateFrom(
      InjuryResponseModel model) {
    final id = model.id;
    final recordDate = model.recordDate;

    if (id == null || recordDate == null) {
      return null;
    }
    final muscleType = MuscleType.from(model.muscleType);
    final direction = DistinctionType.from(model.distinctionType);
    final bodyPart = BodyPartsType.from(model.bodyPart);
    return HistoryInjuryItemUiState(
      id: id,
      injuryLevelType: InjuryLevelType.from(model.injuryLevelType),
      injuryType: InjuryType.from(model.injuryType),
      muscleType: muscleType,
      direction: direction,
      bodyPart: bodyPart,
      comment: model.comment,
      recordDate: recordDate,
      recoveryYn: model.recoveryYn,
      recoveryDate: model.recoveryDate,
      muscleImage: MuscleUtils.getMusclePartAsset(
        muscleType,
        direction,
        bodyPart,
      ) ?? '',
    );
  }
}
