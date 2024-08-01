import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/injury/item/history_injury_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class HistoryInjuryItem extends StatelessWidget {
  final bool isFirst;
  final HistoryInjuryItemUiState uiState;
  final VoidCallback onPressed;

  const HistoryInjuryItem({
    super.key,
    this.isFirst = false,
    required this.uiState,
    required this.onPressed,
  });

  bool get isDisease => uiState.injuryType == InjuryType.disease;

  String get comment => _comment();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  Assets.frontLeftLegADDUCTORLONGUS,
                  width: 75,
                  height: 75,
                ),
                const SizedBox(height: 6),
                _InjuryLevel(
                  isDisease: isDisease,
                  type: uiState.injuryLevelType,
                ),
              ],
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        uiState.muscleType?.toKor() ?? '-',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.fontBlack,
                          height: 26 / 16,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 5),
                      _RecoveryDate(
                        recordDate: uiState.recordDate,
                        recoveryYn: uiState.recoveryYn,
                        recoveryDate: uiState.recoveryDate,
                      ),
                      const Spacer(),
                      InkWellOver(
                        onTap: onPressed,
                        borderRadius: BorderRadius.circular(20),
                        child: SvgPicture.asset(
                          Assets.edit03,
                          width: 17,
                          height: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    uiState.injuryType.toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                      height: 16 / 10,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    uiState.injuryLevelType.toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                      height: 16 / 10,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    comment,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                      height: 16 / 10,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  /// 코멘트 문자열.
  String _comment() {
    final isDisease = uiState.injuryType == InjuryType.disease;
    final comment =
        isDisease ? uiState.comment : uiState.injuryLevelType.toString() ?? "";
    final colons = isDisease ? "" : ": ";
    return "$colons$comment";
  }
}

class _InjuryLevel extends StatelessWidget {
  final bool isDisease;

  final InjuryLevelType? type;

  const _InjuryLevel({
    required this.isDisease,
    required this.type,
  });

  String get levelString =>
      type?.level != null ? '${type?.level}${StringRes.step.tr}' : '-';

  Color get backgroundColor => type?.toBackgroundColor() ?? ColorRes.disable;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          levelString,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ColorRes.fontBlack,
            height: 20 / 12,
            letterSpacing: -0.5,
          ),
        ),
      );
}

class _RecoveryDate extends StatelessWidget {
  final String? recordDate;

  final bool? recoveryYn;

  final String? recoveryDate;

  const _RecoveryDate({
    required this.recordDate,
    required this.recoveryYn,
    required this.recoveryDate,
  });

  String get _recoveryDate => recoveryYn == true ? ' - $recoveryDate' : '';

  @override
  Widget build(BuildContext context) => Text(
        '$recordDate$_recoveryDate',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: ColorRes.gray9f9f9f,
          height: 16 / 10,
          letterSpacing: -0.5,
        ),
      );
}
