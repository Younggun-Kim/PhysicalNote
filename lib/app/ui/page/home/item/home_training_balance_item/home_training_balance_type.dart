import 'dart:ui';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

/// 홈 트레이닝 밸런스 타입.
enum HomeTrainingBalanceType {
  none,
  less,
  normal,
  over;

  static HomeTrainingBalanceType from(String? rawData) {
    if (rawData == "부족") {
      return HomeTrainingBalanceType.less;
    }
    if (rawData == "적절") {
      return HomeTrainingBalanceType.normal;
    }
    if (rawData == "과훈련") {
      return HomeTrainingBalanceType.over;
    } else {
      return HomeTrainingBalanceType.none;
    }
  }

  @override
  String toString() {
    if (this == HomeTrainingBalanceType.less) {
      return StringRes.trainingBalanceLess.tr;
    } else if (this == HomeTrainingBalanceType.normal) {
      return StringRes.trainingBalanceNormal.tr;
    } else if (this == HomeTrainingBalanceType.over) {
      return StringRes.trainingBalanceOver.tr;
    } else {
      return StringRes.trainingBalanceNone.tr;
    }
  }

  String toAsset() {
    if (this == HomeTrainingBalanceType.less) {
      return Assets.walkMan;
    } else if (this == HomeTrainingBalanceType.normal) {
      return Assets.runningMan;
    } else if (this == HomeTrainingBalanceType.over) {
      return Assets.retiredMan;
    } else {
      return Assets.walkManBlack;
    }
  }

  Color toColor() {
    if (this == HomeTrainingBalanceType.less) {
      return ColorRes.fontDisable;
    } else if (this == HomeTrainingBalanceType.normal) {
      return ColorRes.primary;
    } else if (this == HomeTrainingBalanceType.over) {
      return ColorRes.fontError;
    } else {
      return ColorRes.gray9f9f9f;
    }
  }

  // 정보없음 여부
  bool isTraining() {
    return this != HomeTrainingBalanceType.none;
  }
}
