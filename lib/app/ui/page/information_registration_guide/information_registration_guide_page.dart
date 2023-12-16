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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.splash),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
