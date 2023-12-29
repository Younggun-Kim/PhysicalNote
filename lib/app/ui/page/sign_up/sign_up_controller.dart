import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up_args.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class SignUpController extends BaseController {
  final args = Get.arguments as SignUpArgs;

  /// 이름.
  final name = "".obsWithController;

  /// 이름 유효성 검사.
  late final _isValidName =
      name.behaviorStream.map((event) => event.length > 2);
  late final isValidName = _isValidName.not().toObs(false);

  /// 이메일.
  final email = "".obsWithController;

  /// 이메일 유효성 검사.
  late final _isValidEmail = email.behaviorStream.map((event) => event.isEmail);
  late final isValidEmail = _isValidEmail.not().toObs(false);

  /// 전화번호.
  final phoneNumber = "".obsWithController;

  /// 전화번호 유효성 검사.
  late final _isValidPhoneNumber =
      phoneNumber.behaviorStream.map((event) => Regex.isPhoneNumber(event));
  late final isValidPhoneNumber = _isValidPhoneNumber.not().toObs(false);

  /// 비밀번호.
  final password = "".obsWithController;

  /// 비밀번호 확인.
  final passwordConfirm = "".obsWithController;

  /// 비밀번호 유효성 검사.
  late final _isValidPassword = CombineLatestStream(
    [
      password.behaviorStream,
      passwordConfirm.behaviorStream,
    ],
    (values) => Regex.isPassword(values[0]) && (values[0] == values[1]),
  );

  late final isValidPassword = _isValidPassword.not().toObs(false);

  /// 로그인 버튼 Enabled 여부
  late final isEnabledLoginButton = CombineLatestStream(
    [
      isValidName.behaviorStream,
      isValidEmail.behaviorStream,
      isValidPhoneNumber.behaviorStream,
      isValidPassword.behaviorStream,
    ],
    (values) {
      return values.every((element) => element == false);
    },
  ).toObs(false);

  /// 뒤로가기 클릭.
  void onPressedBackButton() {
    close();
  }

  /// 로그인 버튼 클릭.
  void onPressedLoginButton() async {
    unFocus();
    await Future.delayed(const Duration(milliseconds: 300));
    await postLogin();
  }

  /// 로그인 요청.
  Future<void> postLogin() async {
    setLoading(true);
    final loginApi = Get.find<LoginAPI>();
    final requestData = PostLoginSignInRequestModel(
      loginId: email.value,
      passCode: args.passToken,
      password: password.value,
      type: UserSnsType.idPw.name,
    );
    final response = await loginApi.postLoginSignIn(requestData: requestData);

    if (response is PostLoginSignInResponseModel) {
      final token = response.token;
      if (response.status == false || token == null) {
        showToast(response.message ?? "서버 에러");
      } else {
        // 토큰 저장 후 홈으로 이동.
        final userStorage = UserStorage();
        userStorage.apiKey.val = token;
        Get.offAllNamed(RouteType.HOME);
      }
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }

    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }
}
