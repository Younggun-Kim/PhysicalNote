import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(Assets.backgroundTop),
          ),
          Center(child: SvgPicture.asset(Assets.logo),),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(Assets.backgroundBottom),
          ),
        ],
      ),
    );
  }
}
