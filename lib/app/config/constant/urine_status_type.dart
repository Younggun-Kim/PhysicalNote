import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

/// 소변 상태 타입 값.
enum UrineStatusType {
  none, // 정보 없음
  veryGood, // 매우 양호
  good, // 양호
  appropriate, // 적정
  demand, // 수분 섭취 요망
  recommended, // 수분 섭취 권장
  need, // 수분 섭취 필요
  emergency; // 수분 부족 위급

  /// String -> Type.
  static UrineStatusType typeFrom(String urineString) {
    if (urineString == StringRes.urineVeryGood.tr) {
      return UrineStatusType.veryGood;
    } else if (urineString == StringRes.urineGood.tr) {
      return UrineStatusType.veryGood;
    } else if (urineString == StringRes.urineAppropriate.tr) {
      return UrineStatusType.appropriate;
    } else if (urineString == StringRes.urineDemand.tr) {
      return UrineStatusType.demand;
    } else if (urineString == StringRes.urineRecommended.tr) {
      return UrineStatusType.recommended;
    } else if (urineString == StringRes.urineNeed.tr) {
      return UrineStatusType.need;
    } else if (urineString == StringRes.urineEmergency.tr) {
      return UrineStatusType.emergency;
    } else {
      return UrineStatusType.none;
    }
  }

  /// Type 색상으로 변경.
  Color toColor() {
    switch (this) {
      case UrineStatusType.veryGood:
        return ColorRes.urine1;
      case UrineStatusType.good:
        return ColorRes.urine2;
      case UrineStatusType.appropriate:
        return ColorRes.urine3;
      case UrineStatusType.demand:
        return ColorRes.urine4;
      case UrineStatusType.recommended:
        return ColorRes.urine5;
      case UrineStatusType.need:
        return ColorRes.urine6;
      case UrineStatusType.emergency:
        return ColorRes.urine7;
      default:
        return ColorRes.disable;
    }
  }

  /// Type -> String.
  @override
  String toString() {
    super.toString();
    switch (this) {
      case UrineStatusType.veryGood:
        return StringRes.urineVeryGood.tr;
      case UrineStatusType.good:
        return StringRes.urineGood.tr;
      case UrineStatusType.appropriate:
        return StringRes.urineAppropriate.tr;
      case UrineStatusType.demand:
        return StringRes.urineDemand.tr;
      case UrineStatusType.recommended:
        return StringRes.urineRecommended.tr;
      case UrineStatusType.need:
        return StringRes.urineNeed.tr;
      case UrineStatusType.emergency:
        return StringRes.urineEmergency.tr;
      default:
        return StringRes.urineNone.tr;
    }
  }
}
