import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/information_registration_guide/information_registration_guide.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class InformationRegistrationGuidePage
    extends GetView<InformationRegistrationGuideController> {
  const InformationRegistrationGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      isFullPage: false,
      safeStatusBar: false,
      safeNavigationBar: false,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(Assets.backgroundTop),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(Assets.backgroundBottom),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 200),
              Text(
                controller.args.hasWorkout
                    ? StringRes.noRegisteredTeam.tr
                    : StringRes.informationRegistrationGuide.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.fontBlack,
                ),
              ),
              const SizedBox(height: 46),
              BaseButton(
                width: 180,
                height: 56,
                defaultBackgroundColor: ColorRes.primary,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                text: controller.args.hasWorkout
                    ? StringRes.teamSelect.tr
                    : StringRes.doInformationRegistration.tr,
                defaultTextStyle: const TextStyle(
                  fontSize: 16,
                  color: ColorRes.white,
                  fontWeight: FontWeight.w500,
                ),
                onPressed: controller.onPressedButton,
              ),
            ],
          ).paddingSymmetric(horizontal: 36),
        ],
      ),
    );
  }
}
