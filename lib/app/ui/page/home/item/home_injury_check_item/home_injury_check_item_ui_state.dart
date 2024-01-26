import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';

/// 홈 부상체크 아이템 UIState.
class HomeInjuryCheckItemUiState {
  final int id;
  final String? injuryLevelTypeString;
  final InjuryLevelType? injuryLevelType;
  final InjuryType? injuryType;
  final MuscleType? muscleType;
  final InjuryCheckDirectionType? direction;
  final InjuryCheckBodyPartsType? bodyPart;
  final String? recordDate;
  final String? comment;

  HomeInjuryCheckItemUiState({
    required this.id,
    required this.injuryType,
    required this.injuryLevelType,
    required this.injuryLevelTypeString,
    required this.recordDate,
    required this.comment,
    required this.muscleType,
    required this.bodyPart,
    required this.direction,
  });
}
