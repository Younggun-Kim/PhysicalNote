import 'package:flutter/material.dart';
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
      isFullPage: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.splash),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 180),
            Text(
              StringRes.informationRegistrationGuide.tr,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 20),
            RoundButton(
              text: StringRes.doInformationRegistration.tr,
              onPressed: controller.onPressedButton,
            ),
          ],
        ),
      ),
    );
  }
}
