import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';

class InjuryCheckPage extends GetView<InjuryCheckController> {
  const InjuryCheckPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: FlexibleScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.args.date.toFormattedString("yyyy년 MM월 dd일"),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(Assets.codeBrowser),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                StringRes.injuryLocationSelection.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontBlack,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Row(
                  children: [
                    BaseButton(
                      isSelected:
                          controller.injuryType.value == InjuryType.nonContact,
                      text: InjuryType.nonContact.toString(),
                      onPressed: () {
                        controller.onPressedInjuryType(InjuryType.nonContact);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      isSelected:
                          controller.injuryType.value == InjuryType.contact,
                      text: InjuryType.contact.toString(),
                      onPressed: () {
                        controller.onPressedInjuryType(InjuryType.contact);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      isSelected:
                          controller.injuryType.value == InjuryType.disease,
                      text: InjuryType.disease.toString(),
                      onPressed: () {
                        controller.onPressedInjuryType(InjuryType.disease);
                      },
                    ),
                  ],
                ),
              ),
              _Disease(),
              _Contact(),
              const Spacer(),
              BaseButton(
                width: double.infinity,
                height: 56,
                isEnabled: false,
                text: StringRes.save.tr,
                defaultTextStyle: const TextStyle(
                  fontSize: 16,
                  color: ColorRes.fontBlack,
                  fontWeight: FontWeight.w500,
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
}

/// 헤더.
class _Header extends GetView<InjuryCheckController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.injuryCheck.tr,
        showBack: true,
        onPressed: controller.close,
        padding: EdgeInsets.zero,
      );
}

/// 질병.
class _Disease extends GetView<InjuryCheckController> {
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
            inputFormatter: [
              LengthLimitingTextInputFormatter(40),
            ],
          ),
        ),
      );
}

/// 접촉/비접촉.
class _Contact extends GetView<InjuryCheckController> {
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
                    isSelected: controller.directionType.value ==
                        InjuryCheckDirectionType.front,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    onPressed: () {
                      controller.onPressedDirectionType(
                          InjuryCheckDirectionType.front);
                    },
                  ),
                  const SizedBox(width: 10),
                  BaseButton(
                    text: StringRes.back.tr,
                    isSelected: controller.directionType.value ==
                        InjuryCheckDirectionType.back,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    onPressed: () {
                      controller.onPressedDirectionType(
                          InjuryCheckDirectionType.back);
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
                      isSelected: controller.bodyType.value ==
                          InjuryCheckBodyType.upper,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      onPressed: () {
                        controller.onPressedBodyType(InjuryCheckBodyType.upper);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      text: StringRes.lowerBody.tr,
                      isSelected: controller.bodyType.value ==
                          InjuryCheckBodyType.lower,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      onPressed: () {
                        controller.onPressedBodyType(InjuryCheckBodyType.lower);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: controller.directionType.value != null &&
                    controller.bodyType.value == InjuryCheckBodyType.upper,
                child: Row(
                  children: [
                    BaseButton(
                      text: StringRes.torso.tr,
                      isSelected: controller.bodyPartsType.value ==
                          InjuryCheckBodyPartsType.toros,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      onPressed: () {
                        controller.onPressedBodyPartsType(
                            InjuryCheckBodyPartsType.toros);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      text: StringRes.leftArm.tr,
                      isSelected: controller.bodyPartsType.value ==
                          InjuryCheckBodyPartsType.leftArm,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      onPressed: () {
                        controller.onPressedBodyPartsType(
                            InjuryCheckBodyPartsType.leftArm);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      text: StringRes.rightArm.tr,
                      isSelected: controller.bodyPartsType.value ==
                          InjuryCheckBodyPartsType.rightArm,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      onPressed: () {
                        controller.onPressedBodyPartsType(
                            InjuryCheckBodyPartsType.rightArm);
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.directionType.value != null &&
                    controller.bodyType.value == InjuryCheckBodyType.lower,
                child: Row(
                  children: [
                    BaseButton(
                      text: StringRes.leftLeg.tr,
                      isSelected: controller.bodyPartsType.value ==
                          InjuryCheckBodyPartsType.leftLeg,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      onPressed: () {
                        controller.onPressedBodyPartsType(
                            InjuryCheckBodyPartsType.leftLeg);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      text: StringRes.rightLeg.tr,
                      isSelected: controller.bodyPartsType.value ==
                          InjuryCheckBodyPartsType.rightLeg,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      onPressed: () {
                        controller.onPressedBodyPartsType(
                            InjuryCheckBodyPartsType.rightLeg);
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
