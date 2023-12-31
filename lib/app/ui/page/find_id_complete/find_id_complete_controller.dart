import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete_argument.dart';
import 'package:physical_note/app/ui/page/find_id_complete/items/find_id_compete_item_ui_state.dart';
import 'package:physical_note/app/ui/page/find_password/find_password_args.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';

class FindIdCompleteController extends BaseController {
  /// Arguments.
  final argument = Get.arguments as FindIdCompleteArgument;

  /// 이름.
  late final name = argument.name.obs;

  /// 전화번호.
  late final phone = argument.phone.obs;

  /// 계정.
  final accounts = <FindIdCompleteItemUiState>[
    FindIdCompleteItemUiState(snsType: UserSnsType.apple, id: null),
    FindIdCompleteItemUiState(snsType: UserSnsType.kakao, id: null),
    FindIdCompleteItemUiState(snsType: UserSnsType.naver, id: null),
    FindIdCompleteItemUiState(
        snsType: UserSnsType.idPw, id: "connter@test.com"),
  ].obs;

  /// 이메일 계정 여부.
  late final hasEmail = accounts.behaviorStream
      .map(
        (event) => event.any((element) => element.snsType == UserSnsType.idPw),
      )
      .toObs(false);

  /// 비밀번호 찾기 클릭.
  void onPressedFindPassword() {
    Get.until((route) => Get.currentRoute == RouteType.LOGIN);

    final args = FindPasswordArgs(name: argument.name, email: argument.phone);
    Get.toNamed(RouteType.FIND_PASSWORD, arguments: args);
  }

  /// 로그인 버튼 클릭.
  void onPressedLogin() {
    Get.until((route) => Get.currentRoute == RouteType.LOGIN);
  }
}
