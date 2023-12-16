import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

/// 부상 세기 타입.
enum InjuryLevelType {
  veryHighPain("VERY_HIGH_PAIN"),
  highPain("HIGH_PAIN"),
  injured("INJURED"),
  mildDiscomfort("MILD_DISCOMFORT"),
  moderatePain("MODERATE_PAIN"),
  noPain("NO_PAIN");

  final String? rawValue;

  const InjuryLevelType(this.rawValue);

  /// Key로 초기화
  static InjuryLevelType? from(String? rawValue) =>
      values.firstWhereOrNull((element) => element.rawValue == rawValue);

  @override
  String toString() {
    switch (this) {
      case InjuryLevelType.veryHighPain:
        return "매우 심한 통증";
      case InjuryLevelType.highPain:
        return "심한 통증";
      case InjuryLevelType.injured:
        return "부상 상태";
      case InjuryLevelType.mildDiscomfort:
        return "보통 통증";
      case InjuryLevelType.moderatePain:
        return "가벼운 통증";
      case InjuryLevelType.noPain:
        return "통증 없음";
    }
  }

  /// 고통 레벨.
  int toLevel() {
    switch (this) {
      case InjuryLevelType.veryHighPain:
        return 5;
      case InjuryLevelType.highPain:
        return 4;
      case InjuryLevelType.injured:
        return 3;
      case InjuryLevelType.mildDiscomfort:
        return 2;
      case InjuryLevelType.moderatePain:
        return 1;
      case InjuryLevelType.noPain:
        return 0;
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
}
