import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/term_type.dart';
import 'package:physical_note/app/config/constant/sns_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/data/common/model/get_term_response_model.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_request_model.dart';
import 'package:physical_note/app/data/login/model/post_pass_request_model.dart';
import 'package:physical_note/app/data/login/model/post_pass_response_model.dart';
import 'package:physical_note/app/resources/strings/translations.dart';
import 'package:physical_note/app/ui/page/inline_webview/inline_webview_args.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up_args.dart';
import 'package:physical_note/app/ui/page/term/term_args.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/network/model/server_response_fail/server_response_fail_model.dart';

class TermController extends LifecycleController {
  var args = Get.arguments as TermArgs;

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
    _showTerm(TermType.service);
  }

  /// 개인정보 클릭.
  void onTogglePrivacy() {
    checkPrivacy.toggle();
  }

  /// 서비스 이용약관 웹 페이지 이동.
  void onPressedPrivacy() {
    _showTerm(TermType.privacy);
  }

  /// 다음 버튼 클릭.
  // TODO: 추후 SNS 추가시 변경 필요.
  Future<void> onPressedNextButton() async {
    // final passToken = await Get.toNamed(RouteType.PASS) as String?;
    //
    // if (passToken != null) {
    //   final passInfo = await _postLoginPass(passToken);
    //   final name = passInfo?.passInfo?.utf8_name;
    //   final phone = passInfo?.passInfo?.mobileno;
    //
    //   if (name == null || phone == null) {
    //     showToast("패스 정보 조회 실패.");
    //     return;
    //   }
    //
    //   /// IdPw는 회원가입 화면으로 이동.
    //   if (args.snsType == UserSnsType.idPw) {
    //     final args = SignUpArgs(
    //       passToken: passToken,
    //       name: name,
    //       phone: phone,
    //     );
    //     Get.toNamed(RouteType.SIGN_UP, arguments: args);
    //   } else if (args.snsType == UserSnsType.apple) {
    //     close(result: passToken);
    //   } else {
    //     /// 네이버, 카카오는 회원가입 API.
    //     _postLoginSignIn(passToken);
    //   }
    // }
    /// IdPw는 회원가입 화면으로 이동.
    if (args.snsType == UserSnsType.idPw) {
      Get.toNamed(RouteType.SIGN_UP);
    } else {

    }
  }

  /// 패스 정보 조회.
  // TODO: 추후 SNS 추가시 변경 필요.
  Future<PostPassResponseModel?> _postLoginPass(String passToken) async {
    setLoading(true);
    final loginApi = Get.find<LoginAPI>();
    final requestData = PostPassRequestModel(
      code: passToken,
      loginType: args.snsType.toString(),
    );
    final response = await loginApi.postLoginPass(requestData);
    late PostPassResponseModel? result;
    if (response is PostPassResponseModel) {
      result = response;
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
      result = null;
    }

    setLoading(false);
    return result;
  }

  /// API - 회원가입.
  // TODO: 추후 SNS 추가시 변경 필요.
  Future<void> _postLoginSignIn(String passToken) async {
    setLoading(true);
    final loginProcess = Get.find<LoginProcess>();
    final requestData = PostLoginSignInRequestModel(
      loginId: null,
      passCode: passToken,
      password: args.accessToken,
      type: args.snsType.toString(),
      name: '',
      cellphoneNo: '',
      birth: '',
      gender: '',
    );
    final moveType = await loginProcess.signInAndMove(requestData: requestData);
    loginProcess.movePage(moveType);
    setLoading(false);
  }

  /// API - 약관 조회.
  Future<String?> _getTerm(TermType type) async {
    setLoading(true);
    final commonApi = Get.find<CommonAPI>();
    final response = await commonApi.getTerms(type: type);
    String? resultHtml;

    if (response is GetTermResponseModel) {
      resultHtml = response.content;
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }

    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);

    return resultHtml;
  }

  /// 약관 보기.
  void _showTerm(TermType type) async {
    final html = await _getTerm(type);
    if (html == null) {
      return;
    }

    final args = InlineWebviewArgs(html: html);
    Get.toNamed(RouteType.INLINE_WEBVIEW, arguments: args);
  }
}
