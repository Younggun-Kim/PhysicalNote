import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'home_injury_check_item_ui_state.dart';

class HomeInjuryCheckItem extends StatelessWidget {
  final HomeInjuryCheckItemUiState uiState;

  final bool isShowBorder;

  final Function() onPressedEdit;

  const HomeInjuryCheckItem({
    super.key,
    required this.uiState,
    this.isShowBorder = false,
    required this.onPressedEdit,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: isShowBorder ? const EdgeInsets.only(bottom: 10) : null,
        padding: isShowBorder ? const EdgeInsets.fromLTRB(16, 16, 16, 0) : null,
        decoration: isShowBorder
            ? BoxDecoration(
                color: ColorRes.white,
                border: Border.all(color: ColorRes.gray3),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Level(
                  injuryLevelType: uiState.injuryLevelType,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (uiState.muscleType != null)
                      Text(
                        uiState.muscleType?.toKor() ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    Text(
                      uiState.recordAndRecoveryDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWellOver(
                      onTap: onPressedEdit,
                      borderRadius: BorderRadius.circular(20),
                      child: SvgPicture.asset(
                        Assets.edit03,
                        width: 17,
                        height: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      uiState.recoveryString,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: uiState.recoveryYn == true
                            ? ColorRes.fontDisable
                            : ColorRes.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Visibility(
              visible: uiState.injuryType != InjuryType.disease,
              child: Text(
                uiState.injuryType?.toString() ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.fontBlack,
                ),
              ),
            ),
            Visibility(
              visible: uiState.injuryType != InjuryType.disease,
              child: Row(
                children: [
                  Text(
                    uiState.injuryLevelType.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _comment(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );

  /// 코멘트 문자열.
  String _comment() {
    final isDisease = uiState.injuryType == InjuryType.disease;
    final comment =
        isDisease ? uiState.comment : uiState.injuryLevelTypeString ?? "";
    final colons = isDisease ? "" : ": ";
    return "$colons$comment";
  }
}

class _Level extends StatelessWidget {
  final InjuryLevelType? injuryLevelType;

  const _Level({
    required this.injuryLevelType,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: injuryLevelType?.toBorderColor() ?? ColorRes.borderDeselect,
          ),
          color: injuryLevelType?.toBackgroundColor() ?? ColorRes.disable,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          levelString(),
          style: TextStyle(
            fontSize: 14,
            color: injuryLevelType?.toFontColor() ?? ColorRes.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  String levelString() {
    final level = injuryLevelType?.level;

    if (level == null) {
      return "질병";
    } else {
      return "$level단계";
    }
  }
}
