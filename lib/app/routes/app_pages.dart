import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/localization/localization_bindings.dart';
import 'package:physical_note/app/ui/page/localization/localization_page.dart';
import 'package:physical_note/app/ui/page/splash/splash_bingding.dart';
import 'package:physical_note/app/ui/page/splash/splash_page.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.LOCALIZATION,
      page: () => const LocalizationPage(),
      binding: LocalizationBindings(),
    ),
  ];
}
