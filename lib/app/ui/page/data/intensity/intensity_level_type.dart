import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

enum IntensityLevelType {
  veryEasy,
  easy,
  normal,
  hard,
  veryHard,
  over;

  /// 운동 강도.
  String toIntensity() {
    switch (this) {
      case veryEasy:
        return StringRes.intensityLevelVeryEasy.tr;
      case easy:
        return StringRes.intensityLevelEasy.tr;
      case normal:
        return StringRes.intensityLevelNormal.tr;
      case hard:
        return StringRes.intensityLevelHard.tr;
      case veryHard:
        return StringRes.intensityLevelVeryHard.tr;
      case over:
        return StringRes.intensityLevelOver.tr;
    }
  }

  /// 설명.
  String toDescription() {
    switch (this) {
      case veryEasy:
        return StringRes.intensityLevelVeryEasyDescription.tr;
      case easy:
        return StringRes.intensityLevelEasyDescription.tr;
      case normal:
        return StringRes.intensityLevelNormalDescription.tr;
      case hard:
        return StringRes.intensityLevelHardDescription.tr;
      case veryHard:
        return StringRes.intensityLevelVeryHardDescription.tr;
      case over:
        return StringRes.intensityLevelOverDescription.tr;
    }
  }

  /// Level -> IntensityLevelType;
  static IntensityLevelType? levelToIntensityLevelType(int level) {
    if (level < 1) {
      return veryEasy;
    } else if (level < 4) {
      return easy;
    } else if (level < 7) {
      return normal;
    } else if (level < 9) {
      return hard;
    } else if (level < 10) {
      return veryHard;
    } else if (level == 10) {
      return over;
    } else {
      return null;
    }
  }
}
