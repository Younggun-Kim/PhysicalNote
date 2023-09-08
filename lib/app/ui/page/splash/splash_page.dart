import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child: const Text(
          "Physical Note",
          style: TextStyle(
            color: Colors.lightGreenAccent,
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
