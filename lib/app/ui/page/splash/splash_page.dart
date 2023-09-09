import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/splash/splash_controller.dart';
import 'package:physical_note/app/utils/base/widget/page_root.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          StringRes.appName.tr,
          style: const TextStyle(
            color: ColorRes.primary,
            fontSize: 36,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
