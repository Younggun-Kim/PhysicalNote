import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/initializer/app_initializer.dart';
import 'package:physical_note/app/routes/routes.dart';

import 'app/resources/resources.dart';

void main() {
  run();
}

void run() async {
  // Config.environment = environment;

  // FlutterNativeSplash.preserve(
  //   widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  // );

  // initTheme();

  await AppInitializer.init();

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
