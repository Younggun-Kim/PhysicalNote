import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/routes/app_pages.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.SPLASH,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}
