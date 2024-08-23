// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:physical_note/app/config/constant/body_part_type.dart';
import 'package:physical_note/app/config/constant/body_type.dart';
import 'package:physical_note/app/config/constant/distinction_type.dart';
import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/config/constant/pain_type.dart';
import 'package:physical_note/app/data/injury/model/injury_response_model.dart';
import 'package:physical_note/app/ui/page/injury_detail/injury_detail.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

extension InjuryDetailUiMapper on InjuryDetailController {
  void setScreen(InjuryResponseModel remoteData) {
    final _injuryType = InjuryType.from(remoteData.injuryType);

    if (_injuryType == null) {
      return;
    }

    injuryType.value = _injuryType;

    /// 앞/뒤
    directionType.value = DistinctionType.from(remoteData.distinctionType);

    /// 상/하체
    bodyType.value = BodyType.from(remoteData.bodyType);

    /// 부위
    bodyPartsType.value = BodyPartsType.from(remoteData.bodyPart);

    /// 상세 근육.
    selectedMuscleType.value = MuscleType.from(remoteData.muscleType);

    /// 통증 정도.
    painLevel.value = InjuryLevelType.from(remoteData.injuryLevelType) ??
        InjuryLevelType.noPain;

    /// 통증 양상.
    final painTypes = remoteData.painCharacteristicList
        ?.map((element) {
          final painType = PainType.from(element);
          return painType;
        })
        .whereType<PainType>()
        .toList();

    if (painTypes != null && painTypes.isNotEmpty) {
      final newPainSymptomUiStates = painSymptoms.map((element) {
        final isSelected = painTypes.contains(element.type);
        element.isSelected = isSelected;
        return element;
      }).toList();

      painSymptoms.value = newPainSymptomUiStates;
    }

    /// 통증시기
    remoteData.painTimes?.forEach((element) {
      switch (element) {
        case 'INTERMITTENT':
          painTimingIntermittent.value = true;
        case 'CONSTANT':
          painTimingIntermittent.value = false;
        case 'REST':
          painTimingRest.value = true;
        case 'DURING_EXERCISE':
          painTimingWorkout.value = true;
        default:
          break;
      }
    });

    /// 질병, 부상경위
    diseaseController.value = remoteData.comment ?? "";
    painTimingDescription.value = remoteData.comment ?? "";

    /// 완치여부
    isRecovered.value = remoteData.recoveryYn == true;
  }
}
