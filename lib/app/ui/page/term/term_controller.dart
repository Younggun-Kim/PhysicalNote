import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_pass_request_model.dart';
import 'package:physical_note/app/data/login/model/post_pass_response_model.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up_args.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/network/model/server_response_fail/server_response_fail_model.dart';

class TermController extends LifecycleController {
  /// 서비스 이용 약관.
  var checkService = false.obs;

  /// 개인정보 수집 및 이용동의.
  var checkPrivacy = false.obs;

  /// 전체동의.
  late final _checkAll = CombineLatestStream([
    checkService.behaviorStream,
    checkPrivacy.behaviorStream,
  ], (values) => values.every((element) => element));

  late final checkAll = _checkAll.toObs(false);

  /// 전체동의 클릭.
  void onToggleAll() {
    final isOn = !checkAll.value;
    checkService.value = isOn;
    checkPrivacy.value = isOn;
  }

  /// 서비스 이용약관 클릭.
  void onToggleService() {
    checkService.toggle();
  }

  /// 서비스 이용약관 웹 페이지 이동.
  void onPressedService() {
    Get.find<OutLink>().moveServiceTerm();
  }

  /// 개인정보 클릭.
  void onTogglePrivacy() {
    checkPrivacy.toggle();
  }

  /// 서비스 이용약관 웹 페이지 이동.
  void onPressedPrivacy() {
    Get.find<OutLink>().movePrivacyTerm();
  }

  /// 다음 버튼 클릭.
  Future<void> onPressedNextButton() async {
    final passToken = await Get.toNamed(RouteType.PASS) as String?;

    if (passToken != null) {
      final passInfo = await _postLoginPass(passToken);
      final name = passInfo?.passInfo?.utf8_name;
      final phone = passInfo?.passInfo?.mobileno;

      if (name == null || phone == null) {
        showToast("패스 정보 조회 실패.");
        return;
      }

      final args = SignUpArgs(
        passToken: passToken,
        name: name,
        phone: phone,
      );
      Get.toNamed(RouteType.SIGN_UP, arguments: args);
    }
  }

  /// 패스 정보 조회.
  Future<PostPassResponseModel?> _postLoginPass(String passToken) async {
    setLoading(true);
    final loginApi = Get.find<LoginAPI>();
    final requestData = PostPassRequestModel(
      code: passToken,
      loginType: UserSnsType.idPw.name,
    );
    final response = await loginApi.postLoginPass(requestData);
    late PostPassResponseModel? result;
    if (response is PostPassResponseModel) {
      result = response;
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
      result = null;
    }

    setLoading(false);
    return result;
  }
}
