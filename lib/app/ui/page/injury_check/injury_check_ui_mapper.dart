// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/config/constant/pain_type.dart';
import 'package:physical_note/app/data/injury/model/injury_response_model.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';

extension InjuryCheckUiMapper on InjuryCheckController {
  void setScreen(InjuryResponseModel remoteData) {
    final _injuryType = InjuryType.from(remoteData.injuryType);

    if (_injuryType == null) {
      return;
    }

    injuryType.value = _injuryType;

    /// 앞/뒤
    final _directionType =
        InjuryCheckDirectionType.from(remoteData.distinctionType);
    if (_directionType == null) {
      return;
    }
    directionType.value = _directionType;

    /// 상/하체
    final _bodyType = InjuryCheckBodyType.from(remoteData.bodyType);
    if (_bodyType == null) {
      return;
    }
    bodyType.value = _bodyType;

    /// 부위
    final _bodyPartsType = InjuryCheckBodyPartsType.from(remoteData.bodyPart);
    if (_bodyPartsType == null) {
      return;
    }
    bodyPartsType.value = _bodyPartsType;

    /// 상세 근육.
    final _muscleType = MuscleType.from(remoteData.muscleType);
    if (_muscleType == null) {
      return;
    }
    selectedMuscleType.value = _muscleType;

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

    /// 질병, 부경위
    diseaseController.value = remoteData.comment ?? "";
    painTimingDescription.value = remoteData.comment ?? "";
  }
}
