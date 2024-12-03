import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/resources/resources.dart';

import 'home_injury_item_ui_state.dart';

/// 홈 - 부상현황 아이템
class HomeInjuryItem extends StatelessWidget {
  final HomeInjuryItemUiState uiState;

  const HomeInjuryItem({
    super.key,
    required this.uiState,
  });

  /// 질병 여부
  bool get isDisease => uiState.injury == InjuryType.disease;

  InjuryLevelType? get level => uiState.injuryLevel;

  MuscleType? get muscleType => uiState.muscle;

  InjuryType get injuryType => uiState.injury;

  /// 단계 or 질병
  String get levelString => isDisease
      ? InjuryType.disease.toString()
      : '${level?.level ?? ''} ${StringRes.step.tr}';

  /// 단계 text color
  Color get stepColor =>
      (level?.level ?? 0) > 3 ? ColorRes.white : ColorRes.fontBlack;

  Color? get levelColor =>
      isDisease ? stepColor : level?.toFontColor();

  /// 단계 or 질병 border color
  Color get levelBorderColor =>
      isDisease ? ColorRes.disable : level?.toBorderColor() ?? ColorRes.disable;

  /// 단계 or 질병 background color
  Color? get levelBackgroundColor =>
      isDisease ? ColorRes.disable : level?.toBackgroundColor();

  /// 근육명 or 질병
  String get title =>
      isDisease ? StringRes.injuryTypeDisease.tr : muscleType?.toKor() ?? '';

  /// 부상 타입 or 질병 코멘트
  String get description =>
      isDisease ? uiState.comment ?? '' : injuryType.toSimpleString();

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: levelBorderColor),
              borderRadius: BorderRadius.circular(20),
              color: levelBackgroundColor,
            ),
            child: Text(
              levelString,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: levelColor,
                letterSpacing: -0.5,
                height: 14 / 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 14 / 10,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 20 / 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ).marginOnly(bottom: 6);
}
