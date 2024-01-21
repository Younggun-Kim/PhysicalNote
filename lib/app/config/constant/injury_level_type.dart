import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

/// 부상 세기 타입.
enum InjuryLevelType {
  veryHighPain("VERY_HIGH_PAIN", 5),
  highPain("HIGH_PAIN", 4),
  injured("INJURED", 3),
  mildDiscomfort("MILD_DISCOMFORT", 2),
  moderatePain("MODERATE_PAIN", 1),
  noPain("NO_PAIN", 0);

  /// 서버 키.
  final String serverKey;

  /// 고통 수치.
  final int level;

  const InjuryLevelType(
    this.serverKey,
    this.level,
  );

  /// Key로 초기화
  static InjuryLevelType? from(String? key) =>
      values.firstWhereOrNull((element) => element.serverKey == key);

  /// Level로 초기화.
  static InjuryLevelType? fromLevel(int? level) =>
      values.firstWhereOrNull((element) => element.level == level);

  @override
  String toString() {
    switch (this) {
      case InjuryLevelType.veryHighPain:
        return StringRes.injuryLevelVeryHighPain.tr;
      case InjuryLevelType.highPain:
        return StringRes.injuryLevelHighPain.tr;
      case InjuryLevelType.injured:
        return StringRes.injuryLevelInjured.tr;
      case InjuryLevelType.mildDiscomfort:
        return StringRes.injuryLevelMildDiscomfort.tr;
      case InjuryLevelType.moderatePain:
        return StringRes.injuryLevelModeratePain.tr;
      case InjuryLevelType.noPain:
        return StringRes.injuryLevelNoPain.tr;
    }
  }

  Color toBackgroundColor() {
    switch (this) {
      case InjuryLevelType.veryHighPain:
        return ColorRes.intensity5;
      case InjuryLevelType.highPain:
        return ColorRes.intensity4;
      case InjuryLevelType.injured:
        return ColorRes.intensity3;
      case InjuryLevelType.mildDiscomfort:
        return ColorRes.intensity2;
      case InjuryLevelType.moderatePain:
        return ColorRes.intensity1;
      case InjuryLevelType.noPain:
        return ColorRes.intensity0;
    }
  }

  Color toBorderColor() {
    switch (this) {
      case InjuryLevelType.veryHighPain:
        return ColorRes.intensityLine5;
      case InjuryLevelType.highPain:
        return ColorRes.intensityLine4;
      case InjuryLevelType.injured:
        return ColorRes.intensityLine3;
      case InjuryLevelType.mildDiscomfort:
        return ColorRes.intensityLine2;
      case InjuryLevelType.moderatePain:
        return ColorRes.intensityLine1;
      case InjuryLevelType.noPain:
        return ColorRes.intensityLine0;
    }
  }

  /// 폰트 색상.
  Color toFontColor() {
    switch (this) {
      case InjuryLevelType.veryHighPain:
        return ColorRes.white;
      case InjuryLevelType.highPain:
        return ColorRes.white;
      case InjuryLevelType.injured:
        return ColorRes.white;
      case InjuryLevelType.mildDiscomfort:
        return ColorRes.fontBlack;
      case InjuryLevelType.moderatePain:
        return ColorRes.fontBlack;
      case InjuryLevelType.noPain:
        return ColorRes.fontBlack;
    }
  }

  /// 설명.
  String toDescription() {
    switch (this) {
      case InjuryLevelType.veryHighPain:
        return StringRes.injuryLevelVeryHighPainDescription.tr;
      case InjuryLevelType.highPain:
        return StringRes.injuryLevelHighPainDescription.tr;
      case InjuryLevelType.injured:
        return StringRes.injuryLevelInjuredDescription.tr;
      case InjuryLevelType.mildDiscomfort:
        return StringRes.injuryLevelMildDiscomfortDescription.tr;
      case InjuryLevelType.moderatePain:
        return StringRes.injuryLevelModeratePainDescription.tr;
      case InjuryLevelType.noPain:
        return StringRes.injuryLevelNoPainDescription.tr;
    }
  }
}
