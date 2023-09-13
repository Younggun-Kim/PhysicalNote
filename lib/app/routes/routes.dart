import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/find_id/find_id.dart';
import 'package:physical_note/app/ui/page/find_pw/find_pw.dart';
import 'package:physical_note/app/ui/page/localization/localization.dart';
import 'package:physical_note/app/ui/page/login/login.dart';
import 'package:physical_note/app/ui/page/splash/splash.dart';


part './route_type.dart';

class Routes {
  static final pages = [
    GetPage(
      name: RouteType.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: RouteType.LOCALIZATION,
      page: () => const LocalizationPage(),
      binding: LocalizationBindings(),
    ),
    GetPage(
      name: RouteType.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: RouteType.FIND_ID,
      page: () => const FindIdPage(),
      binding: FindIdBindings(),
    ),
    GetPage(
      name: RouteType.FIND_PW,
      page: () => const FindPwPage(),
      binding: FindPwBindings(),
    ),
  ];
}
