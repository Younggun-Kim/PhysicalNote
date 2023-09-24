import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete_argument.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';


class FindIdCompleteController extends BaseController {
  /// Arguments.
  final argument = Get.arguments as FindIdCompleteArgument;

  /// 이름.
  late final name = argument.name.obs;

  /// 이메일.
  late final email = argument.email.obs;

  /// 비밀번호 찾기 클릭.
  void onPressedFindPassword() {
  }

  /// 로그인 버튼 클릭.
  void onPressedLogin() async {
    Get.until((route) {
      return Get.currentRoute == RouteType.LOGIN;
    });
  }
}
