import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/injury_detail/injury_detail_controller.dart';
import 'package:physical_note/app/ui/page/injury_detail/injury_detail_pain_symptom_ui_state.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';

/// 부상체크 상세 UI
class InjuryDetailPage extends GetView<InjuryDetailController> {
  const InjuryDetailPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
      controller: controller,
      child: Column(
        children: [
          _Header(),
          Expanded(child: _InjuryDetailPage()),
        ],
      ));
}

class _InjuryDetailPage extends GetView<InjuryDetailController> {
  @override
  Widget build(BuildContext context) => FlexibleScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(
          () => AbsorbPointer(
            absorbing: controller.isRecovered.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _Title(),
                const SizedBox(height: 16),
                _Date(),
                const SizedBox(height: 40),
                Text(
                  StringRes.injuryLocationSelection.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                  ),
                ),
                const SizedBox(height: 20),
                _InjuryType(),
                _Disease(),
                _Contact(),
                _MuscleImage(),
                _Muscles(),
                const SizedBox(height: 40),
                _Pain(),
                const SizedBox(height: 50),
                const Spacer(),
                Visibility(
                  visible: controller.isShowDetailUi &&
                      !controller.isRecovered.value,
                  child: BaseButton(
                    width: double.infinity,
                    height: 56,
                    text: StringRes.recovery.tr,
                    defaultTextStyle: const TextStyle(
                      fontSize: 16,
                      color: ColorRes.white,
                      fontWeight: FontWeight.w500,
                    ),
                    defaultBackgroundColor: ColorRes.disable,
                    // onPressed: controller.onPressedInjuryCheckRecovery,
                    onPressed: controller.onPressedRecovery,
                  ).marginOnly(bottom: 20),
                ),
                Obx(
                  () => Row(
                    children: [
                      Visibility(
                        visible: controller.isShowDetailUi &&
                            !controller.isRecovered.value,
                        child: Expanded(
                          child: BaseButton(
                            width: double.infinity,
                            height: 56,
                            text: StringRes.delete.tr,
                            defaultTextStyle: const TextStyle(
                              fontSize: 16,
                              color: ColorRes.white,
                              fontWeight: FontWeight.w500,
                            ),
                            defaultBackgroundColor: ColorRes.disable,
                            onPressed: controller.onPressedDelete,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.isShowDetailUi &&
                            !controller.isRecovered.value,
                        child: const SizedBox(
                          width: 10,
                        ),
                      ),
                      Visibility(
                        visible: !controller.isRecovered.value,
                        child: Expanded(
                          child: BaseButton(
                            width: double.infinity,
                            height: 56,
                            isEnabled: controller.injuryType.value ==
                                    InjuryType.disease
                                ? controller.isEnabledDiseaseSubmit.value
                                : controller.isEnabledSubmit.value,
                            text: StringRes.save.tr,
                            defaultTextStyle: const TextStyle(
                              fontSize: 16,
                              color: ColorRes.white,
                              fontWeight: FontWeight.w500,
                            ),
                            defaultBackgroundColor: ColorRes.primary,
                            onPressed: controller.onPressedSubmit,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
}

/// 헤더.
class _Header extends GetView<InjuryDetailController> {
  @override
  Widget build(BuildContext context) => Header(
        title: '',
        showBack: true,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        onPressed: controller.close,
      );
}

/// 타이틀
class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              StringRes.injuryCheck.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: ColorRes.fontBlack,
              ),
            ),
          ),
        ],
      );
}

/// 날짜
class _Date extends GetView<InjuryDetailController> {
  String get formattedDate => LocalizationUtil.getDateStr(
        date: controller.recordDate.value.toFormattedString('yyyy-MM-dd'),
        koFormat: "yy년 M월 d일 (E)",
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
                color: ColorRes.gray9f9f9f,
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(Assets.codeBrowser),
          ],
        ),
      ));
}

/// 질병.
class _Disease extends GetView<InjuryDetailController> {
  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.injuryType.value == InjuryType.disease,
          child: OutlineTextField(
            controller: controller.diseaseController.controller,
            height: 120,
            borderRadius: BorderRadius.circular(24),
            margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            maxLength: 40,
            maxLines: 4,
            hint: StringRes.injuryCheckDiseaseHint.tr,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            inputFormatter: [
              LengthLimitingTextInputFormatter(40),
            ],
          ),
        ),
      );
}

/// 부상 타입.
class _InjuryType extends GetView<InjuryDetailController> {
  @override
  Widget build(BuildContext context) => Obx(() => Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        children: [
          FittedBox(
            child: BaseButton(
              isSelected: controller.injuryType.value == InjuryType.nonContact,
              text: InjuryType.nonContact.toString(),
              selectedBackgroundColor: controller.isRecovered.value
                  ? ColorRes.gray9f9f9f
                  : ColorRes.primary,
              onPressed: () {
                controller.onPressedInjuryType(InjuryType.nonContact);
              },
            ),
          ),
          FittedBox(
            child: BaseButton(
              isSelected: controller.injuryType.value == InjuryType.contact,
              text: InjuryType.contact.toString(),
              selectedBackgroundColor: controller.isRecovered.value
                  ? ColorRes.gray9f9f9f
                  : ColorRes.primary,
              onPressed: () {
                controller.onPressedInjuryType(InjuryType.contact);
              },
            ),
          ),
          FittedBox(
            child: BaseButton(
              isSelected: controller.injuryType.value == InjuryType.disease,
              text: InjuryType.disease.toString(),
              selectedBackgroundColor: controller.isRecovered.value
                  ? ColorRes.gray9f9f9f
                  : ColorRes.primary,
              onPressed: () {
                controller.onPressedInjuryType(InjuryType.disease);
              },
            ),
          ),
        ],
      ));
}

/// 접촉/비접촉.
class _Contact extends GetView<InjuryDetailController> {
  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.injuryType.value != InjuryType.disease,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  BaseButton(
                    text: StringRes.front.tr,
                    isSelected:
                        controller.directionType.value == DistinctionType.front,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    selectedBackgroundColor: controller.isRecovered.value
                        ? ColorRes.gray9f9f9f
                        : ColorRes.primary,
                    onPressed: () {
                      controller.onPressedDirectionType(DistinctionType.front);
                    },
                  ),
                  const SizedBox(width: 10),
                  BaseButton(
                    text: StringRes.back.tr,
                    isSelected:
                        controller.directionType.value == DistinctionType.back,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    selectedBackgroundColor: controller.isRecovered.value
                        ? ColorRes.gray9f9f9f
                        : ColorRes.primary,
                    onPressed: () {
                      controller.onPressedDirectionType(DistinctionType.back);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: controller.directionType.value != null,
                child: Row(
                  children: [
                    BaseButton(
                      text: StringRes.upperBody.tr,
                      isSelected: controller.bodyType.value == BodyType.upper,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      selectedBackgroundColor: controller.isRecovered.value
                          ? ColorRes.gray9f9f9f
                          : ColorRes.primary,
                      onPressed: () {
                        controller.onPressedBodyType(BodyType.upper);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      text: StringRes.lowerBody.tr,
                      isSelected: controller.bodyType.value == BodyType.lower,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      selectedBackgroundColor: controller.isRecovered.value
                          ? ColorRes.gray9f9f9f
                          : ColorRes.primary,
                      onPressed: () {
                        controller.onPressedBodyType(BodyType.lower);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: controller.directionType.value != null &&
                    controller.bodyType.value == BodyType.upper,
                child: Row(
                  children: [
                    BaseButton(
                      text: StringRes.torso.tr,
                      isSelected:
                          controller.bodyPartsType.value == BodyPartsType.body,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      selectedBackgroundColor: controller.isRecovered.value
                          ? ColorRes.gray9f9f9f
                          : ColorRes.primary,
                      onPressed: () {
                        controller.onPressedBodyPartsType(BodyPartsType.body);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      text: StringRes.leftArm.tr,
                      isSelected: controller.bodyPartsType.value ==
                          BodyPartsType.leftArm,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      selectedBackgroundColor: controller.isRecovered.value
                          ? ColorRes.gray9f9f9f
                          : ColorRes.primary,
                      onPressed: () {
                        controller
                            .onPressedBodyPartsType(BodyPartsType.leftArm);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      text: StringRes.rightArm.tr,
                      isSelected: controller.bodyPartsType.value ==
                          BodyPartsType.rightArm,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      selectedBackgroundColor: controller.isRecovered.value
                          ? ColorRes.gray9f9f9f
                          : ColorRes.primary,
                      onPressed: () {
                        controller
                            .onPressedBodyPartsType(BodyPartsType.rightArm);
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.directionType.value != null &&
                    controller.bodyType.value == BodyType.lower,
                child: Row(
                  children: [
                    BaseButton(
                      text: StringRes.leftLeg.tr,
                      isSelected: controller.bodyPartsType.value ==
                          BodyPartsType.leftLeg,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      selectedBackgroundColor: controller.isRecovered.value
                          ? ColorRes.gray9f9f9f
                          : ColorRes.primary,
                      onPressed: () {
                        controller
                            .onPressedBodyPartsType(BodyPartsType.leftLeg);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      text: StringRes.rightLeg.tr,
                      isSelected: controller.bodyPartsType.value ==
                          BodyPartsType.rightLeg,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      selectedBackgroundColor: controller.isRecovered.value
                          ? ColorRes.gray9f9f9f
                          : ColorRes.primary,
                      onPressed: () {
                        controller
                            .onPressedBodyPartsType(BodyPartsType.rightLeg);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

/// 근육 이미지.
class _MuscleImage extends GetView<InjuryDetailController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.muscleImage.value.isEmpty ||
              controller.injuryType.value == InjuryType.disease
          ? const SizedBox()
          : SvgPicture.string(controller.muscleImage.value),
    );
  }
}

/// 상세 근육.
class _Muscles extends GetView<InjuryDetailController> {
  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.muscles.value.isNotEmpty &&
              controller.injuryType.value != InjuryType.disease,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringRes.detailedMuscle.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontBlack,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 5,
                // 좌우 간격
                runSpacing: 5,
                // 상하
                children: controller.muscles.value.map((muscleType) {
                  return FittedBox(
                    fit: BoxFit.contain,
                    child: BaseButton(
                      text: muscleType.toKor(),
                      isSelected:
                          controller.selectedMuscleType.value == muscleType,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      selectedBackgroundColor: controller.isRecovered.value
                          ? ColorRes.gray9f9f9f
                          : ColorRes.primary,
                      onPressed: () {
                        controller.onPressedMuscle(muscleType);
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
}

/// 통증
class _Pain extends GetView<InjuryDetailController> {
  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.selectedMuscleType.value != null &&
              controller.injuryType.value != InjuryType.disease,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorRes.white,
              border: Border.all(color: ColorRes.borderWhite),
              borderRadius: BorderRadius.circular(24),
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
                _FieldName(
                  text: StringRes.painLevel.tr,
                ),
                const SizedBox(height: 20),
                Obx(
                  () => CustomSlider(
                    value: controller.painLevel.value.level.toDouble(),
                    color: controller.painLevel.value.toBackgroundColor(),
                    minValue: 0,
                    maxValue: 5,
                    divisions: 5,
                    onChanged: (double value) {
                      controller.onChangePainLevelSlide(value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Text(
                    controller.painLevel.value.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    ": ${controller.painLevel.value.toDescription()}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _FieldName(text: StringRes.painSymptoms.tr),
                const SizedBox(height: 10),
                Obx(
                  () => _PainSymptoms(
                    painSymptoms: controller.painSymptoms.toList(),
                    isRecovered: controller.isRecovered.value,
                    onPressed: controller.onPressedPainSymptom,
                  ),
                ),
                const SizedBox(height: 20),
                _FieldName(text: StringRes.painTiming.tr),
                const SizedBox(height: 10),
                Obx(
                  () => _PainTimingIntermittentOrRegular(
                    isIntermittent: controller.painTimingIntermittent.value,
                    isRecovered: controller.isRecovered.value,
                    onPressed: controller.onPressedPainTimingIntermittent,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => _PainTimingRestAndWorkout(
                    isRest: controller.painTimingRest.value,
                    isWorkout: controller.painTimingWorkout.value,
                    isRecovered: controller.isRecovered.value,
                    onPressedRest: controller.onPressedPainTimingRest,
                    onPressedWorkout: controller.onPressedPainTimingWorkout,
                  ),
                ),
                const SizedBox(height: 20),
                _FieldName(text: StringRes.injuryCause.tr),
                const SizedBox(height: 10),
                _PainTimingDescription(
                  controller: controller.painTimingDescription.controller,
                ),
              ],
            ),
          ),
        ),
      );
}

/// 통증 양상
class _PainSymptoms extends StatelessWidget {
  final List<InjuryDetailPainSymptomUiState> painSymptoms;

  final bool isRecovered;

  final Function(InjuryDetailPainSymptomUiState) onPressed;

  const _PainSymptoms({
    required this.painSymptoms,
    required this.isRecovered,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 10,
        runSpacing: 7,
        children: painSymptoms.map((InjuryDetailPainSymptomUiState e) {
          return FittedBox(
            fit: BoxFit.contain,
            child: BaseButton(
              text: e.type.toString(),
              isSelected: e.isSelected,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              selectedBackgroundColor:
                  isRecovered ? ColorRes.gray9f9f9f : ColorRes.primary,
              onPressed: () {
                onPressed(e);
              },
            ),
          );
        }).toList(),
      );
}

/// 통증 시기 - 간헐적, 일정함
class _PainTimingIntermittentOrRegular extends StatelessWidget {
  final bool? isIntermittent;
  final bool isRecovered;

  final Function(bool) onPressed;

  const _PainTimingIntermittentOrRegular({
    required this.isIntermittent,
    required this.isRecovered,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: BaseButton(
              text: StringRes.intermittent.tr,
              isSelected: isIntermittent == true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              selectedBackgroundColor:
                  isRecovered ? ColorRes.gray9f9f9f : ColorRes.primary,
              onPressed: () {
                onPressed(true);
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BaseButton(
              text: StringRes.regular.tr,
              isSelected: isIntermittent == false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              selectedBackgroundColor:
                  isRecovered ? ColorRes.gray9f9f9f : ColorRes.primary,
              onPressed: () {
                onPressed(false);
              },
            ),
          ),
        ],
      );
}

/// 통증 시기 - 휴식기, 운동중
class _PainTimingRestAndWorkout extends StatelessWidget {
  final bool isRest;

  final bool isWorkout;

  final bool isRecovered;

  final Function() onPressedRest;

  final Function() onPressedWorkout;

  const _PainTimingRestAndWorkout({
    required this.isRest,
    required this.isWorkout,
    required this.isRecovered,
    required this.onPressedRest,
    required this.onPressedWorkout,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: BaseButton(
              text: StringRes.restPeriod.tr,
              isSelected: isRest,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              selectedBackgroundColor:
                  isRecovered ? ColorRes.gray9f9f9f : ColorRes.primary,
              onPressed: onPressedRest,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BaseButton(
              text: StringRes.duringWorkout.tr,
              isSelected: isWorkout,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              selectedBackgroundColor:
                  isRecovered ? ColorRes.gray9f9f9f : ColorRes.primary,
              onPressed: onPressedWorkout,
            ),
          ),
        ],
      );
}

/// 통증 시 - 부상 경위
class _PainTimingDescription extends StatelessWidget {
  final TextEditingController controller;

  const _PainTimingDescription({required this.controller});

  @override
  Widget build(BuildContext context) => OutlineTextField(
        controller: controller,
        height: 140,
        border: Border.all(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(24),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        color: ColorRes.backgroundF9,
        maxLines: 10,
        fontSize: 12,
        hint: StringRes.injuryCauseHint.tr,
        keyboardType: TextInputType.multiline,
      );
}

/// 필드명.
class _FieldName extends StatelessWidget {
  final String text;

  const _FieldName({required this.text});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Text(
          text,
          style: const TextStyle(
            color: ColorRes.fontBlack,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
