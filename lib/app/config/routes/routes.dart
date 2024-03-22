import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/change_password/change_password.dart';
import 'package:physical_note/app/ui/page/find_id/find_id.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete.dart';
import 'package:physical_note/app/ui/page/find_password/find_password.dart';
import 'package:physical_note/app/ui/page/information_registration/information_registration.dart';
import 'package:physical_note/app/ui/page/information_registration_guide/information_registration_guide.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check.dart';
import 'package:physical_note/app/ui/page/inline_webview/inline_webview.dart';
import 'package:physical_note/app/ui/page/localization/localization.dart';
import 'package:physical_note/app/ui/page/login/login.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/page/my_information/my_information.dart';
import 'package:physical_note/app/ui/page/naver/naver_login.dart';
import 'package:physical_note/app/ui/page/pass/pass.dart';
import 'package:physical_note/app/ui/page/position/position.dart';
import 'package:physical_note/app/ui/page/search_category/search_category.dart';
import 'package:physical_note/app/ui/page/search_teams/search_teams.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up.dart';
import 'package:physical_note/app/ui/page/splash/splash.dart';
import 'package:physical_note/app/ui/page/team_request/team_request.dart';
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
      name: RouteType.MAIN,
      page: () => const MainScreenPage(),
      binding: MainScreenBindings(),
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
      name: RouteType.FIND_ID_COMPLETE,
      page: () => const FindIdCompletePage(),
      binding: FindIdCompleteBindings(),
    ),
    GetPage(
      name: RouteType.FIND_ID,
      page: () => const FindIdPage(),
      binding: FindIdBindings(),
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
    // GetPage(
    //   name: RouteType.HOME,
    //   page: () => const HomePage(),
    //   binding: HomeBindings(),
    //   maintainState: false,
    // ),
    // GetPage(
    //   name: RouteType.DATA,
    //   page: () => const DataPage(),
    //   binding: DataBindings(),
    //   maintainState: false,
    // ),
    // GetPage(
    //   name: RouteType.FEEDBACK,
    //   page: () => const FeedbackPage(),
    //   binding: FeedbackBindings(),
    //   maintainState: false,
    // ),
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
    GetPage(
      name: RouteType.SEARCH_TEAMS,
      page: () => const SearchTeamsPage(),
      binding: SearchTeamsBindings(),
    ),
    GetPage(
      name: RouteType.INFORMATION_REGISTRATION_GUIDE,
      page: () => const InformationRegistrationGuidePage(),
      binding: InformationRegistrationGuideBindings(),
    ),
    GetPage(
      name: RouteType.INJURY_CHECK,
      page: () => const InjuryCheckPage(),
      binding: InjuryCheckBindings(),
    ),
    GetPage(
      name: RouteType.PASS,
      page: () => const PassPage(),
      binding: PassBindings(),
    ),
    GetPage(
      name: RouteType.INLINE_WEBVIEW,
      page: () => const InlineWebviewPage(),
      binding: InlineWebviewBindings(),
    ),
    GetPage(
      name: RouteType.NAVER_LOGIN,
      page: () => const NaverLoginPage(),
      binding: NaverLoginBindings(),
    ),
    GetPage(
      name: RouteType.POSITION,
      page: () => const PositionPage(),
      binding: PositionBindings(),
    ),
    GetPage(
      name: RouteType.TEAM_REQUEST,
      page: () => const TeamRequestPage(),
      binding: TeamRequestBindings(),
    ),
  ];
}
