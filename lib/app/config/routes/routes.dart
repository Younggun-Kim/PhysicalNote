import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/change_password/change_password.dart';
import 'package:physical_note/app/ui/page/find_id/find_id.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete.dart';
import 'package:physical_note/app/ui/page/find_password/find_password.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/information_registration/information_registration.dart';
import 'package:physical_note/app/ui/page/localization/localization.dart';
import 'package:physical_note/app/ui/page/login/login.dart';
import 'package:physical_note/app/ui/page/my_information/my_information.dart';
import 'package:physical_note/app/ui/page/search_category/search_category.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up.dart';
import 'package:physical_note/app/ui/page/splash/splash.dart';
import 'package:physical_note/app/ui/page/term/term.dart';

part 'route_type.dart';

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
      name: RouteType.FIND_ID_COMPLETE,
      page: () => const FindIdCompletePage(),
      binding: FindIdCompleteBindings(),
    ),
    GetPage(
      name: RouteType.FIND_PASSWORD,
      page: () => const FindPasswordPage(),
      binding: FindPasswordBindings(),
    ),
    GetPage(
      name: RouteType.CHANGE_PASSWORD,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBindings(),
    ),
    GetPage(
      name: RouteType.SIGN_UP,
      page: () => const SignUpPage(),
      binding: SignUpBindings(),
      maintainState: false,
    ),
    GetPage(
      name: RouteType.TERM,
      page: () => const TermPage(),
      binding: TermBindings(),
      maintainState: false,
    ),
    GetPage(
      name: RouteType.HOME,
      page: () => const HomePage(),
      binding: HomeBindings(),
      maintainState: false,
    ),
    GetPage(
      name: RouteType.INFORMATION_REGISTRATION,
      page: () => const InformationRegistrationPage(),
      binding: InformationRegistrationBindings(),
      maintainState: false,
    ),
    GetPage(
      name: RouteType.SEARCH_CATEGORY,
      page: () => const SearchCategoryPage(),
      binding: SearchCategoryBindings(),
      maintainState: false,
    ),
    GetPage(
      name: RouteType.MY_INFORMATION,
      page: () => const MyInformationPage(),
      binding: MyInformationBindings(),
      maintainState: false,
    ),
  ];
}
