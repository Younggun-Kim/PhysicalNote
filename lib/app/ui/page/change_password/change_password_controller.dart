import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_change_password_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/change_password/change_password_args.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordController extends BaseController {
  final args = Get.arguments as ChangePasswordArgs;

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
  void onPressedLogin() async {
    final isChanged = await _changePassword(
        passCode: args.passCode, password: password.value);

    if (isChanged) {
      Get.until((route) => Get.currentRoute == RouteType.LOGIN);
    } else {
      logger.e("비밀번호 변경 실패.");
    }
  }

  /// API - 비밀번호 변경
  Future<bool> _changePassword({
    required String passCode,
    required String password,
  }) async {
    setLoading(true);
    final loginApi = Get.find<LoginAPI>();
    final response = await loginApi.postLoginFindPwStep2(
        passCode: passCode, password: password);

    bool result = false;
    if (response is PostChangePasswordResponseModel) {
      result = response.status == true;
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    setLoading(false);
    return result;
  }
}
