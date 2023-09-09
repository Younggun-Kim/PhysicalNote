import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/routes/app_pages.dart';

import 'app/resources/resources.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.SPLASH,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    translations: Languages(),
    locale: Get.deviceLocale,
    fallbackLocale: const Locale('ko', 'KR'), // Default Locale
  ));
}
