import 'package:physical_note/app/config/constant/workout_type.dart';

/// 운동 강도 Ui State
class IntensityPageUiState {
  int? id;
  int hour;
  int minute;
  int? level;
  WorkoutType type;

  /// 선택 완료 여부.
  bool get isEnabled => level != null;

  /// 시간 문자열.
  String get hourString => hour < 10 ? '0$hour' : hour.toString();

  /// 분 문자열.
  String get minuteString => minute < 10 ? '0$minute' : minute.toString();

  /// 시간
  String get time => "$hourString:$minuteString:00";

  IntensityPageUiState({
    this.id,
    this.level,
    this.hour = 0,
    this.minute = 0,
    required this.type,
  });
}
