import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/hooper_index_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/wellness_detail/item/hooper_index_ui_state.dart';
import 'package:physical_note/app/ui/page/wellness_detail/wellness_detail.dart';
import 'package:physical_note/app/ui/widgets/text_field/bottom_border_text_field.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/input_formatter_utils.dart';
import 'package:physical_note/app/utils/localization/localization_utils.dart';

/// 웰리니스 상세
class WellnessDetailPage extends GetView<WellnessDetailController> {
  const WellnessDetailPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Column(
          children: [
            _Header(),
            const Expanded(child: _WellnessDetailPage()),
          ],
        ),
      );
}

/// 헤더.
class _Header extends GetView<WellnessDetailController> {
  @override
  Widget build(BuildContext context) => Header(
        title: "",
        showBack: true,
        onPressed: controller.close,
      );
}

class _WellnessDetailPage extends GetView<WellnessDetailController> {
  const _WellnessDetailPage();

  @override
  Widget build(BuildContext context) => FlexibleScrollView(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(
              onTapGuide: controller.onTapWellnessGuideButton,
            ),
            const SizedBox(height: 10),
            _Date(),
            const SizedBox(height: 30),
            _FieldName(
              text: StringRes.hooperIndex.tr,
              isSubTitle: false,
            ),
            const SizedBox(height: 15),
            Obx(
              () => _HooperIndex(
                uiState: controller.hooperIndexUiState.value,
                onChangeHooperIndex: controller.onChangeHooperIndex,
              ),
            ),
            const SizedBox(height: 24),
            _FieldName(
              text: StringRes.urinalysis.tr,
              isSubTitle: false,
            ),
            const SizedBox(height: 15),
            Obx(
              () => _Urine(
                table: controller.urineTable.value,
                onChangedUrine: controller.onChangedUrine,
                weightController: controller.urineWeight.controller,
                bmiController: controller.urineBmi.controller,
              ),
            ),
            const SizedBox(height: 42),
            Row(
              children: [
                Expanded(
                  child: RoundButton.gray(
                    height: 56,
                    text: StringRes.cancel.tr,
                    textStyle: const TextStyle(
                      color: ColorRes.gray9f9f9f,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: RoundButton(
                    width: double.infinity,
                    text: StringRes.doSave.tr,
                    onPressed: controller.onPressedSave,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      );
}

/// 필드명.
class _FieldName extends StatelessWidget {
  final String text;
  final bool isSubTitle;

  const _FieldName({
    required this.text,
    required this.isSubTitle,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: isSubTitle ? 12 : 16,
          fontWeight: isSubTitle ? FontWeight.w400 : FontWeight.w500,
          color: isSubTitle ? ColorRes.gray747474 : ColorRes.fontBlack,
        ),
      );
}

/// 타이틀
class _Title extends StatelessWidget {
  final Function() onTapGuide;

  const _Title({required this.onTapGuide});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              StringRes.wellness.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: ColorRes.fontBlack,
              ),
            ),
          ),
          InkWellOver(
            onTap: onTapGuide,
            child: Text(
              StringRes.whatWellness.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: ColorRes.gray9f9f9f,
              ),
            ),
          ),
        ],
      );
}

/// 날짜
class _Date extends GetView<WellnessDetailController> {
  String get formattedDate => LocalizationUtil.getDateStr(
        date: controller.formattedRecordDate,
        koFormat: "yy년 M월 d일 (EEE)",
        enFormat: 'MMMM d, yy (E)',
      );

  @override
  Widget build(BuildContext context) => Obx(() => InkWellOver(
        onTap: controller.onPressedCalendar,
        child: Row(
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(Assets.codeBrowser),
          ],
        ),
      ));
}

/// 후퍼인덱스.
class _HooperIndex extends StatelessWidget {
  final HooperIndexUiState uiState;

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
              color: Colors.grey.withValues(alpha:0.25),
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
              color: ColorRes.wellness5,
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
              color: ColorRes.wellness3,
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
              color: ColorRes.wellness6,
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
              color: ColorRes.wellness2,
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
  final int table;

  /// 체중.
  final TextEditingController weightController;

  /// bmi.
  final TextEditingController bmiController;

  /// 소변검사 - 소변검사표 변경 이벤트.
  final Function(int) onChangedUrine;

  const _Urine({
    required this.table,
    required this.bmiController,
    required this.weightController,
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
              color: Colors.grey.withValues(alpha:0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FieldName(text: StringRes.urinalysisTable.tr, isSubTitle: true),
            _UrineTable(
              value: table,
              onChangedUrine: onChangedUrine,
            ),
            const SizedBox(height: 24),
            _FieldName(
              text: StringRes.urineTestWeightKg.tr,
              isSubTitle: true,
            ),
            BottomBorderTextField(
              controller: weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              obscureText: false,
              hint: StringRes.myAnswer.tr,
              contentPadding: EdgeInsets.zero,
              inputFormatters: <TextInputFormatter>[
                InputFormatterUtils.digitAndDot,
                // 소수점만 입력받도록 정규식 설정
              ],
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
              hint: StringRes.writeInBodyRecord.tr,
              contentPadding: EdgeInsets.zero,
              maxLength: 4,
              inputFormatters: <TextInputFormatter>[
                InputFormatterUtils.digitAndDot,
              ],
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

  final Color color;

  final Function(double value) onChanged;

  const _SliderItem({
    required this.title,
    required this.engTitle,
    required this.value,
    required this.minValueName,
    required this.maxValueName,
    required this.color,
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
          CustomSlider(
            value: value,
            color: color,
            onChanged: onChanged,
          ),
        ],
      );
}

/// 소변 검사 표
class _UrineTable extends StatelessWidget {
  final int value;

  final Function(int) onChangedUrine;

  const _UrineTable({
    required this.value,
    required this.onChangedUrine,
  });

  final TextStyle fontWhite = const TextStyle(
    fontWeight: FontWeight.w700,
    color: ColorRes.white,
    fontSize: 12,
  );

  final TextStyle fontGray = const TextStyle(
    fontWeight: FontWeight.w700,
    color: ColorRes.gray9f9f9f,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _UrineTableItem(
              isSelected: value == 1,
              text: '1',
              textStyle: fontGray,
              backgroundColor: ColorRes.urineTable1,
              onTap: () {
                onChangedUrine(1);
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _UrineTableItem(
              isSelected: value == 2,
              text: '2',
              textStyle: fontGray,
              backgroundColor: ColorRes.urineTable2,
              description: StringRes.moistureGood.tr,
              onTap: () {
                onChangedUrine(2);
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _UrineTableItem(
              isSelected: value == 3,
              text: '3',
              textStyle: fontGray,
              backgroundColor: ColorRes.urineTable3,
              onTap: () {
                onChangedUrine(3);
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _UrineTableItem(
              isSelected: value == 4,
              text: '4',
              textStyle: fontWhite,
              backgroundColor: ColorRes.urineTable4,
              onTap: () {
                onChangedUrine(4);
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _UrineTableItem(
              isSelected: value == 5,
              text: '5',
              textStyle: fontWhite,
              backgroundColor: ColorRes.urineTable5,
              description: StringRes.moistureLack.tr,
              onTap: () {
                onChangedUrine(5);
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _UrineTableItem(
              isSelected: value == 6,
              text: '6',
              textStyle: fontWhite,
              backgroundColor: ColorRes.urineTable6,
              onTap: () {
                onChangedUrine(6);
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _UrineTableItem(
              isSelected: value == 7,
              text: '7',
              textStyle: fontWhite,
              backgroundColor: ColorRes.urineTable7,
              onTap: () {
                onChangedUrine(7);
              },
            ),
          ),
        ],
      );
}

class _UrineTableItem extends StatelessWidget {
  final bool isSelected;

  final String text;

  final TextStyle textStyle;

  final Color backgroundColor;

  final String description;

  final Function() onTap;

  const _UrineTableItem({
    required this.isSelected,
    required this.text,
    required this.textStyle,
    required this.backgroundColor,
    this.description = '',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 22 / 10,
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Visibility(
                    visible: isSelected,
                    child: Expanded(
                      child: SvgPicture.asset(Assets.arrowDown),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 22 / 34,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(color: ColorRes.borderUrine, width: 1.5)
                      : null,
                  borderRadius: BorderRadius.circular(5),
                  color: backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha:0.25),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(-8, 6),
              child: Text(
                description,
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.fontGray,
                ),
              ),
            )
          ],
        ),
      );
}
