import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/hooper_index_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/text_field/bottom_border_text_field.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'data_wellness_hooper_index_ui_state.dart';

class WellnessPage extends StatelessWidget {
  /// 후퍼 인덱스 Ui State.
  final DataWellnessHooperIndexUiState hooperIndexUiState;

  /// 후퍼인덱스 슬라이드 변경 이벤트.
  final Function(HooperIndexType type, double value) onChangeHooperIndex;

  /// 소변검사표.
  final double table;

  /// 체중.
  final TextEditingController weightController;

  /// bmi.
  final TextEditingController bmiController;

  /// 소변검사 - 소변검사표 변경 이벤트.
  final Function(double) onChangedUrine;

  /// 저장하기 클릭.
  final VoidCallback onPressedWellnessSave;

  const WellnessPage({
    super.key,
    required this.hooperIndexUiState,
    required this.onChangeHooperIndex,
    required this.table,
    required this.onChangedUrine,
    required this.weightController,
    required this.bmiController,
    required this.onPressedWellnessSave,
  });

  @override
  Widget build(BuildContext context) => FlexibleScrollView(
        padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringRes.wellnessKorEng.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              StringRes.wellnessDescription.tr,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: ColorRes.fontDisable,
              ),
            ),
            const SizedBox(height: 30),
            _FieldName(
              text: StringRes.hooperIndex.tr,
              isSubTitle: false,
            ),
            const SizedBox(height: 15),
            _HooperIndex(
              uiState: hooperIndexUiState,
              onChangeHooperIndex: onChangeHooperIndex,
            ),
            const SizedBox(height: 24),
            _FieldName(
              text: StringRes.urinalysis.tr,
              isSubTitle: false,
            ),
            const SizedBox(height: 15),
            _Urine(
              table: table,
              onChangedUrine: onChangedUrine,
              weightController: weightController,
              bmiController: bmiController,
            ),
            const SizedBox(height: 24),
            RoundButton(
              width: double.infinity,
              text: StringRes.doSave.tr,
              onPressed: onPressedWellnessSave,
            ),
          ],
        ),
      );
}

/// 필드명.
class _FieldName extends StatelessWidget {
  final String text;
  final bool isSubTitle;
  final bool isSmall;

  const _FieldName({
    required this.text,
    required this.isSubTitle,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: isSmall ? 12 : 16,
          fontWeight: isSubTitle ? FontWeight.w400 : FontWeight.w500,
          color: ColorRes.fontBlack,
        ),
      );
}

/// 후퍼인덱스.
class _HooperIndex extends StatelessWidget {
  final DataWellnessHooperIndexUiState uiState;

  final Function(HooperIndexType type, double value) onChangeHooperIndex;

  const _HooperIndex({
    required this.uiState,
    required this.onChangeHooperIndex,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: ColorRes.borderWhite),
          borderRadius: BorderRadius.circular(24),
          color: ColorRes.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            _SliderItem(
              title: StringRes.sleep.tr,
              engTitle: StringRes.sleepEng.tr,
              value: uiState.sleep,
              minValueName: StringRes.veryVeryGood.tr,
              maxValueName: StringRes.veryVeryBad.tr,
              onChanged: (double value) {
                onChangeHooperIndex(HooperIndexType.sleep, value);
              },
            ),
            const SizedBox(height: 20),
            _SliderItem(
              title: StringRes.stress.tr,
              engTitle: StringRes.stressEng.tr,
              value: uiState.stress,
              minValueName: StringRes.veryVeryGood.tr,
              maxValueName: StringRes.veryVeryBad.tr,
              onChanged: (double value) {
                onChangeHooperIndex(HooperIndexType.stress, value);
              },
            ),
            const SizedBox(height: 20),
            _SliderItem(
              title: StringRes.fatigue.tr,
              engTitle: StringRes.fatigueEng.tr,
              value: uiState.fatigue,
              minValueName: StringRes.veryVeryGood.tr,
              maxValueName: StringRes.veryVeryBad.tr,
              onChanged: (double value) {
                onChangeHooperIndex(HooperIndexType.fatigue, value);
              },
            ),
            const SizedBox(height: 20),
            _SliderItem(
              title: StringRes.musclePain.tr,
              engTitle: StringRes.musclePainEng.tr,
              value: uiState.muscleSoreness,
              minValueName: StringRes.veryVeryGood.tr,
              maxValueName: StringRes.veryVeryBad.tr,
              onChanged: (double value) {
                onChangeHooperIndex(HooperIndexType.muscleSoreness, value);
              },
            ),
          ],
        ),
      );
}

/// 소변검사.
class _Urine extends StatelessWidget {
  /// 소변검사표.
  final double table;

  /// 체중.
  final TextEditingController weightController;

  /// bmi.
  final TextEditingController bmiController;

  /// 소변검사 - 소변검사표 변경 이벤트.
  final Function(double) onChangedUrine;

  const _Urine({
    required this.table,
    required this.weightController,
    required this.bmiController,
    required this.onChangedUrine,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: ColorRes.borderWhite),
          borderRadius: BorderRadius.circular(24),
          color: ColorRes.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SliderItem(
              title: StringRes.urinalysisTable.tr,
              engTitle: null,
              value: table,
              minValueName: StringRes.satisfactory.tr,
              maxValueName: StringRes.insufficient.tr,
              onChanged: (double value) {
                onChangedUrine(value);
              },
            ),
            const SizedBox(height: 24),
            _FieldName(
              text: StringRes.urineTestWeightKg.tr,
              isSubTitle: true,
            ),
            BottomBorderTextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              obscureText: false,
              hint: StringRes.myAnswer.tr,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            _FieldName(
              text: StringRes.bmiPercent.tr,
              isSubTitle: true,
            ),
            BottomBorderTextField(
              controller: bmiController,
              keyboardType: TextInputType.number,
              obscureText: false,
              hint: StringRes.compellingRequest.tr,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      );
}

/// 슬라이드 아이템.
class _SliderItem extends StatelessWidget {
  final String title;

  final String? engTitle;

  final double value;

  final String minValueName;

  final String maxValueName;

  final Function(double value) onChanged;

  const _SliderItem({
    required this.title,
    required this.engTitle,
    required this.value,
    required this.minValueName,
    required this.maxValueName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _FieldName(text: title, isSubTitle: true),
              _FieldName(
                text: engTitle == null ? "" : "($engTitle)",
                isSubTitle: true,
                isSmall: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                minValueName,
                style: const TextStyle(
                  fontSize: 10,
                  color: ColorRes.fontDisable,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                maxValueName,
                style: const TextStyle(
                  fontSize: 10,
                  color: ColorRes.fontDisable,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _Slider(
            value: value,
            onChanged: onChanged,
          ),
        ],
      );
}

/// 슬라이더.
class _Slider extends StatelessWidget {
  final double value;

  final Function(double value) onChanged;

  const _Slider({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: SliderTheme(
          data: SliderThemeData(
            trackHeight: 10,
            activeTrackColor: ColorRes.wellness1,
            inactiveTrackColor: ColorRes.white,
            thumbColor: ColorRes.wellness1,
            thumbShape: BorderThumbShape(),
            showValueIndicator: ShowValueIndicator.always,
            overlayShape: SliderComponentShape.noOverlay,
            overlayColor: Colors.blue.withOpacity(0.3),
            tickMarkShape: CustomSliderTickMarkShape(),
          ),
          child: Slider(
            value: value,
            min: 1,
            max: 7,
            divisions: 6,
            onChanged: onChanged,
          ),
        ),
      );
}
