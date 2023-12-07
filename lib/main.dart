import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/initializer/app_initializer.dart';
import 'package:physical_note/app/config/routes/routes.dart';

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

  // CERTIFICATE_VERIFY_FAILED 방지.
  HttpOverrides.global = MyHttpOverrides();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: RouteType.SPLASH,
    // initialRoute: RouteType.TEST,
    defaultTransition: Transition.fade,
    getPages: Routes.pages,
    translations: AppTranslations(),
    locale: Get.deviceLocale,
    fallbackLocale: const Locale('ko', 'KR'), // Default Locale
  ));
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
