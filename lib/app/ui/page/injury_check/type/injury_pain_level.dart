import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

/// 통증정도.
enum InjuryPainLevel {
  level0,
  level1,
  level2,
  level3,
  level4,
  level5;

  @override
  String toString() {
    switch (this) {
      case level0:
        return StringRes.painLevel0.tr;
      case level1:
        return StringRes.painLevel1.tr;
      case level2:
        return StringRes.painLevel2.tr;
      case level3:
        return StringRes.painLevel3.tr;
      case level4:
        return StringRes.painLevel4.tr;
      case level5:
        return StringRes.painLevel5.tr;
    }
  }

  String toDescription() {
    switch (this) {
      case level0:
        return StringRes.painLevel0Description.tr;
      case level1:
        return StringRes.painLevel1Description.tr;
      case level2:
        return StringRes.painLevel2Description.tr;
      case level3:
        return StringRes.painLevel3Description.tr;
      case level4:
        return StringRes.painLevel4Description.tr;
      case level5:
        return StringRes.painLevel5Description.tr;
    }
  }

  Color toColor() {
    switch (this) {
      case level0:
        return ColorRes.intensity0;
      case level1:
        return ColorRes.intensity1;
      case level2:
        return ColorRes.intensity2;
      case level3:
        return ColorRes.intensity3;
      case level4:
        return ColorRes.intensity4;
      case level5:
        return ColorRes.intensity5;
    }
  }

  /// 통증레벨로 변경.
  double toLevel() {
    switch (this) {
      case level0:
        return 0;
      case level1:
        return 1;
      case level2:
        return 2;
      case level3:
        return 3;
      case level4:
        return 4;
      case level5:
        return 5;
    }
  }
}
