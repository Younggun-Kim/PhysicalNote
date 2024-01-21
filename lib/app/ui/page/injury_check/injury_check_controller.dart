// ignore_for_file: unnecessary_cast

import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/config/constant/pain_type.dart';
import 'package:physical_note/app/resources/assets/assets.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check_args.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'injury_check_pain_symptom_ui_state.dart';

class InjuryCheckController extends BaseController {
  final args = Get.arguments as InjuryCheckArgs;

  /// 부상 타입.
  final injuryType = InjuryType.nonContact.obs;

  /// 질병 텍스트 컨트롤러.
  final diseaseController = "".obsWithController;

  /// 앞/뒤.
  late final directionType = (null as InjuryCheckDirectionType?).obs
    ..listen((p0) {
      _setMuscleSvgStringFrom();
    });

  /// 몸 타입.
  late final bodyType = (null as InjuryCheckBodyType?).obs
    ..listen((p0) {
      bodyPartsType.value = null;
    });

  /// 신체부위.
  late final bodyPartsType = (null as InjuryCheckBodyPartsType?).obs
    ..listen((p0) {
      selectedMuscleType.value = null;
      _setMuscleSvgStringFrom();
    });

  /// 선택된 상세 근육.
  late final selectedMuscleType = (null as MuscleType?).obs
    ..listen((p0) {
      _setMuscleSvgStringFrom();
    });

  /// 근육 이미지.
  final muscleImage = "".obs;

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
  final painLevel = InjuryLevelType.noPain.obs;

  /// 통증 양상.
  final painSymptoms = PainType.values
      .map((e) => InjuryCheckPainSymptomUiState(type: e))
      .toList()
      .obs;

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
  void onPressedBodyPartsType(InjuryCheckBodyPartsType type) async {
    bodyPartsType.value = type;
  }

  /// 상세근육 클릭.
  void onPressedMuscle(MuscleType type) {
    selectedMuscleType.value = type;
  }

  /// 통증 정도 변경.
  void onChangePainLevelSlide(double value) {
    painLevel.value =
        InjuryLevelType.fromLevel(value.toInt()) ?? InjuryLevelType.noPain;
  }

  /// 통증 양상 선택(다중 선택 가능).
  void onPressedPainSymptom(InjuryCheckPainSymptomUiState selectedItem) {
    final list = painSymptoms.toList();

    painSymptoms.value = list.map((e) {
      if (e.type == selectedItem.type) {
        e.isSelected = !e.isSelected;
      }
      return e;
    }).toList();
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

  /// Svg Path 색상 변경. - Path가 한줄일 때
  String changeSvgPathColor(String svgString, String pathId, String color) {
    var svgList = svgString.split("\n");

    logger.i(svgList);
    var pathIndex =
        svgList.indexWhere((element) => element.contains('id="$pathId"'));
    var pathString = svgList[pathIndex];
    var colorIndex = pathString.indexOf('fill="#');

    if (colorIndex == -1) {
      return "";
    }

    final startIndex = colorIndex + 7;
    final endIndex = colorIndex + 13;
    final colorChangedPath =
        pathString.replaceRange(startIndex, endIndex, color);
    svgList[pathIndex] = colorChangedPath;

    return svgList.join("\n");
  }

  /// 근육 Svg String 설정.
  void _setMuscleSvgStringFrom() async {
    final direction = directionType.value;
    final partsType = bodyPartsType.value;

    var asset = "";

    if (direction == InjuryCheckDirectionType.front) {
      if (partsType == InjuryCheckBodyPartsType.body) {
        asset = Assets.muscleFrontBody;
      } else if (partsType == InjuryCheckBodyPartsType.leftArm) {
        asset = Assets.muscleFrontLeftArm;
      } else if (partsType == InjuryCheckBodyPartsType.rightArm) {
        asset = Assets.muscleFrontRightArm;
      } else if (partsType == InjuryCheckBodyPartsType.leftLeg) {
        asset = Assets.muscleFrontLeftLeg;
      } else if (partsType == InjuryCheckBodyPartsType.rightLeg) {
        asset = Assets.muscleFrontRightLeg;
      }
    } else if (direction == InjuryCheckDirectionType.back) {
      if (partsType == InjuryCheckBodyPartsType.body) {
        asset = Assets.muscleBackBody;
      } else if (partsType == InjuryCheckBodyPartsType.leftArm) {
        asset = Assets.muscleBackLeftArm;
      } else if (partsType == InjuryCheckBodyPartsType.rightArm) {
        asset = Assets.muscleBackRightArm;
      } else if (partsType == InjuryCheckBodyPartsType.leftLeg) {
        asset = Assets.muscleBackLeftLeg;
      } else if (partsType == InjuryCheckBodyPartsType.rightLeg) {
        asset = Assets.muscleBackRightLeg;
      }
    }

    var muscleImageString = "";

    if (asset.isNotEmpty) {
      const selectedMuscleColor = "E4FAC1";
      final muscleId = selectedMuscleType.value?.name;
      var svgString = await MuscleUtils.loadSvgFile(asset);

      if (muscleId != null) {
        svgString = MuscleUtils.changeSvgPathColor(
            svgString, muscleId, selectedMuscleColor);
      }

      muscleImageString = svgString;
    }

    muscleImage.value = muscleImageString;
  }

  /// 부상 체크 등록.
}
