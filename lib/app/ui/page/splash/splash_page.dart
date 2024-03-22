import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/splash/splash_controller.dart';

import '../../widgets/widgets.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      isFullPage: false,
      safeStatusBar: false,
      safeNavigationBar: false,
      child: Image.asset(
        Assets.splashImage,
        fit: BoxFit.fill,
      ),
    );
  }
}
