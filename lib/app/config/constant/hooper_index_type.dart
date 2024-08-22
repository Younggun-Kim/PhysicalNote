import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

/// 후퍼 인덱스 타입.
enum HooperIndexType {
  sleep,
  stress,
  fatigue,
  muscleSoreness;

  @override
  String toString() {
    switch (this) {
      case HooperIndexType.sleep:
        return StringRes.sleep.tr;
      case HooperIndexType.stress:
        return StringRes.stress.tr;
      case HooperIndexType.fatigue:
        return StringRes.fatigue.tr;
      case HooperIndexType.muscleSoreness:
        return StringRes.musclePain.tr;
    }
  }
}
