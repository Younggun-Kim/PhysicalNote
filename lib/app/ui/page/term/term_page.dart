import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/term/term_controller.dart';

import '../../widgets/widgets.dart';

class TermPage extends GetView<TermController> {
  const TermPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Column(
        children: [
          _Header(),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              StringRes.acceptTerms.tr,
              style: const TextStyle(
                color: ColorRes.fontBlack,
                fontSize: 32,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 90),
          Obx(
            () => AppCheckbox(
                text: StringRes.allAgree.tr,
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontBlack,
                ),
                isChecked: controller.checkAll.value,
                onToggle: controller.onToggleAll),
          ).paddingSymmetric(horizontal: 20),
          const SizedBox(height: 20),
          const LineDivider().paddingSymmetric(horizontal: 20),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => AppCheckbox(
                  text: StringRes.requiredTermService.tr,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.7,
                  ),
                  isChecked: controller.checkService.value,
                  menu: InkWellOver(
                    onTap: controller.onPressedService,
                    child: SvgPicture.asset(Assets.icChevronright),
                  ),
                  onToggle: controller.onToggleService),
            ),
          ).paddingSymmetric(horizontal: 20),
          const SizedBox(height: 20),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppCheckbox(
                crossAxisAlignment: CrossAxisAlignment.start,
                text: StringRes.requiredTermPrivacy.tr,
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.fontBlack,
                  height: 20 / 14,
                  letterSpacing: -0.7,
                ),
                isChecked: controller.checkPrivacy.value,
                menu: InkWellOver(
                  onTap: controller.onPressedPrivacy,
                  child: SvgPicture.asset(Assets.icChevronright),
                ),
                onToggle: controller.onTogglePrivacy,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => RoundButton(
                isEnabled: controller.checkAll.value,
                text: StringRes.agree.tr,
                onPressed: controller.onPressedNextButton,
              ),
            ),
          ).paddingSymmetric(horizontal: 20),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// 헤더.
class _Header extends GetView<TermController> {
  @override
  Widget build(BuildContext context) => Header(
        title: "",
        showBack: true,
        onPressed: controller.close,
      );
}
