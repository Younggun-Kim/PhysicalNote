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

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
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
          child: isDisease
              ? _DiseaseContent(
                  uiState: uiState,
                  onPressedEdit: onPressed,
                )
              : _InjuryContent(
                  uiState: uiState,
                  onPressedEdit: onPressed,
                ),
        ),
      );
}

class _MuscleName extends StatelessWidget {
  final String title;

  final bool recoveryYn;

  const _MuscleName({
    required this.title,
    required this.recoveryYn,
  });

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: recoveryYn ? ColorRes.gray9f9f9f : ColorRes.fontBlack,
          height: 26 / 16,
          letterSpacing: -0.5,
        ),
      );
}

class _InjuryLevel extends StatelessWidget {
  final InjuryLevelType? type;

  const _InjuryLevel({
    required this.type,
  });

  String get levelString =>
      type?.level != null ? '${type?.level} ${StringRes.step.tr}' : '-';

  Color get backgroundColor => type?.toBackgroundColor() ?? ColorRes.disable;

  Color get levelColor =>
      (type?.level ?? 0) > 3 ? ColorRes.white : ColorRes.fontBlack;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          levelString,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: levelColor,
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
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              '$recordDate$_recoveryDate',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: ColorRes.gray9f9f9f,
                height: 16 / 10,
                letterSpacing: -0.5,
              ),
            ),
          ),
          if (recoveryYn == true)
            Text(
              StringRes.recovery.tr,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: ColorRes.gray9f9f9f,
                height: 16 / 10,
                letterSpacing: -0.5,
              ),
            ),
        ],
      );
}

class _InjuryContent extends StatelessWidget {
  final HistoryInjuryItemUiState uiState;

  final VoidCallback onPressedEdit;

  const _InjuryContent({
    required this.uiState,
    required this.onPressedEdit,
  });

  String get comment => ': ${uiState.injuryLevelType?.toDescription() ?? ""}';

  Color get recoveryColor =>
      uiState.recoveryYn == true ? ColorRes.gray9f9f9f : ColorRes.fontBlack;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                uiState.muscleImage,
                width: 75,
                height: 75,
              ),
              const SizedBox(height: 6),
              _InjuryLevel(
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
                _MuscleName(
                  title: uiState.muscleType?.toKor() ?? '-',
                  recoveryYn: uiState.recoveryYn ?? false,
                ),
                _RecoveryDate(
                  recordDate: uiState.recordDate,
                  recoveryYn: uiState.recoveryYn,
                  recoveryDate: uiState.recoveryDate,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      uiState.injuryType.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: recoveryColor,
                        height: 16 / 10,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      ' (${uiState.injuryLevelType.toString()})',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: recoveryColor,
                        height: 16 / 10,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: recoveryColor,
                    height: 16 / 10,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class _DiseaseContent extends StatelessWidget {
  final HistoryInjuryItemUiState uiState;

  final VoidCallback onPressedEdit;

  Color get recoveryColor =>
      uiState.recoveryYn == true ? ColorRes.gray9f9f9f : ColorRes.fontBlack;

  const _DiseaseContent({
    required this.uiState,
    required this.onPressedEdit,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.disease,
            width: 75,
            height: 75,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MuscleName(
                  title: StringRes.injuryTypeDisease.tr,
                  recoveryYn: uiState.recoveryYn ?? false,
                ),
                _RecoveryDate(
                  recordDate: uiState.recordDate,
                  recoveryYn: uiState.recoveryYn,
                  recoveryDate: uiState.recoveryDate,
                ),
                const SizedBox(height: 10),
                Text(
                  uiState.comment ?? '',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    height: 16 / 10,
                    letterSpacing: -0.5,
                    color: recoveryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
