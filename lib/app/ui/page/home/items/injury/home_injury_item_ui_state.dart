import 'package:physical_note/app/config/constant/index.dart';

/// 홈 부상현황 Ui State Type
class HomeInjuryItemUiState {
  final InjuryLevelType? injuryLevel;
  final MuscleType? muscle;
  final InjuryType injury;
  final String? comment;

  HomeInjuryItemUiState({
    required this.injuryLevel,
    required this.muscle,
    required this.injury,
    this.comment,
  });
}
