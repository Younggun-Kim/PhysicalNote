import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/data/common/model/message_response_model.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_find_id_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete.dart';
import 'package:physical_note/app/utils/utils.dart';

class FindIdController extends BaseController {
  final phone = "".obsWithController;

  final authCode = "".obsWithController;

  var email = '';

  /// 전화번호 Validation;
  late final isValidPhoneNumber = phone.behaviorStream
      .map((event) => Regex.isPhoneNumber(event))
      .toObs(false);

  /// 인증 코드 전송 요청 여부.
  final isRequestAuth = false.obs;

  /// 인증 코드 인증 여부.
  final isAuth = false.obs;

  /// 인증 요청 버튼 클릭.
  void onPressedAuthButton() async {
    setLoading(true);
    final commonApi = Get.find<CommonAPI>();
    final response = await commonApi.postAuthPhoneSend(phone: phone.value);

    if (response is MessageResponseModel) {
      if (response.status == true) {
        isRequestAuth.value = true;
      }
      showToast(response.message ?? StringRes.serverError.tr);
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    setLoading(false);
  }

  void onChangedAuthCode() async {
    final code = authCode.value;
    if (code.length == 6) {
      setLoading(true);
      isAuth.value = false;
      final loginApi = Get.find<LoginAPI>();
      final response =
          await loginApi.postLoginFindId(authCode: code, phone: phone.value);

      if (response is PostLoginFindIdResponseModel) {
        final id = response.userLoginId;
        if (response.status == true && id != null) {
          isAuth.value = true;
          email = id;
        }
        showToast(response.message ?? StringRes.serverError.tr);
      } else {
        final message = (response as ServerResponseFailModel?)?.toastMessage ??
            StringRes.serverError.tr;
        showToast(message);
      }
      Future.delayed(const Duration(seconds: 1));
      setLoading(false);
    }
  }

  void onPressedNextButton() {
    if (isAuth.value == true && email.isNotEmpty) {
      Get.toNamed(
        RouteType.FIND_ID_COMPLETE,
        arguments: FindIdCompleteArgument(phone: phone.value, email: email),
      );
    }
  }
}
