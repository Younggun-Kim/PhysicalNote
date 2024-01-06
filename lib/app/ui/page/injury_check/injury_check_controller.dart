// ignore_for_file: unnecessary_cast

import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/config/constant/pain_type.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check_args.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_pain_level.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class InjuryCheckController extends BaseController {
  final args = Get.arguments as InjuryCheckArgs;

  /// 부상 타입.
  final injuryType = InjuryType.nonContact.obs;

  /// 질병 텍스트 컨트롤러.
  final diseaseController = "".obsWithController;

  /// 앞/뒤.
  final directionType = (null as InjuryCheckDirectionType?).obs;

  /// 몸 타입.
  late final bodyType = (null as InjuryCheckBodyType?).obs
    ..listen((p0) {
      bodyPartsType.value = null;
    });

  /// 신체부위.
  late final bodyPartsType = (null as InjuryCheckBodyPartsType?).obs
    ..listen((p0) {
      selectedMuscleType.value = null;
    });

  /// 선택된 상세 근육.
  late final selectedMuscleType = (null as MuscleType?).obs;

  /// 상세 근육.
  late final muscles = CombineLatestStream([
    directionType.behaviorStream,
    bodyPartsType.behaviorStream,
  ], (values) {
    var direction = values[0];
    var bodyPartsType = values[1];

    if (direction == InjuryCheckDirectionType.front) {
      if (bodyPartsType == InjuryCheckBodyPartsType.body) {
        return MuscleType.getFrontBodyMuscles();
      } else if (bodyPartsType == InjuryCheckBodyPartsType.leftArm ||
          bodyPartsType == InjuryCheckBodyPartsType.rightArm) {
        return MuscleType.getFrontArmMuscles();
      } else if (bodyPartsType == InjuryCheckBodyPartsType.leftLeg ||
          bodyPartsType == InjuryCheckBodyPartsType.rightLeg) {
        return MuscleType.getFrontLegMuscles();
      }
    } else if (direction == InjuryCheckDirectionType.back) {
      if (bodyPartsType == InjuryCheckBodyPartsType.body) {
        return MuscleType.getBackBodyMuscles();
      } else if (bodyPartsType == InjuryCheckBodyPartsType.leftArm ||
          bodyPartsType == InjuryCheckBodyPartsType.rightArm) {
        return MuscleType.getBackArmMuscles();
      } else if (bodyPartsType == InjuryCheckBodyPartsType.leftLeg ||
          bodyPartsType == InjuryCheckBodyPartsType.rightLeg) {
        return MuscleType.getBackLegMuscles();
      }
    } else {}

    return <MuscleType>[];
  }).toObs([]);

  /// 통증 정도.
  final painLevel = InjuryPainLevel.level0.obs;

  /// 통증 양상.
  final painSymptom = PainType.none.obs;

  /// 통증 시기 - 간헐적, 일정함
  final painTimingIntermittent = (null as bool?).obs;

  /// 통증 시기 - 휴식기
  final painTimingRest = false.obs;

  /// 통증 시기 - 운동중.
  final painTimingWorkout = false.obs;

  /// 통증시기 - 부상 경위.
  final painTimingDescription = "".obsWithController;

  /// 부상 타입 클릭.
  void onPressedInjuryType(InjuryType type) {
    injuryType.value = type;
  }

  /// 앞/뒤 클릭.
  void onPressedDirectionType(InjuryCheckDirectionType type) {
    directionType.value = type;
  }

  /// 몸 클릭.
  void onPressedBodyType(InjuryCheckBodyType type) {
    bodyType.value = type;
  }

  /// 신체부위 클릭.
  void onPressedBodyPartsType(InjuryCheckBodyPartsType type) {
    bodyPartsType.value = type;
  }

  /// 상세근육 클릭.
  void onPressedMuscle(MuscleType type) {
    selectedMuscleType.value = type;
  }

  /// 통증 정도 변경.
  void onChangePainLevelSlide(double value) {
    switch (value) {
      case 0:
        painLevel.value = InjuryPainLevel.level0;
      case 1:
        painLevel.value = InjuryPainLevel.level1;
      case 2:
        painLevel.value = InjuryPainLevel.level2;
      case 3:
        painLevel.value = InjuryPainLevel.level3;
      case 4:
        painLevel.value = InjuryPainLevel.level4;
      case 5:
        painLevel.value = InjuryPainLevel.level5;
    }
  }

  /// 통증 양상 선택.
  void onPressedPainSymptom(PainType type) {
    painSymptom.value = type;
  }

  /// 통증시기 간헐적 클릭.
  void onPressedPainTimingIntermittent(bool isIntermittent) {
    painTimingIntermittent.value = isIntermittent;
  }

  /// 통증시기 휴식기 클릭.
  void onPressedPainTimingRest() {
    final newValue = !painTimingRest.value;
    painTimingRest.value = newValue;
  }

  /// 통증시기 운동중 클릭.
  void onPressedPainTimingWorkout() {
    final newValue = !painTimingWorkout.value;
    painTimingWorkout.value = newValue;
  }
}
