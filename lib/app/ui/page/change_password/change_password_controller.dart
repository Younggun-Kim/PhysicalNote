import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/routes/routes.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordController extends BaseController {
  /// 비밀번호.
  final password = "".obsWithController;

  /// 비밀번호 확인.
  final passwordConfirm = "".obsWithController;

  /// 비밀번호 유효성 검사.
  late final isValidPassword = password.behaviorStream
      .map((event) => Regex.isPassword(event))
      .toObs(false);

  /// 비밀번호 같은지 여부.
  late final isSamePassword = CombineLatestStream(
      [password.behaviorStream, passwordConfirm.behaviorStream],
      (values) => values[0] == values[1]).toObs(false);

  /// 에러 메시지.
  late final errorMessage = CombineLatestStream([
    isValidPassword.behaviorStream,
    isSamePassword.behaviorStream,
  ], (values) {
    if (values[0] == false) {
      logger.i(StringRes.passwordError.tr);
      return StringRes.passwordError.tr;
    } else if (values[1] == false) {
      logger.i(StringRes.passwordNotMatched.tr);
      return StringRes.passwordNotMatched.tr;
    } else {
      logger.i("Matched Password");
      return "";
    }
  }).toObs("");

  /// 로그인 버튼 클릭.
  void onPressedLogin() {
    Get.until((route) => Get.currentRoute == RouteType.LOGIN);
  }
}
