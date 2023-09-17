import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/term/term_controller.dart';
import 'package:physical_note/app/ui/widgets/buttons/round_button.dart';

import '../../widgets/widgets.dart';

class TermPage extends GetView<TermController> {
  const TermPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Column(
        children: [
          _Header(),
          const SizedBox(height: 40),
          Text(
            StringRes.acceptTerms.tr,
            style: const TextStyle(
              color: ColorRes.fontBlack,
              fontSize: 32,
              fontWeight: FontWeight.w400,
              height: 1.5,
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
          ),
          const SizedBox(height: 20),
          const LineDivider(),
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
                  ),
                  isChecked: controller.checkService.value,
                  menu: _ArrowRight(),
                  onToggle: controller.onToggleService),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => AppCheckbox(
                text: StringRes.requiredTermPrivacy.tr,
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.fontBlack,
                ),
                isChecked: controller.checkPrivacy.value,
                menu: _ArrowRight(),
                onToggle: controller.onTogglePrivacy),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => RoundButton(
                isEnabled: controller.checkAll.value,
                text: StringRes.next.tr,
                onPressed: controller.onPressedNextButton,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}

/// 헤더.
class _Header extends GetView<TermController> {
  @override
  Widget build(BuildContext context) => Header(
        title: "",
        showBack: true,
        onPressed: controller.onPressedNavigationBackButton,
      );
}

/// Arrow Right 이미지.
class _ArrowRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.icChevronright,
      width: 18,
      height: 18,
      fit: BoxFit.contain,
    );
  }
}
