import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';

class HistoryInjuryItemUiState {
  final int id;
  final InjuryLevelType? injuryLevelType;
  final InjuryType? injuryType;
  final MuscleType? muscleType;
  final InjuryCheckDirectionType? direction;
  final InjuryCheckBodyPartsType? bodyPart;
  final String? recordDate;
  final String? comment;
  final bool? recoveryYn;
  final String? recoveryDate;

  HistoryInjuryItemUiState({
    required this.id,
    required this.injuryLevelType,
    required this.injuryType,
    required this.muscleType,
    required this.direction,
    required this.bodyPart,
    required this.recordDate,
    required this.comment,
    required this.recoveryYn,
    required this.recoveryDate,
  });
}
