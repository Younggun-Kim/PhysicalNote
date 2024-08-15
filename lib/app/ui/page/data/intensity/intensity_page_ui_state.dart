import 'package:physical_note/app/config/constant/workout_type.dart';

/// 운동 강도 Ui State
class IntensityPageUiState {
  int? id;
  int hour;
  int minute;
  int? level;
  WorkoutType type;

  /// 선택 완료 여부.
  bool get isEnabled => _isEnabled();

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

  /// enabled 여부.
  bool _isEnabled() {
    return (level != null) && _hasTimeSelected();
  }

  /// 시간 선택 여부 판단.
  bool _hasTimeSelected() {
    if (hour > 0) {
      return true;
    } else if (minute >= 1) {
      return true;
    } else {
      return false;
    }
  }
}
