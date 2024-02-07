import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';

class TestUtils {
  static const imageUrl = "https://picsum.photos/200/300";

  static get humanFrontList => _humanFrontList();

  /// 사람 앞모습 부상 목록.
  static List<HomeInjuryCheckItemUiState> _humanFrontList() {
    const direction = InjuryCheckDirectionType.front;

    final frontBodyInjuryList = _muscleToInjury(
      MuscleType.getFrontBodyMuscles(),
      direction,
      InjuryCheckBodyPartsType.body,
    );

    final frontLeftArmInjuryList = _muscleToInjury(
      MuscleType.getFrontArmMuscles(),
      direction,
      InjuryCheckBodyPartsType.leftArm,
    );

    final frontRightArmInjuryList = _muscleToInjury(
      MuscleType.getFrontArmMuscles(),
      direction,
      InjuryCheckBodyPartsType.rightArm,
    );

    final frontLeftLegInjuryList = _muscleToInjury(
      MuscleType.getFrontLegMuscles(),
      direction,
      InjuryCheckBodyPartsType.leftLeg,
    );

    final frontRightLegInjuryList = _muscleToInjury(
      MuscleType.getFrontLegMuscles(),
      direction,
      InjuryCheckBodyPartsType.rightLeg,
    );

    return [
      ...frontBodyInjuryList,
      ...frontLeftArmInjuryList,
      ...frontRightArmInjuryList,
      ...frontLeftLegInjuryList,
      ...frontRightLegInjuryList,
    ];
  }

  /// 근육 -> 부상으로 변경.
  static List<HomeInjuryCheckItemUiState> _muscleToInjury(
    List<MuscleType> list,
    InjuryCheckDirectionType direction,
    InjuryCheckBodyPartsType bodyPartsType,
  ) {
    return list
        .asMap()
        .entries
        .map((e) => HomeInjuryCheckItemUiState(
              id: e.key,
              injuryType: InjuryType.contact,
              direction: direction,
              bodyPart: bodyPartsType,
              muscleType: e.value,
              injuryLevelType: InjuryLevelType.values[0],
              injuryLevelTypeString: InjuryLevelType.values[0].toDescription(),
              recordDate: DateTime.now().toFormattedString("yyyy-MM-dd"),
              comment: "",
            ))
        .toList();
  }
}
