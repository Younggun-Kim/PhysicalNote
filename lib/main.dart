import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/routes/routes.dart';

import 'app/resources/resources.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: RouteType.SPLASH,
    defaultTransition: Transition.fade,
    getPages: Routes.pages,
    translations: AppTranslations(),
    locale: Get.deviceLocale,
    fallbackLocale: const Locale('ko', 'KR'), // Default Locale
  ));
}
