import 'package:physical_note/app/config/constant/workout_type.dart';

/// 운동 강도 Ui State
class IntensityPageUiState {
  int? id;
  int hour;
  int minute;
  int? level;
  WorkoutType type;

  IntensityPageUiState({
    this.id,
    this.level,
    this.hour = 0,
    this.minute = 0,
    required this.type,
  });
}
