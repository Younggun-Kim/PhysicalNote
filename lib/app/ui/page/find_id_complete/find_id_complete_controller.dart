import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/sns_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/ui/page/change_password/change_password_args.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete_argument.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';

import 'items/find_id_compete_item_ui_state.dart';

class FindIdCompleteController extends BaseController {
  /// Arguments.
  final argument = Get.arguments as FindIdCompleteArgument;

  /// 이름.
  late final name = argument.name.obs;

  /// 전화번호.
  late final phone = argument.phone.obs;

  /// 계정.
  late final accounts = argument.accounts.obs;

  /// 이메일 계정 여부.
  late final hasEmail = accounts.behaviorStream
      .map(
        (event) => _getEmailAccount(event),
      )
      .map((event) => event?.snsType == UserSnsType.idPw)
      .toObs(false);

  /// 비밀번호 찾기 클릭.
  void onPressedFindPassword() async {
    final id = _getEmailAccount(accounts.toList())?.id;

    if (id == null) {
      return;
    }

    Get.until((route) => Get.currentRoute == RouteType.LOGIN);

    final args = ChangePasswordArgs(
      name: argument.name,
      id: id,
      passCode: argument.passCode,
    );
    Get.toNamed(RouteType.CHANGE_PASSWORD, arguments: args);
  }

  /// 로그인 버튼 클릭.
  void onPressedLogin() {
    Get.until((route) => Get.currentRoute == RouteType.LOGIN);
  }

  /// Email 계정 가져오기.
  FindIdCompleteItemUiState? _getEmailAccount(
      List<FindIdCompleteItemUiState>? accounts) {
    return accounts?.firstWhereOrNull(
      (element) => element.snsType == UserSnsType.idPw,
    );
  }
}
